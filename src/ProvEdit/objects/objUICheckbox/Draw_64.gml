
var frame = contents ? 3 : 0

if (parent.occupied_mouse) {
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x - 1, y - 1, x + 14, y + 14)) {
		if (!mouse_check_button(mb_left))
			frame += 1
	}
}

draw_sprite(sprCheckbox, frame, x, y)
