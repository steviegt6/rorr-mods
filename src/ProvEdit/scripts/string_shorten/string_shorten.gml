/// @function string_shorten
/// @param string
/// @param length

if (string_width(argument0) > argument1) {
	var maxw = argument1 - string_width("..")
	var pos = 1
	var len = string_length(argument0)
	var curw = 0
	for (var i = 1; i <= len; i++) {
		var charw = string_width(string_char_at(argument0, i))
		if (curw + charw > maxw) {
			break
		} else {
			curw += charw
			pos += 1
		}
	}
	return string_copy(argument0, 1, pos) + ".."
} else {
	return argument0
}