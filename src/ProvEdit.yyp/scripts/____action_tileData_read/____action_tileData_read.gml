function ____action_tileData_read(argument0, argument1) {
	var b = argument0;

	var ti = buffer_read(b, buffer_u16)
	var s = buffer_read(b, buffer_u16)

	for (var i = 0; i < s; i++) {
		var tx, ty, ox, oy, nx, ny
	
		tx = buffer_read(b, buffer_s16)
		ty = buffer_read(b, buffer_s16)
	
		ox = buffer_read(b, buffer_u16)
		oy = buffer_read(b, buffer_u16)
		if (ox == hugeu16 || oy == hugeu16) {
			ox = -1
			oy = -1
		}
	
		nx = buffer_read(b, buffer_u16)
		ny = buffer_read(b, buffer_u16)
		if (nx == hugeu16 || ny == hugeu16) {
			nx = -1
			ny = -1
		}
	
		if (!argument1) {
			__tile_layer_set_tile(ti, tx, ty, nx, ny)
		} else {
			__tile_layer_set_tile(ti, tx, ty, ox, oy)
		}
	}


}
