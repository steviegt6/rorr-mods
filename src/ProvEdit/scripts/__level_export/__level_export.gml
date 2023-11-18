var file_path = get_save_filename("Lua script|*.lua", global.level_name + ".lua")
if (file_path == "")
	exit

var b = __level_export_buffer()

buffer_save(b, file_path)
scr_message("Exported Lua file to " + file_path + " (" + string(round(buffer_get_size(b) / 1024)) + "KB)")
buffer_delete(b)

