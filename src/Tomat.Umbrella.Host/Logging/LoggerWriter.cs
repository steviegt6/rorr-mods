using System;
using System.IO;
using System.Text;
using Tomat.Umbrella.Logging;

namespace Tomat.Umbrella.Host.Logging;

internal sealed class LoggerWriter : TextWriter {
    public override Encoding Encoding { get; } = new UTF8Encoding(true);

    private readonly ILogWriter logger;
    private readonly string name;
    private readonly StreamWriter innerWriter;

    public LoggerWriter(ILogWriter logger, string name, StreamWriter innerWriter) {
        this.logger = logger;
        this.name = name;
        this.innerWriter = innerWriter;
    }

    public override void Write(char value) {
        innerWriter.Write(value);
        logger.Write(new LogEntry(DateTime.Now, LogLevels.TRACE, name, value.ToString()));
    }

    public override void Write(char[] buffer, int index, int count) {
        innerWriter.Write(buffer, index, count);
        logger.Write(new LogEntry(DateTime.Now, LogLevels.TRACE, name, new string(buffer, index, count)));
    }

    public override void Write(ReadOnlySpan<char> buffer) {
        innerWriter.Write(buffer);
        logger.Write(new LogEntry(DateTime.Now, LogLevels.TRACE, name, buffer.ToString()));
    }
}
