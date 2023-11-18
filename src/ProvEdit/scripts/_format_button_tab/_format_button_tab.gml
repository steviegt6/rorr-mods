var f = argument[0]

draw_set_align(fa_middle, fa_middle)




if (argument_count > 3)
	draw_set_font(argument[3])
else
	draw_set_font(fntMedium)
var st = argument[1]
var w = string_width(st)
var h = string_height(st)

var _x = f[? _SP.x]
var _y = f[? _SP.y]+ floor(h / 2) + 12

var l = _x - ceil(w / 2) - 6
var r = _x + ceil(w / 2) + 6

var yo = 2
var si = argument[2] ? 2 : 0

var _ty = _y - 7


if (argument[2] != 1) {
	if (f[? _SP.hasMouse]) {
		if (!mouse_check_button(mb_left) && point_in_rectangle(mouse_ui_x, mouse_ui_y, l, _y - 8, r, _y + 8)) {
			f[? _SP.choice] = st
		}
	}

	if (f[? _SP.choice] == st) {
		si = 1
	}
}


draw_sprite_part(sprFormTab, si, 0, 0, 4, 20, l, _ty)
draw_sprite_part(sprFormTab, si, 74 - 4, 0, 4, 20, r - 4, _ty)
draw_sprite_part(sprFormTab, si, 4, 0, w + 4, 20, l + 4, _ty)

if argument[2] == 1
	draw_text_outline(_x + 1, _y + yo + 1, st, c_dkgray, c_white)
else {
	draw_text_colour(_x + 1, _y + yo - 2, st, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1)
}

f[? _SP.y] += h + 24