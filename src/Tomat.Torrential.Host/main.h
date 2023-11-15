#pragma once

#include <windows.h>

static constexpr const char* const host_version = "1.0.0";

// ReSharper disable once CppInconsistentNaming
BOOL APIENTRY DllMain(HMODULE instance, DWORD reason, LPVOID);
DWORD thread_main(LPVOID);
bool is_suspended();
void suspend_entrypoint_thread();

// Stub common proxy targets:

// dbgcore.dll
extern "C" {
// ReSharper disable once CppInconsistentNaming
__declspec(dllexport) BOOL MiniDumpReadDumpStream(PVOID, ULONG, void*, void*, void*);
// ReSharper disable once CppInconsistentNaming
__declspec(dllexport) BOOL MiniDumpWriteDump(HANDLE, DWORD, HANDLE, DWORD, void*, void*, void*);
}
