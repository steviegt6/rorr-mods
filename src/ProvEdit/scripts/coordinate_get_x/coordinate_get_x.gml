/*gml_pragma("global", @'
	var v = coordinates_pack(0xFFFFFFFF - 7200, 0xFFFFFFFF - 7200);
	show_message(coordinate_get_x(v))
	show_message(coordinate_get_y(v))
')*/
gml_pragma("forceinline")
return ((argument0 >> 32) & 0x00000000FFFFFFFF) - 0xEFFFFFFF