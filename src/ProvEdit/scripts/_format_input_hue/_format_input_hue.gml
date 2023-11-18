var f = argument[0]
var d = data

var width = 44 + 32
if argument_count > 3
	width = argument[3] / 2

var st = argument[1]

draw_set_font(fntConsole)


var _x = f[? _SP.x]
var _y = f[? _SP.y]+5

var l = _x - width
var r = _x + width


if (is_undefined(d[? st])) d[? st] = argument[2]

var si = 0
var csi = 0
var intersects = point_in_rectangle(mouse_ui_x, mouse_ui_y, l, _y - 8, r, _y + 8)
if (f[? _SP.hasMouse]) {
	if (!mouse_check_button(mb_left) && intersects) {
		f[? _SP.choice] = st
	}
}

if (f[? _SP.choice] == st) {
	si = 1
	if (mouse_check_button(mb_left)) {
		var tx = clamp(floor((mouse_ui_x - l) * 255 / (r - l)), 0, 255)
		d[? st] = tx
		csi = 2
	}
}


var hc = d[? st]
var cc = make_colour_hsv(hc, 180, 255)
var tw = r - l - 2
var cx = (hc * tw / 255) + l + 1

draw_sprite_stretched(sprFormHueSelectorBackdrop, si, l, _y - 8, r - l, 18)
draw_sprite_stretched(sprFormHueSelector, si, l + 1, _y - 7, tw, 15)

draw_sprite(sprFormHueSelectorChoice, csi, cx, _y + 4)
draw_sprite_ext(sprFormHueSelectorChoice, csi + 1, cx, _y + 4, 1, 1, 0, cc, 1)

f[? _SP.y] += 20