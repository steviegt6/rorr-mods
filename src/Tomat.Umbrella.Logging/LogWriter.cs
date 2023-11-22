using System;
using System.IO;
using System.Text;

namespace Tomat.Umbrella.Logging;

public interface ILogWriter : IDisposable {
    void Write(ILogEntry entry);
}

public abstract class LogWriter : ILogWriter {
    public static readonly ILogWriter NULL = new NullLogWriter();

    public abstract void Write(ILogEntry entry);

    public static ILogWriter FromMany(ILogWriter[] writers) {
        return new ManyLogWriter(writers);
    }

    protected virtual void Dispose(bool disposing) { }

    public void Dispose() {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
}

public abstract class StringLogWriter : LogWriter {
    public override void Write(ILogEntry entry) {
        var sb = new StringBuilder();
        sb.Append(entry.Level.Name.PadLeft(5));
        sb.Append(" @ ");
        sb.Append(entry.Timestamp.ToString("u"));

        if (entry.Source is not null)
            sb.Append(" by \"" + entry.Source + '\"');

        sb.Append(": ");
        sb.Append(entry.Message);

        Write(sb.ToString(), entry.Level.Color);
    }

    protected abstract void Write(string message, ConsoleColor color);
}

public sealed class ConsoleLogWriter : StringLogWriter {
    protected override void Write(string message, ConsoleColor color) {
        var oldColor = Console.ForegroundColor;
        Console.ForegroundColor = color;
        Console.WriteLine(message);
        Console.ForegroundColor = oldColor;
    }
}

public sealed class FileLogWriter : StringLogWriter {
    private readonly StreamWriter writer;

    public FileLogWriter(string path, bool shared) {
        try {
            if (Directory.Exists(path))
                throw new FileNotFoundException("The path provided is a directory.", path);

            Directory.CreateDirectory(Path.GetDirectoryName(path)!);

            // Specifically allow ReadWrite so different contexts can write to the same file.
            writer = new StreamWriter(File.Open(path, FileMode.OpenOrCreate, FileAccess.Write, shared ? FileShare.ReadWrite : FileShare.Read));
            writer.AutoFlush = true;
        }
        catch (Exception e) {
            throw new ArgumentException("Could not open file.", nameof(path), e);
        }
    }

    protected override void Write(string message, ConsoleColor color) {
        writer.WriteLine(message);
    }

    protected override void Dispose(bool disposing) {
        if (disposing)
            writer.Dispose();

        base.Dispose(disposing);
    }
}

public sealed class NullLogWriter : LogWriter {
    public override void Write(ILogEntry entry) { }
}

public sealed class ManyLogWriter : LogWriter {
    private readonly ILogWriter[] writers;

    public ManyLogWriter(ILogWriter[] writers) {
        this.writers = writers;
    }

    public override void Write(ILogEntry entry) {
        foreach (var writer in writers)
            writer.Write(entry);
    }
}
