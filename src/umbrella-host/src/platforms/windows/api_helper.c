#include <stdio.h>
#include <windows.h>
#include <TlHelp32.h>

typedef struct
{
    BOOL success;
    DWORD main_thread;
} suspend_all_threads_result;

void initialize_console(void);
suspend_all_threads_result suspend_all_threads(void);
void suspend_this_thread(DWORD thread_id);

void initialize_console(void)
{
    FILE *stream;
    (void)freopen_s(&stream, "CONIN$", "r", stdin);
    (void)freopen_s(&stream, "CONOUT$", "w", stdout);
    (void)freopen_s(&stream, "CONOUT$", "w", stderr);
}

suspend_all_threads_result suspend_all_threads(void)
{
    suspend_all_threads_result result = {FALSE, GetCurrentThreadId()};

    HANDLE current_thread = GetCurrentThread();
    DWORD current_process_id = GetCurrentProcessId();

    HANDLE thread_snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
    if (thread_snapshot == INVALID_HANDLE_VALUE)
    {
        return result;
    }

    THREADENTRY32 thread_entry;
    thread_entry.dwSize = sizeof(THREADENTRY32);
    if (Thread32First(thread_snapshot, &thread_entry))
    {
        do
        {
            if (thread_entry.th32OwnerProcessID == current_process_id && thread_entry.th32ThreadID != result.main_thread)
            {
                HANDLE thread = OpenThread(THREAD_SUSPEND_RESUME, FALSE, thread_entry.th32ThreadID);
                if (thread != NULL)
                {
                    SuspendThread(thread);
                    CloseHandle(thread);
                }
            }
        } while (Thread32Next(thread_snapshot, &thread_entry));
    }

    CloseHandle(thread_snapshot);
    result.success = TRUE;
    return result;
}

void suspend_this_thread(DWORD thread_id)
{
    HANDLE thread = OpenThread(THREAD_SUSPEND_RESUME, FALSE, thread_id);
    if (thread != NULL)
    {
        SuspendThread(thread);
        CloseHandle(thread);
    }
}
