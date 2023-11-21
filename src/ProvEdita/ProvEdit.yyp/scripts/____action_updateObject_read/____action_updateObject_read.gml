function ____action_updateObject_read(argument0, argument1) {
	var b = argument0;

	var _x = buffer_read(b, buffer_s32)
	var _y = buffer_read(b, buffer_s32)
	var _kind = buffer_read(b, buffer_u16)

	var map = buffer_vars_read(b, true)

	with (objMapObject) {
		if (x == _x && y == _y && obj_id == _kind) {
			for (var key = ds_map_find_first(map); !is_undefined(key); key = ds_map_find_next(map, key)) {
				var valueArray = map[? key]
				variables[? key] = argument1 ? valueArray[0] : valueArray[1]
			}
		
			var _inst = id
			with (objObjectMenu) {
				if (!destroyed && parent == _inst.id) {
					with instance_create_depth(_inst.x, _inst.y, _inst.depth - 1, objObjectMenu) {
						parent = _inst.id
						world_x = other.world_x
						world_y = other.world_y
					}
					instance_destroy()
					break
				}
			}
			break
		}
	}


	ds_map_destroy(map)


}
