using System;
using Tomat.Umbrella.Logging;

namespace Tomat.Umbrella.Host.Platform;

internal class LinuxPlatform : IPlatform {
    public void ShowMessageBox(string title, string message) {
        throw new NotImplementedException();
    }

    public bool InitializeConsole() {
        throw new NotImplementedException();
    }

    public bool InitializeSteam(Logger logger) {
        throw new NotImplementedException();
    }
}
