#include "main.h"

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

DWORD thread_main(LPVOID)
{
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
        log_init(yellow, "Steam API initialization failed, likely due to the lack of a steam_appid.txt file; a workaround will be attempted.\n");
    }
    else
    {
        log_init(gray, "Steam API initialization was ignored or was successful.\n");
    }

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

    const process_iterator_func func = [](system_process_information* proc_info, void* p)
    {
        // ReSharper disable once CppDeclarationHidesUncapturedLocal
        // const auto game_module = static_cast<LPMODULEINFO>(p);

        if (!proc_info)
        {
            return;
        }

        const HANDLE process_id = proc_info->ProcessId;
        if (reinterpret_cast<uintptr_t>(process_id) != GetCurrentProcessId())
        {
            return;
        }

        for (int i = 0; i < proc_info->NumberOfThreads; i++) // NOLINT(clang-diagnostic-sign-compare)
        {
            const HANDLE thread = OpenThread(THREAD_ALL_ACCESS, false, reinterpret_cast<uintptr_t>(proc_info->Threads[i].ClientId.UniqueThread)); // NOLINT(performance-no-int-to-ptr, clang-diagnostic-shorten-64-to-32)

            /*unsigned long start_addr = 0;

            if (!get_thread_start_address(thread, start_addr))
            {
                CloseHandle(thread);
                continue;
            }*/

            /*if (start_addr != reinterpret_cast<uintptr_t>(game_module->EntryPoint))
            {
                CloseHandle(thread);
                continue;
            }*/

            if (SuspendThread(thread) == static_cast<DWORD>(-1))
            {
                CloseHandle(thread);
                continue;
            }
            CloseHandle(thread);
        }
    };

    iterate_processes(func, nullptr);
}


// Stub common proxy targets:

// dbgcore.dll
extern "C" {
// ReSharper disable once CppInconsistentNaming
__declspec(dllexport) BOOL MiniDumpReadDumpStream(PVOID, ULONG, void*, void*, void*) { return FALSE; }
// ReSharper disable once CppInconsistentNaming
__declspec(dllexport) BOOL MiniDumpWriteDump(HANDLE, DWORD, HANDLE, DWORD, void*, void*, void*) { return FALSE; }
}
