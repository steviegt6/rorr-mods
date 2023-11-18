///draw_tile_list(layerObject, tiles)

with (argument0) {
	var l = array_length_1d(argument1)
	var img = global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.image]
	for (var i = 0; i < l; i++) {
		var t = argument1[i]
		draw_sprite_part(img, 0, t[2] * 16, t[3] * 16, 16, 16, t[0] * 16, t[1] * 16)
	}
}