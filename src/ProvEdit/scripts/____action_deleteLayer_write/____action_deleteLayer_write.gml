var b = buffer_create(64, buffer_grow, 1)
buffer_write(b, buffer_u8, Actions.deleteLayer)

buffer_write(b, buffer_u16, argument0)
with (global.tiles[argument0]) {
	buffer_write(b, buffer_string, name)
	buffer_write(b, buffer_u32, tileset)
	buffer_write(b, buffer_s32, depth)
	buffer_write(b, buffer_u16, ds_map_size(tile_data))
	for (var key = ds_map_find_first(tile_data); key != undefined; key = ds_map_find_next(tile_data, key)) {
		buffer_write(b, buffer_s16, key)
		var map = tile_data[? key]
		buffer_write(b, buffer_u16, ds_map_size(map))
		for (var key2 = ds_map_find_first(map); key2 != undefined; key2 = ds_map_find_next(map, key2)) {
			buffer_write(b, buffer_s16, key2)
			buffer_write(b, buffer_u64, map[? key2])
		}
	}
}

return [b, "Deleted layer " + global.tiles[argument0].name]