var b = argument0;

var _layer = global.tiles[buffer_read(b, buffer_u16)]
var _field = buffer_read(b, buffer_u8)

with (_layer) {
	switch (_field) {
		case 0:
			// NAME
			var redo = buffer_read(b, buffer_string)
			var undo = buffer_read(b, buffer_string)
			name = !argument1 ? redo : undo
			break
		case 1:
			// TILESET
			var redo = buffer_read(b, buffer_u32)
			var undo = buffer_read(b, buffer_u32)
			tileset = !argument1 ? redo : undo
			break
		case 2:
			// DEPTH
			var redo = buffer_read(b, buffer_s32)
			var undo = buffer_read(b, buffer_s32)
			depth = !argument1 ? redo : undo
			break
	}
}