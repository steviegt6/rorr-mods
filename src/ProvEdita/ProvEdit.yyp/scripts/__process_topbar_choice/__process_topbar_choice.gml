function __process_topbar_choice(argument0) {
	switch (string_lower(argument0)) {
		// EDIT MENU
		case "undo":
			with (objHistory) event_user(0)
			break
		case "redo":
			with (objHistory) event_user(1)
			break
		
		// FILE MENU
		case "save":
			__level_save(false)
			break
		case "save as":
			__level_save(true)
			break
		case "load":
			__level_load()
			break
		case "export lua":
			__level_export()
			break
		case "new":
			show_popup("Confirm Action", 200, 80, [
				[_format_colour, c_black],
				[_format_text, "Any unsaved changes will be lost, continue?"],
				[_format_colour, c_white],
				[_format_left],
				[_format_button, "Cancel"],
				[_format_right],
				[_format_button, "Continue"],
			], ___popup_new_level_handle_button)
			break
		case "export image":
			var popup = show_popup("Export Level to Image", 320, 160, [
				[_format_text_fancy, "Export Image", fntMedium2X],
				[_format_colour, c_black],
				[_format_margin, 0, 0.3],
				[_format_text, "Show Collision:", fntMedium, fa_left],
				[_format_colour, c_white],
				[_format_margin, 0.3, 0.7],
				[_format_checkbox, "collision", false],
				//[_format_input_text, "name", _name, false, 88 + 8 * 6],
				//[_format_dropdown, "tileset", _tileset, global.ProvEdit_tileset_array, 88 + 8 * 6],
				//[_format_input_text, "depth", _depth, 2, 88 + 8 * 6],
				[_format_middle],
				[_format_left],
				[_format_button, "Cancel"],
				[_format_right],
				[_format_button, "Export"]
			], ___popup_export_image_handle)
			popup.layer_id = argument0
			//var _surf = level_generate_image()
			//surface_free(_surf)
			break
		
		// VIEW MENU
		case "ui scale":
			if (global.ui_scale == 1) 
				global.ui_scale = 2
			else
				global.ui_scale = 1
			display_set_gui_size(window_get_width() / global.ui_scale, window_get_height() / global.ui_scale)
			break
		case "grid":
			global.disp_grid_on = !global.disp_grid_on
			break
		case "layer opacity":
			global.disp_layer_opacity = !global.disp_layer_opacity
			break
		case "collision opacity":
			global.disp_collision_opacity = !global.disp_collision_opacity
			break
		case "collision icons":
			global.disp_collision_icons = !global.disp_collision_icons
			break
	
		// NET MENU
		case "host":
			show_popup("Start Online", 220, 224 + 16, [
				[_format_colour, c_white],
				[_format_text_fancy, "Host settings:", fntMedium2X],
				[_format_colour, c_black],
				[_format_text, "Port:"],
				[_format_colour, c_white],
				[_format_input_text, "port", string(global.net_host_port), true],
				[_format_colour, c_black],
				[_format_text, "Name:"],
				[_format_colour, c_white],
				[_format_input_text, "player_name", global.net_username],
				[_format_colour, c_black],
				[_format_text, "Color:"],
				[_format_colour, c_white],
				[_format_input_hue, "colour", global.net_colour],
				[_format_left],
				[_format_button, "Cancel"],
				[_format_right],
				[_format_button, "Continue"],
			], ___popup_host_handle)
			break
		case "join":
			show_popup("Start Online", 220, 176 + 96 + 24, [
				[_format_colour, c_white],
				[_format_text_fancy, "Join settings:", fntMedium2X],
				[_format_colour, c_black],
				[_format_text, "Address:"],
				[_format_colour, c_white],
				[_format_input_text, "ip", global.net_join_ip],
				[_format_colour, c_black],
				[_format_text, "Port:"],
				[_format_colour, c_white],
				[_format_input_text, "port", string(global.net_join_port)],
				[_format_colour, c_black],
				[_format_text, "Name:"],
				[_format_colour, c_white],
				[_format_input_text, "player_name", global.net_username],
				[_format_colour, c_black],
				[_format_text, "Color:"],
				[_format_colour, c_white],
				[_format_input_hue, "colour", global.net_colour],
				[_format_left],
				[_format_button, "Cancel"],
				[_format_right],
				[_format_button, "Continue"],
			], ___popup_join_handle)
			break
		case "disconnect":
			var str = "Are you sure you want to disconnect?"
			if (instance_exists(objServer))
				str += "\nThis will disconnect any other connected users."
			draw_set_font(fntMedium)
			var popup = show_popup("Confirm Action", 200, 80 + string_height_ext(str, global.font_height[fntMedium], 200 - 4) - 24, [
				[_format_colour, c_black],
				[_format_text, str],
				[_format_colour, c_white],
				[_format_left],
				[_format_button, "Cancel"],
				[_format_right],
				[_format_button, "Disconnect"],
			], ___popup_disconnect_handle)
			break
	}


}
