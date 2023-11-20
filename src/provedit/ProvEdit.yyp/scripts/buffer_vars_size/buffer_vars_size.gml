/// @param map
/// @param double
function buffer_vars_size(argument0, argument1) {

	var mapSize = 0
	for (var key = ds_map_find_first(argument0); !is_undefined(key); key = ds_map_find_next(argument0, key)) {
		var value = argument0[? key]
		// write both old (value[0]) and new (value[1])
	
		// key (buffer_string) + null byte
		mapSize += string_byte_length(key) + 1
		// data type (buffer_bool) (true: number, false: string)
		mapSize += 1
	
		var first_val = value
		if (argument1)
			first_val = value[0]
	
		if (is_real(first_val)) {
			// number and bool (buffer_s32)
			mapSize += 4 * (argument1 ? 2 : 1)
		} else { // string
			// string (buffer_string) + null byte
			mapSize += string_byte_length(first_val) + 1
			if argument1
				mapSize += string_byte_length(value[1]) + 1
		}
	}
	return mapSize


}
