function ____action_colData_read(argument0, argument1) {
	var b = argument0;

	var s = buffer_read(b, buffer_u32)
	var d = buffer_read(b, buffer_u8)

	if (d) argument1 = !argument1

	repeat (s) {
		var typ = buffer_read(b, buffer_u8)
		var tx = buffer_read(b, buffer_s16)
		var ty = buffer_read(b, buffer_s16)
	
		if (!argument1) {
			instance_create_depth(tx * 8, ty * 8, -99, global.collision_types[typ, CollisionType.object])
		} else {
			with (collision_point(tx * 8, ty * 8, global.collision_types[typ, CollisionType.object], false, false)) {
				instance_destroy()
			}
		}
	}


}
