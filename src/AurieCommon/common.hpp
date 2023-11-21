#pragma once

#include <filesystem>

#include "YYToolkit/shared.hpp"

using namespace Aurie; // NOLINT(clang-diagnostic-header-hygiene)
using namespace YYTK; // NOLINT(clang-diagnostic-header-hygiene)

static YYTKInterface* g_module_interface = nullptr;
static AurieModule* g_module = nullptr;

#define MODULE_INTERFACE g_module_interface
#define MODULE g_module
#define SET_MODULE(module) g_module = module

#define CODE_EVENT_CALLBACK(name) void name(FWCodeEvent& ctx)
#define FRAME_CALLBACK(name) void name(FWFrame& ctx)
#define RESIZE_CALLBACK(name) void name(FWResize& ctx)
#define SCRIPT_EVENT_CALLBACK(name) void name(FWScriptEvent& ctx)
#define WND_PROC_CALLBACK(name) void name(FWWndProc& ctx)

#define MODULE_PREINITIALIZE EXPORTED AurieStatus ModulePreinitialize(IN AurieModule* Module, IN const fs::path& ModulePath)
#define MODULE_INITIALIZE EXPORTED AurieStatus ModuleInitialize(IN AurieModule* Module, IN const fs::path& ModulePath)
#define MODULE_UNLOAD EXPORTED AurieStatus ModuleUnload(IN AurieModule* Module, IN const fs::path& ModulePath)
#define FRAMEWORK_INIT EXPORTED AurieStatus __AurieFrameworkInit(IN AurieModule* InitialImage, IN void* (**PpGetFrameworkRoutine)(IN const char* ImageExportName), IN OPTIONAL AurieEntry Routine, IN OPTIONAL const fs::path& Path, IN OPTIONAL AurieModule& SelfModule)

#define INITIALIZE_MODULE_INTERFACE(status) \
    (status) = ObGetInterface("YYTK_Main", (AurieInterfaceBase*&)g_module_interface); \
    if (!AurieSuccess(status))

#define CALL_BUILTIN(name, ...) MODULE_INTERFACE->CallBuiltin(name, {__VA_ARGS__})
#define CALL_BUILTIN_EX(result, name, self, other, ...) MODULE_INTERFACE->CallBuiltinEx(result, name, self, other, {__VA_ARGS__})

#define SET_VERSION(version) static constexpr const char* const g_version = #version;
#define VERSION g_version

#define SET_NAME(name) static constexpr const char* const g_name = #name;
#define NAME g_name

#define PRINT_INNER(name, color, msg, ...) MODULE_INTERFACE->Print(color, std::string("[") + name + "] " + msg, __VA_ARGS__)
#define PRINT(color, msg, ...) PRINT_INNER(NAME, color, msg, __VA_ARGS__)

#define CREATE_CALLBACK(event, callback, priority) MODULE_INTERFACE->CreateCallback(Module, event, callback, priority) // NOLINT(clang-diagnostic-microsoft-cast)
#define REMOVE_CALLBACK(callback) MODULE_INTERFACE->RemoveCallback(MODULE, callback) // NOLINT(clang-diagnostic-microsoft-cast)

#define AURIE_SUCCESS(status) AurieSuccess(status)
#define AURIE_FAILURE(status) !AurieSuccess(status)

#define DEFINE_STATUS(name) AurieStatus name
