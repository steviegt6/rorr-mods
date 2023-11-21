using System;

namespace Tomat.Umbrella.Logging;

public interface ILogLevel {
    string Name { get; }

    float Priority { get; }

    ConsoleColor Color { get; }
}

public readonly record struct LogLevel(string Name, float Priority, ConsoleColor Color) : ILogLevel;
