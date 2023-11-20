x = ui_left + left
y = ui_bottom - 25

if (objUICore.occupied_mouse) {
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, y, x + 20, y + 20)) {
		hover_time += 1
		if (mouse_check_button_pressed(mb_left))
			clicked_on = true
		else if (mouse_check_button_released(mb_left) && clicked_on)
			event_user(0)
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
}

if (identity == 3) {
	selected = instance_exists(objSnapCorners)
	if (selected) {
		objSnapCorners.x = x + 10
		objSnapCorners.y = y - 6
	}
	
}

// Shortcuts
if (keyboard_on) {
	switch (identity) {
		// Zoom in
		case 0: if (keyboard_check_pressed(187)) event_user(0) break
		// Zoom out
		case 1: if (keyboard_check_pressed(189)) event_user(0) break
		// Reset zoom
		case 2: if (keyboard_check_pressed(ord("0"))) event_user(0) break
		// Settings
		case 4: if (keyboard_check_pressed(vk_escape)) event_user(0) break
	}
}
