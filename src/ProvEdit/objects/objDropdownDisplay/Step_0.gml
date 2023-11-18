
if (elements_visible < array_length_1d(elements) && elements_visible < max_visible) {
	elements_visible += 1
	height = elements_visible * 15
	var _bottom = display_get_gui_height()
	if (y + height > _bottom) {
		y -= y + height - _bottom
	}
}

if (captured) {
	var last_hover = hover_element
	hover_element = clamp(floor((mouse_ui_click_y - y) / 15), 0, elements_visible - 1)
	if (last_hover == hover_element && mouse_check_button_released(mb_left)) {
		clicked = elements[hover_element]
	}
} else {
	hover_element = -1
}

if ((owner != noone && !instance_exists(owner))
|| (mouse_check_button_pressed(mb_any) && !captured)
|| (objMain.window_was_resized)) {
	instance_destroy()
}