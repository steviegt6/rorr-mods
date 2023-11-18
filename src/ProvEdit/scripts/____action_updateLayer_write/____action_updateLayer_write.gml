var b = buffer_create(16, buffer_grow, 1)
buffer_write(b, buffer_u8, Actions.updateLayer)
buffer_write(b, buffer_u16, argument0) // Layer index
buffer_write(b, buffer_u8, argument1) // Field type

with (global.tiles[argument0]) {
	switch (argument1) {
		case 0: // NAME
			buffer_write(b, buffer_string, argument2)
			buffer_write(b, buffer_string, name)
			break
		case 1: // Tileset
			buffer_write(b, buffer_u32, argument2)
			buffer_write(b, buffer_u32, tileset)
			break
		case 2: // Depth
			buffer_write(b, buffer_s32, argument2)
			buffer_write(b, buffer_s32, depth)
			break
	}
}

return [b, "Updated layer " + global.tiles[argument0].name]