var b = argument0;

var delete = buffer_read(b, buffer_u8)
//var count = buffer_read(b, buffer_u16)

var tx = buffer_read(b, buffer_s32)
var ty = buffer_read(b, buffer_s32)
var kind = buffer_read(b, buffer_u16)
	
var map = -1
if (delete)
	map = buffer_vars_read(b, false)

if (delete == argument1) {
	var _inst = _create_level_object(tx, ty, kind)
	if (map != -1) {
		var _swap = _inst.variables
		_inst.variables = map
		map = _swap
	}
} else {
	with (objMapObject) {
		if (x == tx && y == ty && obj_id == kind) {
			instance_destroy()
			break
		}
	}
}
if (map != -1)
	ds_map_destroy(map)
