#include "threading.h"

#include <cstdint>

bool get_module_information(const char* module_name, LPMODULEINFO module_info)
{
    /*using fn = int(__stdcall*)(HANDLE, HMODULE, LPMODULEINFO, DWORD);

    const HMODULE kernel32 = GetModuleHandleA("kernel32.dll");
    const auto get_module_info = reinterpret_cast<fn>(GetProcAddress(kernel32, "K32GetModuleInformation")); // NOLINT(clang-diagnostic-cast-function-type-strict)

    const HMODULE module_handle = GetModuleHandleA(module_name);
    if (!module_handle)
    {
        return false;
    }

    get_module_info(GetCurrentProcess(), module_handle, module_info, sizeof(MODULEINFO));
    return true;*/

    const HMODULE module_handle = GetModuleHandleA(module_name);
    if (!module_handle)
    {
        return false;
    }

    return GetModuleInformation(GetCurrentProcess(), module_handle, module_info, sizeof(MODULEINFO));
}

bool get_proc_info(system_process_information** info)
{
    using fn = NTSTATUS(NTAPI*)(SYSTEM_INFORMATION_CLASS info_class, PVOID system_info, ULONG info_length, PULONG return_length);

    const HMODULE ntdll = GetModuleHandleA("ntdll.dll");
    if (!ntdll)
    {
        return false;
    }

    const auto nt_query_system_information = reinterpret_cast<fn>(GetProcAddress(ntdll, "NtQuerySystemInformation")); // NOLINT(clang-diagnostic-cast-function-type-strict)
    if (!nt_query_system_information)
    {
        return false;
    }

    uint32_t size = sizeof(system_process_information);
    auto process_info = static_cast<system_process_information*>(malloc(size));

    NTSTATUS status;
    while ((status = nt_query_system_information(SystemProcessInformation, process_info, size, nullptr)) == 0xc0000004 /* STATUS_INFO_LENGTH_MISMATCH */) // NOLINT(clang-diagnostic-sign-compare)
    {
        process_info = static_cast<system_process_information*>(realloc(process_info, size *= 2)); // NOLINT(bugprone-suspicious-realloc-usage, bugprone-implicit-widening-of-multiplication-result)
    }

    if (NT_SUCCESS(status))
    {
        *info = process_info;
        return true;
    }

    return false;
}

void iterate_processes(const process_iterator_func func, void* parameter)
{
    system_process_information* process_info = nullptr;
    if (!get_proc_info(&process_info))
    {
        return;
    }

    void* addr_to_free = process_info;

    /*if (const LPMODULEINFO game_module{}; !get_module_information(nullptr, game_module))
    {
        goto FREE; // NOLINT(cppcoreguidelines-avoid-goto, hicpp-avoid-goto)
    }*/

    while (true)
    {
        func(process_info, parameter);
        if (process_info->NextEntryOffset == 0)
        {
            break;
        }

        process_info = reinterpret_cast<system_process_information*>(reinterpret_cast<uintptr_t>(process_info) + process_info->NextEntryOffset); // NOLINT(performance-no-int-to-ptr)
    }

    //FREE:
    free(addr_to_free);
}

bool get_thread_start_address(const HANDLE thread, unsigned long& address)
{
    using fn = NTSTATUS(NTAPI*)(HANDLE thread_handle, THREADINFOCLASS thread_class, PVOID thread_information, ULONG length, PULONG return_length);

    const HMODULE ntdll = GetModuleHandleA("ntdll.dll");
    if (!ntdll)
    {
        return false;
    }

    const auto nt_query_information_thread = reinterpret_cast<fn>(GetProcAddress(ntdll, "NtQueryInformationThread")); // NOLINT(clang-diagnostic-cast-function-type, clang-diagnostic-cast-function-type-strict)
    if (!nt_query_information_thread)
    {
        return false;
    }

    const NTSTATUS status = nt_query_information_thread(thread, static_cast<THREADINFOCLASS>(9), &address, sizeof(unsigned long), nullptr);
    return NT_SUCCESS(status);
}
