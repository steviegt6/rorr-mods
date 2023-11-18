/// @function brush_same_tile_pool(layer id, x, y, tile list)
/// @description Returns whether the tile at (x,y) belongs to the tile list given.
/// @param id
/// @param x
/// @param y
/// @param tilelist

var prev_tile = tile_layer_get_at(argument0, argument1, argument2)
var same_tile_pool = false
for (var i = 0; i < array_length_1d(argument3) && !same_tile_pool; i++) {
	var curr_tile = argument3[i]
	if (tile_pack(curr_tile[0], curr_tile[1]) == prev_tile)
		same_tile_pool = true
}
return same_tile_pool