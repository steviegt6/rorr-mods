/// @fynction tile_layer_delete_at
/// @param layerID
/// @param x
/// @param y
function tile_layer_delete_at(argument0, argument1, argument2) {
	gml_pragma("forceinline")
	tile_layer_set_at(argument0, argument1, argument2, undefined)


}
