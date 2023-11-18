function tile_get_img_x(argument0) {
	gml_pragma("forceinline")
	return (argument0 & 0xFFFF0000) >> 16


}
