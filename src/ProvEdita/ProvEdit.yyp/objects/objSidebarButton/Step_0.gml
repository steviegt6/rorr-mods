
if (objSidebar.occupied_mouse) {
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, y, x + 32, y + 32)) {
		var other_clicked = false;
		with (objSidebarButton) {
			if (clicked_on && id != other.id) {
				other_clicked = true
				break
			}
		}
		if (!other_clicked) {
			objMain.mouse_tip = long_tip
			hover_time += 1
			if (mouse_check_button_pressed(mb_left))
				clicked_on = true
			else if (mouse_check_button_released(mb_left) && clicked_on)
				event_user(1)
		}
	} else {
		if (!clicked_on)
			hover_time = 0
	}
} else {
	if (!clicked_on)
		hover_time = 0
}
if (clicked_on) { 
	if (!mouse_check_button(mb_left))
		clicked_on = false
	else
		objSidebar.force_occupy = true
}