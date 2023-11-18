function _format_checkbox() {
	var f = argument[0]

	var st = argument[1]

	if (is_undefined(data[? st])) data[? st] = argument[2]

	var h = global.font_height[fntMedium]

	var _x = f[? _SP.x]
	var _y = f[? _SP.y] + 13

	var si = 0
	if (f[? _SP.hasMouse]) {
		if (!mouse_check_button(mb_left) && point_in_rectangle(mouse_ui_x, mouse_ui_y, _x - 13, _y - 13, _x + 12, _y + 12)) {
			f[? _SP.choice] = st
		}
	}

	if (f[? _SP.choice] == st) {
		if (mouse_check_button(mb_left)) {
			si = 0
		} else {
			si = 1
		}
		if (mouse_check_button_pressed(mb_left))
			data[? st] = data[? st] ? 0 : 1
	}
	if (data[? st]) {
		si += 2
	}


	var _ty = _y - 7

	___format_backdrop(f, h + 24)

	draw_sprite(sprFormCheckbox, si, _x, _y)


	f[? _SP.y] += h + 16


}
