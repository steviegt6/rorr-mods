#define _____provedit_libmain_init
	global.____ProvEdit_asset_path_base = ""
	global.____ProvEdit_error_handler_id = -1

#define ProvEdit_asset_path
	if (argument_count > 0)
		global.____ProvEdit_asset_path_base = argument0 + "/"
	return global.____ProvEdit_asset_path_base

#define ProvEdit_error_handler
	if (argument_count > 0)
		global.____ProvEdit_error_handler_id = argument0
	return global.____ProvEdit_error_handler_id

#define ____ProvEdit_load_error
	/// load_error(type, name, err)
	if (script_exists(global.____ProvEdit_error_handler_id))
		script_execute(global.____ProvEdit_error_handler_id, "Failed to load " + argument0 + " '" + argument1 + "': " + argument2)
		
#define ProvEdit_load_default_assets
	ProvEdit_asset_path(argument0)
	ProvEdit_load_music()
	ProvEdit_asset_path(argument0  + "editor/")
	ProvEdit_load_objects()
	ProvEdit_load_tilesets()
	ProvEdit_load_backgrounds()
	ProvEdit_load_interactables()
	ProvEdit_load_enemies()
