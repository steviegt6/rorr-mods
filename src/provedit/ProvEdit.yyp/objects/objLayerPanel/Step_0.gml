occupied_mouse = captured
if (!captured && mouse_check_button_pressed(mb_any)) {
	instance_destroy()
}