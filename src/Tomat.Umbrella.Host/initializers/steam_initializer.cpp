#include "steam_initializer.h"

#include <cstdarg>
#include <windows.h>

#include "../logging.h"

void log_steam(const console_color color, const char* format, ...)
{
    msg(color, "[Init::Steam] ");

    va_list args;
    va_start(args, format);
    {
        msg(color, format, args);
    }
    va_end(args);
}

bool init_steam()
{
    log_steam(gray, "Attempting to load steam_api...\n");

    HMODULE steam_api = LoadLibraryA("steam_api.dll");
    if (steam_api)
    {
        log_steam(gray, "Loaded Steam API: steam_api.dll\n");
    }
    else
    {
        steam_api = LoadLibraryA("steam_api64.dll");

        if (steam_api)
        {
            log_steam(gray, "Loaded Steam API: steam_api64.dll\n");
        }
        else
        {
            log_steam(gray, "No Steam API binaries found (or they failed to load), assuming non-Steam game.\n");
            return false;
        }
    }

    // ReSharper disable once CppInconsistentNaming
    typedef bool (*SteamAPI_Init_t)();
    // ReSharper disable once CppInconsistentNaming
    typedef bool (*SteamAPI_IsSteamRunning_t)();

    const auto init = reinterpret_cast<SteamAPI_Init_t>(GetProcAddress(steam_api, "SteamAPI_Init")); // NOLINT(clang-diagnostic-cast-function-type-strict)
    const auto is_steam_running = reinterpret_cast<SteamAPI_IsSteamRunning_t>(GetProcAddress(steam_api, "SteamAPI_IsSteamRunning")); // NOLINT(clang-diagnostic-cast-function-type-strict)

    if (!init || !is_steam_running)
    {
        log_steam(yellow, "Failed to find Steam API functions.\n");
        return false;
    }

    if (!init())
    {
        log_steam(yellow, "Steam API failed to initialize, a resolution will be attempted later...\n");
        return true;
    }

    if (!is_steam_running())
    {
        log_steam(yellow, "Game is not running through Steam, a resolution will be attempted later...\n");
        return true;
    }

    return false;
}
