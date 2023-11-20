
if (requires_action) {
	objMain.control_on = -10
	keyboard_on = -10
	objMouseCaptureHandler.force_capture = id
}

if (can_close) {
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width - 16 - 8, y + 4, x + width- 8, y + 4 + 16)) {
		if (mouse_check_button_released(mb_left) && close_button_state == 2) {
			instance_destroy()
			exit
		}
		close_button_state = 1
		if (mouse_check_button(mb_left)) {
			close_button_state = 2	
		}
	} else {
		close_button_state = 0
	}
}