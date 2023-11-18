gml_pragma("global", @'
	for (var i = 0; font_exists(i); i++) {
		draw_set_font(i)
		global.font_height[i] = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
	}
')


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

draw_text_ext(f[? _SP.x], f[? _SP.y] + floor(h / 2) + 8, st, th, maxw)

f[? _SP.y] += h + 16