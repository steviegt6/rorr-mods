/// @description 
var hover_choice = 0
if (mouse_ui_click_x >= x && mouse_ui_click_x < x + width) {
	for (var i = 1; i <= elements; i++) {
		var bottom = y + i * 16;
		if (mouse_ui_click_y >= bottom - 14 && mouse_ui_click_y < bottom - 2) {
			var c = contents[i]
			var l = array_length_1d(c)
			var disabled = false
			if (l > 2 && c[2] != undefined) disabled = script_execute(c[2])
			if (l > 3) objMain.mouse_tip = c[3]
			if (!disabled) hover_choice = i
			break
		}
	}
}


if (clicked_choice == 0) {
	choice = hover_choice
	if (mouse_check_button_pressed(mb_left)) {
		clicked_choice = choice
	}
} else {
	choice = clicked_choice
	if (mouse_check_button_released(mb_left)) {
		if (hover_choice == clicked_choice) {
			var c = contents[clicked_choice]
			__process_topbar_choice(c[0])
			instance_destroy()
		}
		clicked_choice = 0
	}
}