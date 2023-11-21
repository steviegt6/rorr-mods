using System;
using System.IO;
using System.Runtime.Versioning;
using Windows.Win32;
using Windows.Win32.System.Console;
using Windows.Win32.UI.WindowsAndMessaging;
using Microsoft.Win32.SafeHandles;

namespace Tomat.Umbrella.Host.Platform;

public class WindowsPlatform : IPlatform {
    [SupportedOSPlatform("windows5.0")]
    public void ShowMessageBox(string title, string message) {
        PInvoke.MessageBox(default, title, message, MESSAGEBOX_STYLE.MB_OK);
    }

    [SupportedOSPlatform("windows5.1.2600")]
    public bool InitializeConsole() {
        PInvoke.AllocConsole();
        
        Console.SetIn(new StreamReader("CONIN$"));
        Console.SetOut(new StreamWriter("CONOUT$") {
            AutoFlush = true,
        });
        Console.SetError(new StreamWriter("CONOUT$") {
            AutoFlush = true,
        });

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
}
