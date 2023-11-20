/// @function tile_layer_draw_region
/// @param layer
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param transparent
function tile_layer_draw_region(argument0, argument1, argument2, argument3, argument4, argument5) {

	with (argument0) {
		var x1 = argument1, y1 = argument2
		var x2 = argument3, y2 = argument4
	
		if (argument5) shader_set(shdHalfAlpha)

		var img = global.ProvEdit_tileset[tileset, 2]
		for (var i = x1; i < x2; i++) {
			var bm = tile_data[? i]
			if (bm == undefined) continue
			for (var j = y1; j < y2; j++) {
				var m = bm[? j]
				if (m == undefined)
					continue
				//draw_set_colour(c_white)
				//draw_rectangle(i * 16, j * 16, i * 16 + 16, j * 16 + 16, 1)
				draw_sprite_part(img, 0, ((m & 0xFFFF0000) >> 16) << 4, (m & 0x0000FFFF) << 4, 16, 16, i << 4, j << 4)
			}
		}
	
		if (argument5) shader_reset()
	}


}
