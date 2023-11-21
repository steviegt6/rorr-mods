using System;

namespace Tomat.Umbrella.Logging;

public sealed class Logger {
    public string Name { get; }

    public ILogWriter LogWriter { get; }

    public Logger(string name, ILogWriter logWriter) {
        Name = name;
        LogWriter = logWriter;
    }

    public void Trace(string message) {
        Log(LogLevels.TRACE, message);
    }

    public void Debug(string message) {
        Log(LogLevels.DEBUG, message);
    }

    public void Info(string message) {
        Log(LogLevels.INFO, message);
    }

    public void Warn(string message) {
        Log(LogLevels.WARN, message);
    }

    public void Error(string message) {
        Log(LogLevels.ERROR, message);
    }

    public void Fatal(string message) {
        Log(LogLevels.FATAL, message);
    }

    private void Log(ILogLevel level, string message) {
        Write(new LogEntry(DateTime.Now, level, Name, message));
    }

    private void Write(ILogEntry entry) {
        LogWriter.Write(entry);
    }
}

public static class LoggerExtensions {
    public static Logger MakeChildWithName(this Logger logger, string name) {
        return new Logger(logger.Name + "::" + name, logger.LogWriter);
    }

    public static Logger MakeChildFromType(this Logger logger, Type type) {
        var name = type.FullName ?? type.Name;

        if (!name.Contains('.'))
            return logger.MakeChildWithName(name);

        var assemblyName = type.Assembly.GetName().Name;
        if (assemblyName is null)
            return logger.MakeChildWithName(name);

        var nameParts = name[(assemblyName.Length + 1)..].Split('.');

        for (var i = 0; i < nameParts.Length - 1; i++) {
            if (nameParts[i].Length > 4)
                nameParts[i] = nameParts[i][..4];
        }

        return logger.MakeChildWithName(assemblyName + '.' + string.Join('.', nameParts));
    }
}
