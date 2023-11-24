#include <stdio.h>

void initialize_console(void)
{
    FILE *stream;
    (void)freopen_s(&stream, "CONIN$", "r", stdin);
    (void)freopen_s(&stream, "CONOUT$", "w", stdout);
    (void)freopen_s(&stream, "CONOUT$", "w", stderr);
}

/*FILE *get_stdin()
{
    return stdin;
}

FILE *get_stdout()
{
    return stdout;
}

FILE *get_stderr()
{
    return stderr;
}

errno_t freopen_s(FILE **stream, const char *filename, const char *mode, FILE *oldstream)
{
    return freopen_s(stream, filename, mode, oldstream);
}*/