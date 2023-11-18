x = parent_choice * 36 + 2
y = ui_top

if ((mouse_free || occupied_mouse) && point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, y, x + width, y + height)) {
	mouse_state = MouseStates.busyUI
	occupied_mouse = true
} else if (occupied_mouse && clicked_choice == 0) {
	mouse_state = MouseStates.ready
	occupied_mouse = false
}

if ((!occupied_mouse && mouse_check_button_pressed(mb_left)) ||
	(mouse_state != MouseStates.ready && mouse_state != MouseStates.busyUI) ||
	instance_exists(objParseFormat))
	instance_destroy()


elements = min(elements + 1, array_length_1d(contents) - 1)
height = elements * 16 + 2

if (width == 0) {
	// Calculate width on first frame
	for (var i = 1; i < array_length_1d(contents); i++) {
		var c = contents[i]
		var l = array_length_1d(c)
		var w = 16
		draw_set_font(fntMedium)
		w += string_width(c[0])
		draw_set_font(fntTinyCasable)
		if l > 1
			w += string_width(c[1])
		width = max(width, w)
	}
}