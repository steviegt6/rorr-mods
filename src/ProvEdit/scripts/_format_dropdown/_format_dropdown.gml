// identifier, default, [width]
var f = argument[0]
var d = data

var width = 88
if argument_count > 4
	width = argument[4]
	
draw_set_align(fa_left, fa_middle)

var st = argument[1]

draw_set_font(fntConsole)


var _x = f[? _SP.x]
var _y = f[? _SP.y]+global.font_height[fntMedium]


var l = _x - floor(width / 2) - 32
var r = _x + ceil(width / 2) + 32
var limit = floor((r - l - 23) / 7)
var yo = 0;

if (is_undefined(d[? st])) {
	d[? st] = argument[2]
}

var si = 0
var open = false
var clicked = ""
with (objDropdownDisplay) {
	if (identifier == st) {
		if (!is_undefined(self.clicked)) {
			if (d[? st] != self.clicked) {
				d[? st] = self.clicked
				with (other)
					___format_event(f, SP_EVENT.contentChanged, st)
			}
			instance_destroy()
		} else {
			open = true
		}
	}
}
var intersects = point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, l, _y - 8, r, _y + 8)
if (f[? _SP.hasMouse] && intersects) {
	f[? _SP.choice] = st
	if (!mouse_check_button(mb_left) || mouse_check_button_pressed(mb_left) || open) {
		si = 1
	} else {
		si = 2
	}
} else if (open) {
	si = 1
}

if (f[? _SP._clicked] == st) {
	if (!open) {
		open = true
		with (instance_create_depth(l, _y + 10, depth - 1, objDropdownDisplay)) {
			identifier = st
			self.width = width + 64
			owner = f[? _SP._owner]
			elements = argument[3]
		}
	}
}

var _ty = _y - 7

draw_sprite_part(sprFormDropdown, min(si, 1), 0, 0, 4, 17, l, _ty)
draw_sprite(sprFormDropdownButton, si, r - 17, _ty)
draw_sprite_part_ext(sprFormDropdown, min(si, 1), 4, 0, 4, 17, l + 4, _ty, (r - 17 - l) / 4 - 1, 1, c_white, 1)

draw_text(l + 3, _y + yo, string_shorten_monospace(d[? st], limit))//d[? st])


f[? _SP.y] += global.font_height[fntMedium] + 16