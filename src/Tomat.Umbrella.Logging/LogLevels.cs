using System;

namespace Tomat.Umbrella.Logging;

public static class LogLevels {
    public static readonly ILogLevel TRACE = new LogLevel("TRACE", 10f, ConsoleColor.DarkGray);
    public static readonly ILogLevel DEBUG = new LogLevel("DEBUG", 20f, ConsoleColor.Gray);
    public static readonly ILogLevel INFO = new LogLevel("INFO", 30f, ConsoleColor.White);
    public static readonly ILogLevel WARN = new LogLevel("WARN", 40f, ConsoleColor.Yellow);
    public static readonly ILogLevel ERROR = new LogLevel("ERROR", 50f, ConsoleColor.Red);
    public static readonly ILogLevel FATAL = new LogLevel("FATAL", 60f, ConsoleColor.DarkRed);
}
