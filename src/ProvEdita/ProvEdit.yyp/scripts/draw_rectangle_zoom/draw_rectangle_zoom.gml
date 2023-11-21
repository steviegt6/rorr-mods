function draw_rectangle_zoom(argument0, argument1, argument2, argument3, argument4) {
	gml_pragma("forceinline")
	if (global.view_zoom > 1)
		argument4 *= global.view_zoom
	var tx = argument0 - 1, ty = argument1 - 1
	var tw = argument2 - 1, th = argument3 - 1
	draw_line_width(tx, ty, tw, ty, argument4)
	draw_line_width(tw, ty, tw, th, argument4)
	draw_line_width(tx, ty, tx, th, argument4)
	draw_line_width(tx, th, tw, th, argument4)


}
