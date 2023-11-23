using System;
using System.Runtime.InteropServices;
using System.Runtime.Versioning;
using Windows.Win32;
using Windows.Win32.System.Console;
using Windows.Win32.UI.WindowsAndMessaging;
using Microsoft.Win32.SafeHandles;
using Tomat.Umbrella.Logging;
using System.IO;

namespace Tomat.Umbrella.Host.Platform;

internal class WindowsPlatform : IPlatform {
    private delegate bool SteamApiInit();
    private delegate bool SteamApiIsSteamRunning();

    [SupportedOSPlatform("windows5.0")]
    public void ShowMessageBox(string title, string message) {
        PInvoke.MessageBox(default, title, message, MESSAGEBOX_STYLE.MB_OK);
    }

    [SupportedOSPlatform("windows5.1.2600")]
    public bool InitializeConsole() {
        PInvoke.AllocConsole();

        Console.SetIn(new StreamReader("CONIN$"));
        Console.SetOut(new StreamWriter("CONOUT$"));
        Console.SetError(new StreamWriter("CONOUT$"));

        const string os = "Windows";
        var arch = Environment.Is64BitProcess ? "x64" : "x86";
#if RELEASE
        const string configuration = "Release";
#elif DEBUG
        const string configuration = "Debug";
#else
        const string configuration = "Unknown Configuration";
#endif

        var title = $"Tomat.Umbrella.Host - {os} {arch} ({configuration})";
        PInvoke.SetConsoleTitle(title);

        var handle = PInvoke.GetStdHandle(STD_HANDLE.STD_INPUT_HANDLE);
        PInvoke.GetConsoleMode(new SafePipeHandle(handle.Value, false), out var mode);
        PInvoke.SetConsoleMode(new SafePipeHandle(handle.Value, false), CONSOLE_MODE.ENABLE_EXTENDED_FLAGS | (mode & ~CONSOLE_MODE.ENABLE_QUICK_EDIT_MODE));
        PInvoke.CloseHandle(handle);

        return true;
    }

    [SupportedOSPlatform("windows5.1.2600")]
    public bool InitializeSteam(Logger logger) {
        logger = logger.MakeChildWithName("SteamInit");

        logger.Debug("Attempting to load steam_api");
        string[] steamApiPaths = { "steam_api.dll", "steam_api64.dll" };

        nint steamApi = 0;

        foreach (var path in steamApiPaths) {
            if (!NativeLibrary.TryLoad(path, out steamApi))
                continue;

            logger.Debug($"Loaded steam_api from path: \"{path}\"");
            break;
        }

        if (steamApi == 0) {
            logger.Warn("Failed to load steam_api; assuming non-Steam game.");
            return true;
        }

        if (!NativeLibrary.TryGetExport(steamApi, "SteamAPI_Init", out var steamApiInit)) {
            logger.Error("Failed to get SteamAPI_Init export from steam_api.");
            return false;
        }

        if (!NativeLibrary.TryGetExport(steamApi, "SteamAPI_IsSteamRunning", out var steamApiShutdown)) {
            logger.Error("Failed to get SteamAPI_IsSteamRunning export from steam_api.");
            return false;
        }

        var init = Marshal.GetDelegateForFunctionPointer<SteamApiInit>(steamApiInit);
        var isSteamRunning = Marshal.GetDelegateForFunctionPointer<SteamApiIsSteamRunning>(steamApiShutdown);

        if (!init()) {
            logger.Error("SteamAPI_Init failed.");
            return false;
        }

        if (!isSteamRunning()) {
            logger.Warn("SteamAPI_IsSteamRunning returned false; assuming non-Steam game.");
            return false;
        }

        return true;
    }
}
