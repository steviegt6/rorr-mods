/// @param buffer
/// @param double

var map = ds_map_create()
var b = argument0

var _map_size = buffer_read(b, buffer_u16)
for (var k = 0; k < _map_size; k += 1) {
	var _name = buffer_read(b, buffer_string)
	var _var_type = buffer_read(b, buffer_bool)
	var _var_value = [0,0]
	if (argument1) {
		if (_var_type) {
			_var_value[0] = buffer_read(b, buffer_s32)
			_var_value[1] = buffer_read(b, buffer_s32)
		} else {
			_var_value[0] = buffer_read(b, buffer_string)
			_var_value[1] = buffer_read(b, buffer_string)
		}
	} else {
		if (_var_type) {
			_var_value = buffer_read(b, buffer_s32)
		} else {
			_var_value = buffer_read(b, buffer_string)
		}
	}
	
	map[? _name] = _var_value
}

return map