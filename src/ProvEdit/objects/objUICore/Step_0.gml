if (occupied_mouse && instance_exists(objParseFormat)) {
	mouse_state = MouseStates.ready
	occupied_mouse = false
} else if ((mouse_free || (mouse_state == MouseStates.busyUI && occupied_mouse)) &&
	(point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, ui_left, ui_bottom - 28, ui_left + 127, ui_bottom)
	|| point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, ui_left, ui_bottom - 36, ui_left + 52, ui_bottom)
	)) {
	mouse_state = MouseStates.busyUI
	occupied_mouse = true
} else if (occupied_mouse) {
	mouse_state = MouseStates.ready
	occupied_mouse = false
}