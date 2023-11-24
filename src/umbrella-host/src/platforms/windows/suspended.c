#include <windows.h>
#include <TlHelp32.h>
#include <winternl.h>
#include <stdint.h>
#include <Psapi.h>
#include <ntstatus.h>

// https://github.com/AurieFramework/Aurie/blob/master/Aurie/source/framework/Early%20Launch/early_launch.hpp

typedef enum _KTHREAD_STATE
{
    Initialized,
    Ready,
    Running,
    Standby,
    Terminated,
    Waiting,
    Transition,
    DeferredReady,
    GateWaitObsolete,
    WaitingForProcessInSwap,
    MaximumThreadState
} KTHREAD_STATE,
    *PKTHREAD_STATE;

typedef enum _KWAIT_REASON
{
    Executive,
    FreePage,
    PageIn,
    PoolAllocation,
    DelayExecution,
    Suspended,
    UserRequest,
    WrExecutive,
    WrFreePage,
    WrPageIn,
    WrPoolAllocation,
    WrDelayExecution,
    WrSuspended,
    WrUserRequest,
    WrEventPair,
    WrQueue,
    WrLpcReceive,
    WrLpcReply,
    WrVirtualMemory,
    WrPageOut,
    WrRendezvous,
    WrKeyedEvent,
    WrTerminated,
    WrProcessInSwap,
    WrCpuRateControl,
    WrCalloutStack,
    WrKernel,
    WrResource,
    WrPushLock,
    WrMutex,
    WrQuantumEnd,
    WrDispatchInt,
    WrPreempted,
    WrYieldExecution,
    WrFastMutex,
    WrGuardedMutex,
    WrRundown,
    WrAlertByThreadId,
    WrDeferredPreempt,
    WrPhysicalFault,
    WrIoRing,
    WrMdlCache,
    MaximumWaitReason
} KWAIT_REASON,
    *PKWAIT_REASON;

typedef struct __SYSTEM_THREAD_INFORMATION
{
    LARGE_INTEGER KernelTime;
    LARGE_INTEGER UserTime;
    LARGE_INTEGER CreateTime;
    ULONG WaitTime;
    ULONG_PTR StartAddress;
    CLIENT_ID ClientId;
    KPRIORITY Priority;
    KPRIORITY BasePriority;
    ULONG ContextSwitches;
    KTHREAD_STATE ThreadState;
    KWAIT_REASON WaitReason;
} system_thread_information, *p_system_thread_information;

BOOL is_process_suspended(BOOL *suspended);
HWND wait_for_current_process_window();
BOOL for_each_thread(BOOL (*callback)(THREADENTRY32 *thread_entry, PVOID parameter), PVOID parameter);
BOOL get_entrypoint_thread(system_thread_information *thread_information);
PVOID get_thread_start_address(HANDLE thread_handle);
PVOID get_procedure(const wchar_t *module_name, const char *procedure_name);
NTSTATUS query_information_thread(HANDLE thread_handle, INT thread_information_class, PVOID thread_information, ULONG thread_information_length, PULONG return_length);
NTSTATUS get_system_thread_information(HANDLE thread_handle, system_thread_information *thread_information);
NTSTATUS resume_process(HANDLE process_handle);

BOOL query_module_information(HMODULE module, PVOID *module_base, uint32_t *size_of_module, PVOID *entry_point)
{
    MODULEINFO module_info = {0};
    if (!GetModuleInformation(GetCurrentProcess(), module, &module_info, sizeof(module_info)))
        return FALSE;

    if (module_base)
        *module_base = module_info.lpBaseOfDll;

    if (size_of_module)
        *size_of_module = module_info.SizeOfImage;

    if (entry_point)
        *entry_point = module_info.EntryPoint;

    return TRUE;
}

BOOL is_process_suspended(BOOL *suspended)
{
    system_thread_information entrypoint_thread_information = {0};

    if (!get_entrypoint_thread(&entrypoint_thread_information))
        return FALSE;

    if (entrypoint_thread_information.ThreadState != Waiting)
        return FALSE;

    suspended = (entrypoint_thread_information.WaitReason == Suspended);
    return TRUE;
}

typedef struct
{
    HANDLE process_handle;
    HWND process_window;
} process_window_information;

BOOL enum_windows_callback(HWND window, LPARAM parameter)
{
    process_window_information *window_information = (process_window_information *)parameter;
    DWORD window_process_id = 0;

    if (!GetWindowThreadProcessId(window, &window_process_id))
        return TRUE;

    if (window_process_id != GetProcessId(window_information->process_handle))
        return TRUE;

    if (window == GetConsoleWindow())
        return TRUE;

    if (!IsWindowVisible(window))
        return TRUE;

    window_information->process_window = window;
    return FALSE;
}

