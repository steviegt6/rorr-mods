﻿namespace Tomat.Umbrella.Host.Platform;

public class LinuxPlatform : IPlatform {
    public void ShowMessageBox(string title, string message) {
        throw new System.NotImplementedException();
    }

    public bool InitializeConsole() {
        throw new System.NotImplementedException();
    }
}
