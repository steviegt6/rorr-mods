#include "dotnet_initializer.h"

#include <cstdarg>

#include "../logging.h"

void log_dotnet(const console_color color, const char* format, ...)
{
    msg(color, "[Init::.NET] ");

    va_list args;
    va_start(args, format);
    {
        msg(color, format, args);
    }
    va_end(args);
}

bool init_dotnet(std::wstring& cwd, std::wstring& managed_host_dir, native_entry* entry)
{
    return false;
}

