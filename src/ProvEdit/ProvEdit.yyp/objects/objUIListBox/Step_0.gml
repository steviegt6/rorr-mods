var tyy = 23


var release_index = -1
if (mouse_check_button_released(mb_left)) {
	release_index = hover
}

hover = -1

var oy = 0
if (number_visible < count) {
	oy = -6
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width - 6, y + 10, x + width, y + height)) {
		hover = -2
	}
}
for (var i = index_visible; tyy < height && i < count; i++) {
	var ytyy = y + tyy
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + oy, ytyy - 12, x + width + oy, ytyy - 1)) {
		hover = i
	}
	tyy += 12
}

if (release_index >= 0 && hover == release_index) {
	choice = hover
	event_user(0)
}

if (hover != -1) {
	index_visible = clamp(index_visible - mouse_wheel_up() + mouse_wheel_down(), 0, max(count - number_visible, 0))
}