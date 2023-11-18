function _format_input_number() {
	var f = argument[0]
	var d = data

	var width = 88
	var step = 1
	var limit = undefined
	if argument_count > 3
		limit = argument[3]
	if argument_count > 4
		step = argument[4]
	if argument_count > 5
		width = argument[5]
	
	draw_set_align(fa_middle, fa_middle)

	var st = argument[1]

	draw_set_font(fntConsole)


	var _x = f[? _SP.x]
	var _y = f[? _SP.y]+global.font_height[fntMedium]


	var l = _x - floor(width / 2) - 32
	var r = _x + ceil(width / 2) + 32

	if (is_undefined(data[? st])) data[? st] = argument[2]

	var si = 0
	var si_l = 0, si_r = 0;
	var intersects = point_in_rectangle(mouse_ui_x, mouse_ui_y, l, _y - 8, r, _y + 8)
	if (f[? _SP.hasMouse]) {
		if ((!mouse_check_button(mb_left) || mouse_check_button_pressed(mb_left)) && intersects) {
			if (mouse_ui_x <= l + 16) {
				var lst = st + "%_l"
				if (f[? _SP.choice] != lst && mouse_check_button_released(mb_left)) {
					d[? st] = is_undefined(limit) ? d[? st] - step : max(d[? st] - step, limit[0])
				}
				f[? _SP.choice] = lst
				si_l = 1
			} else if (mouse_ui_x >= r - 17) {
				var rst = st + "%_r"
				if (f[? _SP.choice] != rst && mouse_check_button_released(mb_left)) {
					d[? st] = is_undefined(limit) ? d[? st] + step : min(d[? st] + step, limit[1])
				}
				f[? _SP.choice] = rst
				si_r = 1
			} else {
				si = 1
				if (mouse_check_button_pressed(mb_left)) {
					f[? _SP.typing] = st
					keyboard_string = string(data[? st])
				}
				f[? _SP.choice] = st
			}
		} else if (f[? _SP.choice] == st + "%_l") {
			si_l = 2
		} else if (f[? _SP.choice] == st + "%_r") {
			si_r = 2
		}
	}

	var tst = data[? st]
	if (f[? _SP.typing] == st) {
		if ((mouse_check_button_pressed(mb_any) && !intersects)
		   || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape)) {
			f[? _SP.typing] = ""
		} else {
			var maxwidth = floor((width + 32) / 7)
			keyboard_string = string_copy(keyboard_string, 1, maxwidth)
			tst = keyboard_string
			si = 1
		}
	}


	var _ty = _y - 7

	if (f[? _SP.typingLast] == st && f[? _SP.typing] != st) {
		data[? st] = is_undefined(limit) ? real("0" + keyboard_string) : clamp(real("0" + keyboard_string), limit[0], limit[1])
		tst = data[? st]
		___format_event(f, SP_EVENT.contentChanged, st)
	}

	draw_sprite(sprFormNumberField, 2 + si_l, l, _ty)
	draw_sprite(sprFormNumberField, 5 + si_r, r - 13, _ty)
	draw_sprite_ext(sprFormNumberField, si, l + 13, _ty, (r - 13 - l) / 13 - 1, 1, 0, c_white, 1)

	draw_text(l + floor((r - l) / 2), _y,  tst)

	f[? _SP.y] += global.font_height[fntMedium] + 16


}
