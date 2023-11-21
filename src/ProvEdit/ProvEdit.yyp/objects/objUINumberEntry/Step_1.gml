/// @description typing
if (typing) {
	
	var done = false
	if (mouse_check_button(mb_any) && !point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, y, x + width, y + 15))
		done = true
	if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape))
		done = true
		
	if (done) {
		typing = false
		keyboard_on = true
		event_user(0)
	} else {
		for (var i = ord("0"); i <= ord("9"); i++) {			
			if (keyboard_check_pressed(i)) {
				contents = clamp(contents * 10 + i - ord("0"), limit[0], limit[1])
			}
		}
		if (keyboard_check_pressed(vk_backspace))
			contents = floor(contents/10)
	}
}