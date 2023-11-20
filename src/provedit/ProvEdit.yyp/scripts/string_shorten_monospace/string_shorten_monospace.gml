/// @function string_shorten_monospace
/// @param string
/// @param length
function string_shorten_monospace(argument0, argument1) {

	if (string_length(argument0) > argument1) {
		return string_copy(argument0, 0, argument1 - 2) + ".."
	} else {
		return argument0
	}


}
