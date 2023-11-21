#include <YYToolkit/shared.hpp>

using namespace Aurie;
using namespace YYTK;

static YYTKInterface* g_ModuleInterface = nullptr;

void code_event_callback_run_show_debug_overlay(FWCodeEvent& ctx)
{
	UNREFERENCED_PARAMETER(ctx);

	static bool ran = false;

	if (ran)
	{
		return;
	}

	g_ModuleInterface->CallBuiltin("show_debug_overlay", { RValue(true), RValue(false), RValue(1.0), RValue(0.8) });
}

EXPORTED AurieStatus ModuleInitialize(
	IN AurieModule* Module,
	IN const fs::path& ModulePath
)
{
	UNREFERENCED_PARAMETER(ModulePath);

	AurieStatus last_status = AURIE_SUCCESS;

	last_status = ObGetInterface("YYTK_Main", (AurieInterfaceBase*&)g_ModuleInterface);

	if (!AurieSuccess(last_status))
	{
		return AURIE_MODULE_DEPENDENCY_NOT_RESOLVED;
	}

	g_ModuleInterface->Print(CM_GRAY, "[DebugOverlay] Successfully resolved YYTK interface.");

	last_status = g_ModuleInterface->CreateCallback(Module, EVENT_OBJECT_CALL, code_event_callback_run_show_debug_overlay, 0);

	if (!AurieSuccess(last_status))
	{
		g_ModuleInterface->Print(CM_LIGHTRED, "[DebugOverlay] Failed to create callback for show_debug_overlay.");
	}

	return AURIE_SUCCESS;
}

EXPORTED AurieStatus ModuleUnload(
	IN AurieModule* Module,
	IN const fs::path& ModulePath
)
{
	// TODO: Hide the overlay again if this mod is what enabled it?

	return AURIE_SUCCESS;
}