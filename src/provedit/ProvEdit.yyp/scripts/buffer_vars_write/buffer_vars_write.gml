/// @param buffer
/// @param map
/// @param double
function buffer_vars_write(argument0, argument1, argument2) {

	var b = argument0
	var has_prev = argument2
	buffer_write(b, buffer_u16, ds_map_size(argument1)) // variable count
	for (var key = ds_map_find_first(argument1); !is_undefined(key); key = ds_map_find_next(argument1, key)) {
		var value = argument1[? key]
		buffer_write(b, buffer_string, key)
		var val0 = has_prev ? value[0] : value
		if (is_real(val0)) {
			buffer_write(b, buffer_bool, true)
			buffer_write(b, buffer_s32, val0)
			if (has_prev)
				buffer_write(b, buffer_s32, value[1])
		} else { // string
			buffer_write(b, buffer_bool, false)
			buffer_write(b, buffer_string, val0)
			if (has_prev)
				buffer_write(b, buffer_string, value[1])
		}
	}



}
