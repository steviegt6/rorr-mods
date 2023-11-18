/// @fynction tile_layer_set_at
/// @param layerID
/// @param x
/// @param y
/// @param value
function tile_layer_set_at(argument0, argument1, argument2, argument3) {
	with (global.tiles[argument0]) {
		var m = tile_data[? argument1]
		if (argument3 == undefined) {
			if (m != undefined) {
				ds_map_delete(m, argument2)
				if (ds_map_size(m) == 0) {
					ds_map_destroy(m)
					ds_map_delete(tile_data, argument1)
				}
			}
		} else {
			if (m == undefined) {
				m = ds_map_create()
				ds_map_set(tile_data, argument1, m)
				//tlie_data[? argument1] = m
			}
			if (m != undefined) {
				m[? argument2] = argument3
			}
		}
	}



}
