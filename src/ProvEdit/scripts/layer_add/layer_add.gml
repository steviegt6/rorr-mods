/// @function layer_add(name, tileset, depth)
/// @param name string
/// @param tileset id
/// @param depth number

global.layers_total += 1
with (instance_create_depth(0, 0, argument2, objTileLayer)) {
	name = argument0
	tileset = argument1
	index = array_length_1d(global.tiles)
	global.tiles[index] = id
	return id
}