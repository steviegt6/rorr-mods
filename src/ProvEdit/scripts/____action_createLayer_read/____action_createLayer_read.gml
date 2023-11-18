var b = argument0;

var _name = buffer_read(b, buffer_string)
var _tileset = buffer_read(b, buffer_u32)
var _depth = buffer_read(b, buffer_s32)

if (!argument1) {
	layer_add(_name, _tileset, _depth)
} else {
	for (var i = 0; i < array_length_1d(global.tiles); i++) {
		var _layer = global.tiles[i]
		if (_layer.name == _name) {
			layer_delete(_layer)
			global.layers_total -= 1
			break
		}
	}
}
