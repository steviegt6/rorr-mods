#include "main.h"

#include <iostream>
#include <string>

#include "logging.h"
#include "threading.h"
#include "initializers/console_initializer.h"
#include "initializers/steam_initializer.h"

// ReSharper disable once CppInconsistentNaming
BOOL APIENTRY DllMain(const HMODULE instance, const DWORD reason, LPVOID)
{
    if (reason != DLL_PROCESS_ATTACH)
        return TRUE;

    CloseHandle(CreateThread(nullptr, 0, thread_main, instance, 0, nullptr));
    return TRUE;
}

void log_init(const console_color color, const char* format, ...)
{
    msg(color, "[Init] ");

    va_list args;
    va_start(args, format);
    {
        msg(color, format, args);
    }
    va_end(args);
}

DWORD thread_main(LPVOID p)
{
    const HMODULE instance = static_cast<HMODULE>(p);

    init_console();

    // Guess who got *lazy*!!!! I had actual code for this, but it's easier to
    // just check for a command line flag and let the managed side of the loader
    // handle everything else...
    if (is_suspended())
    {
        log_init(gray, "This process was started in a suspended state.\n");
    }
    else
    {
        log_init(yellow, "This process was not started in a suspended state and will be restarted by the managed host!\n");
        log_init(yellow, "Running threads will be suspended to prevent further unwanted execution...\n");
        suspend_entrypoint_thread();
    }

    const bool steam_workaround = init_steam();
    if (steam_workaround)
    {
        log_init(yellow, "Steam API initialization failed, likely due to the lack of a steam_appid.txt file.\n");
    }
    else
    {
        log_init(gray, "Steam API initialization was ignored or was successful.\n");
    }

    TCHAR cwd_buf[MAX_PATH];
    GetModuleFileName(instance, cwd_buf, MAX_PATH);
    const std::wstring dll_path(cwd_buf);
    std::wstring cwd(cwd_buf);
    const std::wstring::size_type separator = cwd.find_last_of(L"\\/");
    cwd = cwd.substr(0, separator);
    std::wstring umbrella_dir = cwd + L"\\.umbrella";

    size_t required_size;
    _wgetenv_s(&required_size, nullptr, 0, L"UMBRELLA_DIRECTORY");
    if (required_size > 0)
    {
        _wgetenv_s(&required_size, cwd_buf, MAX_PATH, L"UMBRELLA_DIRECTORY");
        umbrella_dir = std::wstring(cwd_buf);
    }

    log_init(gray, "Using working directory: ");
    std::wcout << cwd << std::endl;
    log_init(gray, "Using DLL path: ");
    std::wcout << dll_path << std::endl;
    log_init(gray, "Using Umbrella directory: ");
    std::wcout << umbrella_dir << std::endl;
    CreateDirectory(umbrella_dir.c_str(), nullptr);

    return 0;
}

bool is_suspended()
{
    // My old code for this is broken, so let's use this hack.
    const auto command_line = GetCommandLineA();
    if (strstr(command_line, "-suspended"))
        return true;

    return false;
}

void suspend_entrypoint_thread()
{
    // const LPMODULEINFO game_module{};
    // get_module_information(nullptr, game_module);

    const auto func = [](const HANDLE thread, void*) -> void
    {
        if (GetThreadId(thread) == GetCurrentThreadId())
        {
            return;
        }

        if (SuspendThread(thread) == static_cast<DWORD>(-1))
        {
            msg(red, "Failed to suspend thread %p!\n", thread);
        }
    };

    iterate_threads(GetCurrentProcessId(), func, nullptr);
}


// Stub common proxy targets:

// dbgcore.dll
extern "C" {
// ReSharper disable once CppInconsistentNaming
__declspec(dllexport) BOOL MiniDumpReadDumpStream(PVOID, ULONG, void*, void*, void*) { return FALSE; }
// ReSharper disable once CppInconsistentNaming
__declspec(dllexport) BOOL MiniDumpWriteDump(HANDLE, DWORD, HANDLE, DWORD, void*, void*, void*) { return FALSE; }
}
