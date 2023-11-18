var f = argument[0]
var d = data

var width = 88
var numberonly = false
if argument_count > 3
	numberonly = argument[3]
if argument_count > 4
	width = argument[4]
	
draw_set_align(fa_left, fa_middle)

var st = argument[1]

draw_set_font(fntConsole)


var _x = f[? _SP.x]
var _y = f[? _SP.y]+global.font_height[fntMedium]


var l = _x - floor(width / 2) - 32
var r = _x + ceil(width / 2) + 32

var yo = 0;

if (is_undefined(data[? st])) data[? st] = argument[2]

var si = 0
var intersects = point_in_rectangle(mouse_ui_x, mouse_ui_y, l, _y - 8, r, _y + 8)
if (f[? _SP.hasMouse]) {
	if ((!mouse_check_button(mb_left) || mouse_check_button_pressed(mb_left)) && intersects) {
		si = 1
		if (mouse_check_button_pressed(mb_left)) {
			f[? _SP.typing] = st
			keyboard_string = data[? st]
		}
		f[? _SP.choice] = st
	}
}

var ts = ""

if (f[? _SP.typing] == st) {
	if ((mouse_check_button_pressed(mb_any) && !intersects)
	   || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape)) {
		f[? _SP.typing] = ""
	} else {
		if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")) && clipboard_has_text()) {
			var paste = clipboard_get_text()
			var cancel = false
			if (numberonly == 2) // Allow negative
				cancel = string_int(keyboard_string + paste) != keyboard_string + paste
			else if (numberonly) // Numbers only
				cancel = string_digits(paste) != paste
			if (!cancel) {
				paste = string_replace_all(paste, "\n", "")
				paste = string_replace_all(paste, "\r", "")
				paste = string_replace_all(paste, "\t", "")
				keyboard_string += paste
			}
		} 
		if (numberonly) {
			if (numberonly == 2) // Allow negative
				keyboard_string = string_int(keyboard_string)
			else
				keyboard_string = string_digits(keyboard_string)
		}
		var limit = r - l - 8
		if (string_width(keyboard_string) >= limit) {
			var p = 1
			var newst = ""
			while (string_width(newst) < limit) {
				newst += string_char_at(keyboard_string, p)
				p++
			}
			keyboard_string = newst
		}
		data[? st] = keyboard_string
		
		if (current_time % 1000 <= 500 && string_width(keyboard_string + "_") < limit)
			ts = "_"
		si = 1
	}
}


var _ty = _y - 7

draw_sprite_part(sprFormEntry, si, 0, 0, 4, 17, l, _ty)
draw_sprite_part(sprFormEntry, si, 8, 0, 4, 17, r - 4, _ty)
draw_sprite_part_ext(sprFormEntry, si, 4, 0, 4, 17, l + 4, _ty, (r - 4 - l) / 4 - 1, 1, c_white, 1)

if (f[? _SP.typingLast] == st && f[? _SP.typing] != st) {
	___format_event(f, SP_EVENT.contentChanged, st)
}

draw_text(l + 3, _y + yo,  d[? st] + ts)



f[? _SP.y] += global.font_height[fntMedium] + 16