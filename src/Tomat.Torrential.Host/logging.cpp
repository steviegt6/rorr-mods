#include "logging.h"

#include <string>
#include <windows.h>

// https://github.com/Archie-osu/YYToolkit/blob/stable/YYToolkit/Src/Core/Utils/Logging/Logging.cpp

void set_console_color(const console_color color)
{
    const HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
    SetConsoleTextAttribute(console, static_cast<WORD>(color));
}

void msg(const console_color color, const char* format, ...)
{
    constexpr static int max_buffer_size = 1024;

    std::string message;

    va_list args;
    va_start(args, format);
    {
        if (strlen(format) >= max_buffer_size)
        {
            msg(light_red, "Attempted to log a message with too great of a length!\n");
            return;
        }

        char buf[max_buffer_size] = {};
        strncpy_s(buf, format, max_buffer_size);
        (void)vsprintf_s(buf, format, args);

        message = std::string(buf);
    }
    va_end(args);

    set_console_color(color);
    printf("%s", message.c_str());
    set_console_color(light_gray);
}
