/// x, y, brush map
function tile_key_at(argument0, argument1, argument2) {
	gml_pragma("forceinline")

	var t

	t = tile_layer_get_at(objMain.current_layer, argument0, argument1)

	if (t != undefined) {
		var m = argument2[? string(tile_get_img_x(t)) + ", " + string(tile_get_img_y(t))]
		if (m != undefined)
			return m
		else
			return -1
	} else {
		return -1
	}



}
