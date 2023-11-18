var f = argument[0]

var align
if (argument_count > 3)
	align = argument[3]
else
	align = fa_middle
	
draw_set_align(align, fa_middle)

if (argument_count > 2)
	draw_set_font(argument[2])
else
	draw_set_font(fntMedium)

var st = argument[1]
var maxw = f[? _SP.width] - 4
var th  = string_height("|")
var w = string_width_ext(st, th, maxw)
var h = string_height_ext(st, th, maxw)

___format_backdrop(f, h + 16)

var tx = f[? _SP.x]
var ty = f[? _SP.y] + floor(h / 2) + 8
var col = draw_get_colour()
draw_set_colour(c_dkgray)
draw_text_ext(tx + 3, ty + 3, st, th, maxw)
draw_text_ext(tx + 2, ty + 2, st, th, maxw)
draw_set_colour(c_black)
draw_text_ext(tx - 1, ty - 1, st, th, maxw)
draw_text_ext(tx - 1, ty + 1, st, th, maxw)
draw_text_ext(tx + 1, ty + 1, st, th, maxw)
draw_text_ext(tx + 1, ty - 1, st, th, maxw)
draw_set_colour(col)
draw_text_ext(tx, ty, st, th, maxw)



f[? _SP.y] += h + 16