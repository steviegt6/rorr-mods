/// @function array_to_string
/// @param array
/// @param delimiter
var result = ""
var array = argument0
var length = array_length_1d(array)
var delimiter = argument1
for (var i = 0; i < length; i++) {
	result += "\"" + string(array[i]) + "\""
	if (i != length - 1)
		result += delimiter
}
return result