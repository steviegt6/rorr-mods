#pragma once

#include <windows.h>
#include <winternl.h>

// ReSharper disable once CppInconsistentNaming
typedef NTSTATUS (WINAPI*NtQuerySystemInformation_t)(
    ULONG system_information_class,
    PVOID system_information,
    ULONG system_information_length,
    PULONG return_length
);

typedef struct _system_process_information
{
    ULONG NextEntryOffset;
    ULONG NumberOfThreads;
    LARGE_INTEGER Reserved[3];
    LARGE_INTEGER CreateTime;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER KernelTime;
    UNICODE_STRING ImageName;
    ULONG BasePriority;
    HANDLE ProcessId;
    HANDLE InheritedFromProcessId;
} system_process_information, *psystem_process_information;

typedef void (*process_iterator_func)(psystem_process_information proc_info, void* parameter);

void iterate_processes(process_iterator_func func, void* parameter);
bool get_thread_start_address(HANDLE thread, unsigned long& address);
