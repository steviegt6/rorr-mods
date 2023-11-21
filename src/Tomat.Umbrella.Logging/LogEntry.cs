using System;

namespace Tomat.Umbrella.Logging;

public interface ILogEntry {
    DateTime Timestamp { get; }

    ILogLevel Level { get; }

    string? Source { get; }

    string Message { get; }
}

public readonly record struct LogEntry(DateTime Timestamp, ILogLevel Level, string? Source, string Message) : ILogEntry;