HWND wait_for_current_process_window()
{
    process_window_information window_information = {GetCurrentProcess(), NULL};

    while (!window_information.process_window)
    {
        EnumWindows(enum_windows_callback, (LPARAM)&window_information);
    }

    return window_information.process_window;
}

BOOL for_each_thread(BOOL (*callback)(THREADENTRY32 *thread_entry, PVOID parameter), PVOID parameter)
{
    HANDLE thread_snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);

    if (thread_snapshot == INVALID_HANDLE_VALUE)
        return FALSE;

    THREADENTRY32 thread_entry = {sizeof(thread_entry)};

    if (!Thread32First(thread_snapshot, &thread_entry))
    {
        CloseHandle(thread_snapshot);
        return FALSE;
    }

    do
    {
        if (thread_entry.th32OwnerProcessID != GetCurrentProcessId())
            continue;

        if (callback(&thread_entry, parameter))
        {
            CloseHandle(thread_snapshot);
            return TRUE;
        }
    } while (Thread32Next(thread_snapshot, &thread_entry));

    CloseHandle(thread_snapshot);
    return FALSE;
}

typedef struct
{
    PVOID entrypoint_address;
    system_thread_information thread_information;
} thread_callback_struct;

BOOL thread_callback(THREADENTRY32 *thread_entry, PVOID parameter)
{
    thread_callback_struct *annoying = (thread_callback_struct *)parameter;

    if (thread_entry->th32OwnerProcessID != GetCurrentProcessId())
        return FALSE;

    HANDLE thread_handle = OpenThread(THREAD_ALL_ACCESS, FALSE, thread_entry->th32ThreadID);

    if (!thread_handle)
        return FALSE;

    system_thread_information thread_information = {0};
    NTSTATUS last_status = get_system_thread_information(thread_handle, &thread_information);

    PVOID thread_start_address = get_thread_start_address(thread_handle);
    CloseHandle(thread_handle);

    if (!NT_SUCCESS(last_status))
        return FALSE;

    if (thread_start_address != annoying->entrypoint_address)
        return FALSE;

    annoying->thread_information = thread_information;
    return TRUE;
}

BOOL get_entrypoint_thread(system_thread_information *thread_information)
{
    PVOID entrypoint_address;
    if (!query_module_information(GetModuleHandleA(NULL), NULL, NULL, &entrypoint_address))
        return FALSE;

    thread_callback_struct callback_struct = {entrypoint_address, 0};
    BOOL res = for_each_thread(thread_callback, &callback_struct);
    *thread_information = callback_struct.thread_information;
    return res;
}

PVOID get_thread_start_address(HANDLE thread_handle)
{
    PVOID thread_start_address = NULL;
    query_information_thread(thread_handle, 9, &thread_start_address, sizeof(thread_start_address), NULL);
    return thread_start_address;
}

PVOID get_procedure(const wchar_t *module_name, const char *procedure_name)
{
    HMODULE target_module = GetModuleHandleW(module_name);
    if (!target_module)
        return NULL;

    return GetProcAddress(target_module, procedure_name);
}

NTSTATUS query_information_thread(HANDLE thread_handle, INT thread_information_class, PVOID thread_information, ULONG thread_information_length, PULONG return_length)
{
    typedef NTSTATUS(NTAPI * NtQueryInformationThread)(HANDLE thread_handle, INT thread_information_class, PVOID thread_information, ULONG thread_information_length, PULONG return_length);
    NtQueryInformationThread nt_query_information_thread = (NtQueryInformationThread)get_procedure(L"ntdll.dll", "NtQueryInformationThread");

    if (!nt_query_information_thread)
        return STATUS_UNSUCCESSFUL;

    return nt_query_information_thread(thread_handle, thread_information_class, thread_information, thread_information_length, return_length);
}

NTSTATUS get_system_thread_information(HANDLE thread_handle, system_thread_information *thread_information)
{
    return query_information_thread(thread_handle, 40, thread_information, sizeof(*thread_information), NULL);
}

NTSTATUS resume_process(HANDLE process_handle)
{
    typedef NTSTATUS(NTAPI * NtResumeProcess)(HANDLE process_handle);
    NtResumeProcess nt_resume_process = (NtResumeProcess)get_procedure(L"ntdll.dll", "NtResumeProcess");

    if (!nt_resume_process)
        return STATUS_UNSUCCESSFUL;

    return nt_resume_process(process_handle);
}
