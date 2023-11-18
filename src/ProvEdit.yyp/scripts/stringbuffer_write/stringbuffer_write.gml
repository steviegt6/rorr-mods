/// @function stringbuffer_write
/// @param buffer
/// @param string
function stringbuffer_write(argument0, argument1) {
	// Used by __level_export_buffer
	gml_pragma("forceinline")
	buffer_write(argument0, buffer_string, argument1)
	buffer_seek(argument0, buffer_seek_relative, -1)


}
