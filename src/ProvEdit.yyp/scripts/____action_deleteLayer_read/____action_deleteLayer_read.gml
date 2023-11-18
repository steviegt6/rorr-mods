function ____action_deleteLayer_read(argument0, argument1) {
	var b = argument0;

	var idx = buffer_read(b, buffer_u16)
	if (argument1) {
		var _name = buffer_read(b, buffer_string)
		var _tileset = buffer_read(b, buffer_u32)
		var _depth = buffer_read(b, buffer_s32)
	
		var size =  array_length_1d(global.tiles) + 1
		for (var i = idx + 1; i < size; i++) {
			global.tiles[i] = global.tiles[i - 1]
			global.tiles[i].index = i
		}
	
		with (instance_create_depth(0, 0, _depth, objTileLayer)) {
			name = _name
			tileset = _tileset
			index = idx
			global.tiles[idx] = id
			repeat (buffer_read(b, buffer_u16)) {
				var _key = buffer_read(b, buffer_s16)
				var _map = ds_map_create()
				tile_data[? _key] = _map
				repeat (buffer_read(b, buffer_u16)) {
					var _key2 = buffer_read(b, buffer_s16)
					_map[? _key2] = buffer_read(b, buffer_u64)
				}
			}
		}
	} else {
		layer_delete(global.tiles[idx])
	}


}
