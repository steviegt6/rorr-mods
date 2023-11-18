function coordinate_get_y(argument0) {
	gml_pragma("forceinline")
	return (argument0 & 0x00000000FFFFFFFF) - 0xEFFFFFFF


}
