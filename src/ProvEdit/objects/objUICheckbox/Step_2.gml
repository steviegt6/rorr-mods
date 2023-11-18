/// @description 

event_inherited();

if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x - 1, y - 1, x + 14, y + 14)) {
	objMain.mouse_tip = tip
	if (mouse_check_button_released(mb_left) && parent.occupied_mouse) {
		contents = !contents
		event_user(0)
	}
}