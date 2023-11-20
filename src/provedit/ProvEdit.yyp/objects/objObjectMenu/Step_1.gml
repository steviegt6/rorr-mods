
if (move_bar) {
	if (!mouse_check_button(mb_left)) {
		move_bar = false
		if (objMouseCaptureHandler.super_force_capture == id)
			objMouseCaptureHandler.super_force_capture = noone
	} else {
		world_x += mouse_x - move_bar_x
		world_y += mouse_y - move_bar_y
		move_bar_x = mouse_x
		move_bar_y = mouse_y
	}
}
