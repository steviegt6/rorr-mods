gml_pragma("forceinline")
if (is_undefined(argument0[? _SP.backdropColour]))
	exit

var ix = argument0[? _SP.x]
var iw = argument0[? _SP.width]

var iy = argument0[? _SP.y]

var col = draw_get_colour()
draw_set_colour(argument0[? _SP.backdropColour])
draw_rectangle(ix - floor(iw) / 2, iy, ix + floor(iw) / 2 - 1, iy + argument1 - 1, false)
draw_set_colour(col)