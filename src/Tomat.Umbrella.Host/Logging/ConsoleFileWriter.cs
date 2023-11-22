using System;
using System.IO;
using System.Linq;
using System.Text;

namespace Tomat.Umbrella.Host.Logging;

internal sealed class ConsoleFileWriter : TextWriter {
    public override Encoding Encoding { get; } = new UTF8Encoding(true);

    private readonly TextWriter console;
    private readonly StreamWriter[] files;
    private bool hasWrittenFirstLine;

    public ConsoleFileWriter(TextWriter console, params string[] filePaths) {
        this.console = console;
        files = filePaths.Select(fromFile).ToArray();
        return;

        StreamWriter fromFile(string path) {
            return new StreamWriter(File.Open(path, FileMode.OpenOrCreate, FileAccess.Write, FileShare.ReadWrite)) {
                AutoFlush = true,
            };
        }
    }

    public override void Write(char value) {
        if (value == '\r')
            return;

        if (!hasWrittenFirstLine || value == '\n') {
            if (hasWrittenFirstLine) {
                // console.WriteLine();
                foreach (var file in files)
                    file.WriteLine();
            }

            hasWrittenFirstLine = true;
            Write($"TRACE @ {DateTime.Now:u} by \"Console\": ");
            return;
        }

        // console.Write(value);
        foreach (var file in files)
            file.Write(value);
    }
}
