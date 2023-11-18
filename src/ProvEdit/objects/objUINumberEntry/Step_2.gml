/// @description 

event_inherited();

if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x - 8, y, x + width + 8, y + 15))
	objMain.mouse_tip = tip

if (clicked_part != -1 && mouse_check_button_released(mb_left)) {
	if (point_in_rectangle(mouse_ui_x, mouse_ui_y, x - 8, y, x + width + 8, y + 15)) {
		if (clicked_part == 0 && mouse_ui_x < x)
			contents--
		else if (clicked_part == 1 && mouse_ui_x > x + width)
			contents++
		event_user(0)
	}
	clicked_part = -1
}


