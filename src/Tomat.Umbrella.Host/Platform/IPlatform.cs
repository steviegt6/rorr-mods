using System;

namespace Tomat.Umbrella.Host.Platform;

public interface IPlatform {
    void ShowMessageBox(string title, string message);

    bool InitializeConsole();

    public static IPlatform MakePlatform() {
        if (OperatingSystem.IsWindows())
            return new WindowsPlatform();
        if (OperatingSystem.IsLinux())
            return new LinuxPlatform();
        if (OperatingSystem.IsMacOS())
            return new MacOsPlatform();

        throw new PlatformNotSupportedException("Could not resolve a platform implementation for the current operating system.");
    }
}
