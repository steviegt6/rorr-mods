/// @description 
if ((mouse_free || (mouse_state == MouseStates.busyUI && occupied_mouse))
&& point_in_rectangle(mouse_ui_x, mouse_ui_y, x - 9, y - 72, x + 9, y)) {
	mouse_state = MouseStates.busyUI
	occupied_mouse = true
	
	if (clicked_choice == -1) {
		if (point_in_rectangle(mouse_ui_x, mouse_ui_y, x - 7, y - 72, x + 7, y - 72 + 59)) {
			choice = floor((mouse_ui_y - (y - 72)) / 15)
			if (mouse_check_button_pressed(mb_left))
				clicked_choice = choice
		}
	}
} else if (occupied_mouse && clicked_choice == -1) {
	choice = -1
	mouse_state = MouseStates.ready
	occupied_mouse = false
}

if (clicked_choice != -1 && mouse_check_button_released(mb_left)) {
	if (floor((mouse_ui_y - (y - 72)) / 15) == clicked_choice) {
		event_user(0)
		instance_destroy()
	} else
		clicked_choice = -1
}

if ((!occupied_mouse && mouse_check_button_pressed(mb_left)) ||
	(mouse_state != MouseStates.ready && mouse_state != MouseStates.busyUI) ||
	instance_exists(objParseFormat))
	instance_destroy()
