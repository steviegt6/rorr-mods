// Toggle open
if (!disabled && keyboard_check_pressed(vk_tab) && mouse_state != MouseStates.busyDrawing && (height == 0 || height == maxheight))
	open = !open

// Opening / closing
if (open) {
	// Resize to use more space when available
	var _wheight = ui_bottom_raw - ui_top;
	var _newheight;
	if (_wheight <= 800) {
		_newheight = 64
	} else {
		// Use 25% of extra window space
		_newheight = floor(64 + (_wheight - 800) / 4)
	}
	if (_newheight != maxheight) {
		maxheight = _newheight
	}
	
	if (height != maxheight) {
		height = lerp(height, maxheight, 0.14)
		if (height > maxheight - 1)
			height = maxheight
		global.__ui_bottom = floor(display_get_gui_height() - height)
	}
	
	if (typing && (disabled || keyboard_check_pressed(vk_escape) || (!captured && mouse_check_button_pressed(mb_any)))) {
		objMain.control_on = true
		keyboard_on = true
		typing = false
		if (mouse_state == MouseStates.typing)
			mouse_state = MouseStates.ready
	}
	
	if (typing) {
		typeheight = lerp(typeheight, line_height, 0.1)
		// Send message
		if (keyboard_check_pressed(vk_enter) && string_replace_all(keyboard_string, " ", "") != "") {
			var st = global.net_username + ": " + keyboard_string;
			scr_message(st)
			net_sync_chat(st, -1)
			scroll = 0
			keyboard_string = ""
		}
	} else {
		if (typeheight != 0) {
			typeheight = lerp(typeheight, 0, 0.1)
			if (typeheight < 0.3)
				typeheight = 0
		}
	}
	
	//Control scrolling
	var mdelta = 0
	if (captured) {
		// Mouse scrolling
		mdelta = mouse_wheel_up() - mouse_wheel_down()
	}
	maxscroll = floor(max((ds_list_size(messages) - floor(maxheight / line_height)) * line_height + typeheight, 0));
	scroll = clamp(scroll + mdelta * 18, 0, maxscroll);
	
	var do_type = false;
	if (mouse_ui_y > ui_bottom) {
		if (mouse_free || captured) {
			mouse_state = MouseStates.busyUI
			captured = true
			if (mouse_check_button_pressed(mb_left))
				do_type = true
		}
	} else if (captured) {	
		mouse_state = MouseStates.ready	
		captured = false
	}
	if (keyboard_check_pressed(vk_enter)) {
		do_type = true
	}
	if (do_type && !typing) {
		typing = true
		objMain.control_on = false
		keyboard_on = false
		keyboard_string = ""
		mouse_state = MouseStates.typing
	}
} else {
	if (captured) {	
		mouse_state = MouseStates.ready	
		captured = false
	}
	if (typing) {
		objMain.control_on = true
		keyboard_on = true
		typing = false;
	}
	if (height != 0) {
		height = lerp(height, 0, 0.14)
		if (height < 0.3) {
			height = 0
			typeheight = 0
			scroll = 0
		}
		global.__ui_bottom = floor(display_get_gui_height() - height)
	}
}
