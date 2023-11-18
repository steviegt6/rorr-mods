function _format_button() {
	var f = argument[0]

	draw_set_align(fa_middle, fa_middle)




	if (argument_count > 2)
		draw_set_font(argument[2])
	else
		draw_set_font(fntMedium)
	var st = argument[1]
	var w = string_width(st)
	var h = string_height(st)

	var _x = f[? _SP.x]
	var _y = f[? _SP.y]+ floor(h / 2) + 12

	var l = _x - ceil(w / 2) - 6
	var r = _x + ceil(w / 2) + 6

	var yo = 0;

	var si = 0
	if (f[? _SP.hasMouse]) {
		if (!mouse_check_button(mb_left) && point_in_rectangle(mouse_ui_x, mouse_ui_y, l, _y - 8, r, _y + 8)) {
			f[? _SP.choice] = st
		}
	}

	if (f[? _SP.choice] == st) {
		if (mouse_check_button(mb_left)) {
			si = 2
			yo = 2
		} else {
			si = 1
		}
	}

	var _ty = _y - 7

	___format_backdrop(f, h + 24)

	draw_sprite_part(sprFormButton, si, 0, 0, 4, 17, l, _ty)
	draw_sprite_part(sprFormButton, si, 8, 0, 4, 17, r - 4, _ty)
	draw_sprite_part_ext(sprFormButton, si, 4, 0, 4, 17, l + 4, _ty, (r - 4 - l) / 4 - 1, 1, c_white, 1)
	draw_text(_x, _y + yo, st)



	f[? _SP.y] += h + 24


}
