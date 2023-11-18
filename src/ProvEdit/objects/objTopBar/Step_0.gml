

if ((mouse_free || (mouse_state == MouseStates.busyUI && occupied_mouse)) && mouse_ui_y < ui_top) {
	mouse_state = MouseStates.busyUI
	occupied_mouse = true
	
	if (mouse_ui_x < button_count * 36) {
		choice = floor(mouse_ui_x / 36)
		if (mouse_check_button_pressed(mb_left))
			choice_clicked = choice;
	} else
		choice = -1
		
	if (choice_clicked != -1 && !mouse_check_button(mb_left)) {
		with (instance_create_depth(0, 0, 9999, objTopBarMenu)) {
			parent_choice = other.choice_clicked
			contents = other.buttons[parent_choice]
			other.menu_open = id
		}
		choice_clicked = -1
	}		
} else if (occupied_mouse) {
	choice = -1
	if (choice_clicked != -1 && !mouse_check_button(mb_left))
		choice_clicked = -1
	if (!choice_clicked) {
		mouse_state = MouseStates.ready
		occupied_mouse = false
	}
}
