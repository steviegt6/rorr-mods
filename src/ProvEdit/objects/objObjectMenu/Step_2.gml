if (!instance_exists(parent) || objMain.edit_mode != EditModes.objects) {
	instance_destroy()
	exit;
}

x = floor(world_to_gui_x(world_x))
y = floor(world_to_gui_y(world_y))

if (captured && hover_bar && mouse_check_button_pressed(mb_left)) {
	move_bar = true
	move_bar_x = mouse_x
	move_bar_y = mouse_y
	objMouseCaptureHandler.super_force_capture = id
}

hover_bar = captured && mouse_ui_click_y < y + 12