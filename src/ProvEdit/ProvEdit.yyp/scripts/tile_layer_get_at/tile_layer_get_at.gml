/// @fynction tile_layer_get_at
/// @param layerID
/// @param x
/// @param y
function tile_layer_get_at(argument0, argument1, argument2) {
	with (global.tiles[argument0]) {
		var m = tile_data[? argument1]
		if (m == undefined) {
			return undefined
		} else {
			return m[? argument2]
		}
	}



}
