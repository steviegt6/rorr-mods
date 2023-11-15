#include "threading.h"

#include <cstdint>
#include <tlhelp32.h>

void iterate_threads(const DWORD proc_id, const thread_iterator_func func, void* parameter)
{
    const HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);

    if (snapshot == INVALID_HANDLE_VALUE)
    {
        return;
    }

    THREADENTRY32 te32;
    te32.dwSize = sizeof(THREADENTRY32);

    if (Thread32First(snapshot, &te32))
    {
        do
        {
            if (te32.th32OwnerProcessID == proc_id)
            {
                const HANDLE thread = OpenThread(THREAD_ALL_ACCESS, false, te32.th32ThreadID);

                if (thread == INVALID_HANDLE_VALUE)
                {
                    continue;
                }

                func(thread, parameter);
                CloseHandle(thread);
            }
        }
        while (Thread32Next(snapshot, &te32));
    }

    CloseHandle(snapshot);
}
