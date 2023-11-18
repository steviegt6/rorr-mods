// layer idx, [[x, y, tx, ty]...]

#macro hugeu16 0xFFFF
var is_map = !is_array(argument1)
var s
if !is_map
	s = array_length_1d(argument1)
else
	s = ds_map_size(argument1)
	
var b = buffer_create(8 + s * 12, buffer_fixed, 1)
buffer_write(b, buffer_u8, Actions.tileData)

buffer_write(b, buffer_u16, argument0)             // LAYER
buffer_write(b, buffer_u16, s)                     // COUNT

if is_map {
	var key = ds_map_find_first(argument1);
	for (var i = 0; i < s; i++) {
		var tile = argument1[? key]
		var oldtile = argument2[? key]
		var ttx, tty
		if (oldtile == undefined) {
			ttx = hugeu16
			tty = hugeu16
		} else {
			ttx = tile_get_img_x(oldtile)
			tty = tile_get_img_y(oldtile)
		}
		
		buffer_write(b, buffer_s16, coordinate_get_x(key))              // TILE X
		buffer_write(b, buffer_s16, coordinate_get_y(key))              // TILE Y
		buffer_write(b, buffer_u16, ttx)                // OLD IMAGE X
		buffer_write(b, buffer_u16, tty)                // OLD IMAGE Y
		buffer_write(b, buffer_u16, tile_get_img_x(tile))              // NEW IMAGE X
		buffer_write(b, buffer_u16, tile_get_img_y(tile))              // NEW IMAGE Y*/
		key = ds_map_find_next(argument1, key);
	}
} else {
	var cl = global.tiles[argument0]
	for (var i = 0; i < s; i++) {
		var c = argument1[i]
	
		var ox = hugeu16, oy = hugeu16
		var ct = tile_layer_get_at(argument0, c[0], c[1])
		if (!is_undefined(ct)) {
			ox = tile_get_img_x(ct)
			oy = tile_get_img_y(ct)
		}
	
		if (c[2] < 0 || c[3] < 0) {
			c[2] = hugeu16
			c[3] = hugeu16
		}
	
		buffer_write(b, buffer_s16, c[0])              // TILE X
		buffer_write(b, buffer_s16, c[1])              // TILE Y
		buffer_write(b, buffer_u16, ox)                // OLD IMAGE X
		buffer_write(b, buffer_u16, oy)                // OLD IMAGE Y
		buffer_write(b, buffer_u16, c[2])              // NEW IMAGE X
		buffer_write(b, buffer_u16, c[3])              // NEW IMAGE Y
	}
}

return [b, "Tile stuffs"]//"Modified layer '" + global.tiles[argument0] + "'"]