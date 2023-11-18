if (!typing)
	draw_sprite_ext(sprFieldSegment, 0, x, y, width, 1, 0, c_white, 1)
else {
	draw_set_colour(Colours.sidebar_light)
	draw_rectangle(x, y, x + width - 1, y + 14, false)
}

var hover_l = 0
var hover_r = 0
if (parent.occupied_mouse) {
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x - 8, y, x + width + 8, y + 15)) {
		var click_state
		if (mouse_check_button(mb_left))
			click_state = 2
		else
			click_state = 1
		if (mouse_ui_click_x < x) {
			hover_l = click_state
			clicked_part = 0
		} else if (mouse_ui_click_x > x + width) {
			hover_r = click_state
			clicked_part = 1
		} else if (keyboard_on && mouse_check_button_released(mb_left)) {
			typing = true
			keyboard_on = false
			contents = 0
		}
	}
}

draw_sprite(sprFieldButtonLeft, hover_l, x, y)
draw_sprite(sprFieldButtonRight, hover_r, x + width, y)

draw_set_colour(c_white)
draw_set_halign(fa_middle)
draw_set_valign(fa_bottom)
draw_set_font(fntMedium)

draw_text(x + ceil(width / 2), y + 13, contents)