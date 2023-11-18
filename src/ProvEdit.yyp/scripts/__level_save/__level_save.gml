function __level_save(argument0) {
#macro FORMAT_VERSION "0.1.1"

	/* spec changes:
		0.1.1:
			Adds % offsets to bgs.
	*/

	gml_pragma("global", @'global.____format_known = ds_map_create();
		global.____format_known[? "0.1.0"] = true
		global.____format_known[? "0.1.1"] = true
	')

	if (argument0 || global.level_path == "") {
		var temp_path = get_save_filename("ProvEdit level file|*.rorlvl", global.level_name + ".rorlvl")
		if (temp_path == "")
			exit
		else
			global.level_path = temp_path
	}

	var b = __level_save_buffer()

	buffer_save(b, global.level_path)
	scr_message("Saved level to " + global.level_path + " (" + string(round(buffer_get_size(b) / 1024)) + "KB)")
	buffer_delete(b)




}
