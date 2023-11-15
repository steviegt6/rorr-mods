#include "threading.h"

#include <cstdint>
#include <tlhelp32.h>

void iterate_processes(const process_iterator_func func, void* parameter)
{
    const HMODULE ntdll = GetModuleHandleA("ntdll.dll");
    if (!ntdll)
    {
        return;
    }

    const auto nt_query_system_information = reinterpret_cast<NtQuerySystemInformation_t>(GetProcAddress(ntdll, "NtQuerySystemInformation")); // NOLINT(clang-diagnostic-cast-function-type-strict)
    if (!nt_query_system_information)
    {
        return;
    }

    ULONG buffer_size = 0;
    NTSTATUS status = nt_query_system_information(SystemProcessInformation, nullptr, 0, &buffer_size);
    if (status != 0xC0000004 /*STATUS_INFO_LENGTH_MISMATCH*/) // NOLINT(clang-diagnostic-sign-compare)
    {
        return;
    }

    const PVOID buffer = malloc(buffer_size);
    if (!buffer)
    {
        return;
    }

    status = nt_query_system_information(SystemProcessInformation, buffer, buffer_size, nullptr);
    if (!NT_SUCCESS(status))
    {
        free(buffer);
        return;
    }

    auto process_entry = static_cast<psystem_process_information>(buffer);
    while (process_entry)
    {
        if (process_entry->ProcessId == reinterpret_cast<HANDLE>(GetCurrentProcessId())) // NOLINT(performance-no-int-to-ptr)
        {
            for (ULONG i = 0; i < process_entry->NumberOfThreads; i++)
            {
                func(process_entry, parameter);
            }
        }
    }

    free(buffer);
}
