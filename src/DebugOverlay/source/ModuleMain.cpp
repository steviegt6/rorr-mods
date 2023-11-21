#include "../../AurieCommon/common.hpp"

SET_NAME(DebugOverlay)
SET_VERSION(1.0.1)

CODE_EVENT_CALLBACK(code_event_callback_run_show_debug_overlay)
{
    UNREFERENCED_PARAMETER(ctx);
    CALL_BUILTIN("show_debug_overlay", RValue(true), RValue(false), RValue(1.0), RValue(0.8));
    REMOVE_CALLBACK(code_event_callback_run_show_debug_overlay);
}

MODULE_INITIALIZE
{
    UNREFERENCED_PARAMETER(ModulePath);
    SET_MODULE(Module);

    DEFINE_STATUS(status);
    INITIALIZE_MODULE_INTERFACE(status)
    {
        return AURIE_MODULE_DEPENDENCY_NOT_RESOLVED;
    }

    PRINT(CM_GRAY, "Successfully resolved YYTK interface.");

    status = CREATE_CALLBACK(EVENT_OBJECT_CALL, code_event_callback_run_show_debug_overlay, 0);
    if (AURIE_FAILURE(status))
    {
        PRINT(CM_LIGHTRED, "Failed to create callback for show_debug_overlay.");
    }

    PRINT(CM_GRAY, "Successfully initialized; version %s.", VERSION);
    return AURIE_SUCCESS;
}

// TODO: Hide the overlay again if this mod is what enabled it?
MODULE_UNLOAD
{
    UNREFERENCED_PARAMETER(ModulePath);
    UNREFERENCED_PARAMETER(Module);
    return AURIE_SUCCESS;
}
