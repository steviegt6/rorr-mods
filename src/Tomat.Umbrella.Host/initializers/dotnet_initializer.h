#pragma once

#include <string>

#include "coreclr_delegates.h"
#include "hostfxr.h"

inline hostfxr_initialize_for_runtime_config_fn init_fptr;
inline hostfxr_get_runtime_delegate_fn get_delegate_fptr;
inline hostfxr_close_fn close_fptr;
inline hostfxr_set_runtime_property_value_fn set_prop_fptr;

typedef void (CORECLR_DELEGATE_CALLTYPE*native_entry)(const wchar_t* base_directory, const wchar_t* module_path, const wchar_t* host_version);

bool init_dotnet(std::wstring& cwd, std::wstring& managed_host_dir, native_entry* entry);
bool start_clr();
bool load_hostfxr();
load_assembly_and_get_function_pointer_fn get_dotnet_load_assembly(const char_t* config_path, const char_t* base_directory);
void* load_library(char_t* path);
void* get_export(void* h, const char* name);
