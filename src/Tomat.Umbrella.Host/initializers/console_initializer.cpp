#include "console_initializer.h"

#include <cstdio>
#include <string>
#include <windows.h>

#include "../logging.h"
#include "../main.h"

void init_console()
{
    AllocConsole();

    FILE* stream;
    (void)freopen_s(&stream, "CONIN$", "r", stdin);
    (void)freopen_s(&stream, "CONOUT$", "w", stdout);
    (void)freopen_s(&stream, "CONOUT$", "w", stdout);

#ifdef WIN32
    std::string os = "Windows";
    std::string arch = "x86";
#ifdef _WIN64
    arch = "x64";
#endif
#else
    std::string os = "Unknown OS";
    std::string arch = "Unknown Architecture";
#endif

#ifdef _DEBUG
    std::string configuration = "DEBUG";
#else
    std::string configuration = "RELEASE";
#endif

    const std::string console_title = std::string("Tomat.Umbrella.Host") + " - " + os + " " + arch + " (" + configuration + ")";
    SetConsoleTitleA(console_title.c_str());

    // Disable selection mode.
    // https://github.com/Archie-osu/YYToolkit/blob/stable/YYToolkit/Src/Core/Features/API/Internal.cpp#L117
    const HANDLE input = GetStdHandle(STD_INPUT_HANDLE);
    DWORD mode;
    GetConsoleMode(input, &mode);
    SetConsoleMode(input, ENABLE_EXTENDED_FLAGS | (mode & ~ENABLE_QUICK_EDIT_MODE));

    msg(light_blue, "Tomat.Umbrella.Host v%s by tomat (steviegt6)\n", host_version);
    msg(/* */ gray, "    Umbrella API and associated projects are and always will be free software.\n");
    msg(/* */ gray, "    \"Free\" as in \"free beer\" *and* \"freedom.\"\n");
    msg(/* */ gray, "    If you appreciate what I do, consider donating (it supports me and promotes the longevity of this project):\n");
    msg(light_gray, "        - https://patreon.com/tomatophile\n");
    msg(light_gray, "        - https://ko-fi.com/tomatophile\n");
}
