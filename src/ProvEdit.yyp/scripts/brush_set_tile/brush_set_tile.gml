/// @function brush_set_tile(layer id, x, y, tile x, tile y)
/// @description Sets a tile and updates (over)written buffers.
/// @param id
/// @param x
/// @param y
/// @param tilex
/// @param tiley
/// @param tilelist
function brush_set_tile(argument0, argument1, argument2, argument3, argument4) {

	var prev_tile = tile_layer_get_at(argument0, argument1, argument2)
	var pos = coordinates_pack(argument1, argument2)
	if (written[? pos] == undefined) {
		overwritten[? pos] = prev_tile
	}
	__tile_layer_set_tile(argument0, argument1, argument2, argument3, argument4)
	written[? pos] = tile_pack(argument3, argument4)


}
