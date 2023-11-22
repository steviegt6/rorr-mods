using System;
using System.IO;

namespace Tomat.Umbrella.Paths;

public static class PathHelper {
    public const string UMBRELLA_DIR = ".umbrella";
    public const string LOGS_DIR = "logs";

    public static string UmbrellaLogs => Path.Combine(UMBRELLA_DIR, LOGS_DIR);

    public static string GetLatestLogPath() {
        var path = "latest.log";
        var counter = 0;

        while (File.Exists(path)) {
            try {
                File.Delete(path);
            }
            catch (IOException) {
                path = $"latest.{++counter}.log";
            }
        }

        return Path.GetFullPath(path);
    }

    public static string GetLogPathForDateTime(DateTime time) {
        Directory.CreateDirectory(UmbrellaLogs);

        var path = $"{time:yyyy-MM-dd_HH-mm-ss}.log";
        var counter = 0;

        // Should never have conflicts, but always be safe for things like logs.
        while (File.Exists(path)) {
            try {
                File.Delete(path);
            }
            catch (IOException) {
                path = $"{time:yyyy-MM-dd_HH-mm-ss}.{++counter}.log";
            }
        }

        return Path.GetFullPath(Path.Combine(UmbrellaLogs, path));
    }

    public static string GetLogPathForNow() {
        return GetLogPathForDateTime(DateTime.Now);
    }
}
