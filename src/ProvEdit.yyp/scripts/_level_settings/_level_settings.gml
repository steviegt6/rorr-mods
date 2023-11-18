function _level_settings(argument0) {
	var popup
	switch (argument0) {
		// TAB 1: general settings
		case 0:
			var resize_button_text = "Resize (" + string(floor((lv_right - lv_left) / 16)) + ", " + string(floor((lv_bottom - lv_top) / 16)) + ")"
			popup = show_popup("Level Settings", 400, 400, [
				[_format_colour, Colours.black],
				[_format_tab_line],
				[_format_margin, 0, 0.3],
				[_format_button_tab, "Basic", 1],
				[_format_margin, 0.3, 0.4],
				[_format_button_tab, "Background", 0],
				[_format_margin, 0.7, 0.3],
				[_format_button_tab, "Spawns", 0],
				[_format_middle],
				[_format_text_fancy, "Basic Settings", fntMedium2X],
				[_format_colour, c_black],
				[_format_margin, 0, 0.15],
				[_format_text, "Name:", fntMedium, fa_left],
				[_format_text, "Subname:", fntMedium, fa_left],
				[_format_text, "Music:", fntMedium, fa_left],
				[_format_text, "Dimensions:", fntMedium, fa_left],
			
				[_format_colour, c_white],
				[_format_margin, 0.3, 0.7],
				[_format_input_text, "level_name", global.level_name, false, 88 + 8 * 6],
				[_format_input_text, "level_subname", global.level_subname, false, 88 + 8 * 6],
				[_format_dropdown, "level_music", global.ProvEdit_music[global.level_music, PROVEDIT_MUSIC.name], global.ProvEdit_music_array, 88 + 8 * 6],
				[_format_button, resize_button_text],

			], ___level_settings_handle)
			popup.resize_button = resize_button_text
		
			break
		// TAB 2: background settings
		case 1:
			var bgs = []
			for (var i = 0; i < global.ProvEdit_background_number; i++) {
				var found = 0;
				var bg
				for (var j = 0; j < array_length_1d(global.level_backgrounds); j++) {
					bg = global.level_backgrounds[j]
					if (i == bg.background) {
						found = 1
						break
					}
				}
				bgs[i, 0] = found
				bgs[i, 1] = global.ProvEdit_background[i, PROVEDIT_BACKGROUND.name]
				bgs[i, 2] = found ? bg.depth : 10000 //2147483500
			}
	
			popup = show_popup("Level Settings", 400, 400, [
				[_format_tab_line],
				[_format_colour, Colours.black],
				[_format_margin, 0, 0.3],
				[_format_button_tab, "Basic", 0],
				[_format_margin, 0.3, 0.4],
				[_format_button_tab, "Background", 1],
				[_format_margin, 0.7, 0.3],
				[_format_button_tab, "Spawns", 0],
				[_format_middle],
				[_format_text_fancy, "Background Settings", fntMedium2X],
				[_format_margin, 0, 0.5],
				[_format_checklist, "background_list", bgs, 10, 125],
				[_format_background_settings, "background_settings", bgs]
			], ___level_settings_handle)
		
			break
		// TAB 3: spawn settings
		case 2:
			var enemies = []
			for (var i = 0; i < global.ProvEdit_enemy_number; i++) {
				var found = 0;
				for (var j = 0; j < array_length_1d(global.level_enemies); j++) {
					if (i == global.level_enemies[j]) {
						found = 1
						break
					}
				}
				enemies[i, 0] = found
				enemies[i, 1] = global.ProvEdit_enemy[i, PROVEDIT_ENEMY.name]
			}
			var objs = []
			for (var i = 0; i < global.ProvEdit_interactable_number; i++) {
				var found = 0;
				for (var j = 0; j < array_length_1d(global.level_map_objects); j++) {
					if (i == global.level_map_objects[j]) {
						found = 1
						break
					}
				}
				objs[i, 0] = found
				objs[i, 1] = global.ProvEdit_interactable[i, PROVEDIT_INTERACTABLE.name]
			}
		
			popup = show_popup("Level Settings", 400, 400, [
				[_format_colour, Colours.black],
				[_format_tab_line],
				[_format_margin, 0, 0.3],
				[_format_button_tab, "Basic", 0],
				[_format_margin, 0.3, 0.4],
				[_format_button_tab, "Background", 0],
				[_format_margin, 0.7, 0.3],
				[_format_button_tab, "Spawns", 1],
				[_format_middle],
				[_format_text_fancy, "Spawn Settings", fntMedium2X],
				[_format_left],
				[_format_text, "Enemies:", fntMedium, fa_middle],
				[_format_checklist, "spawn_enemies_list", enemies, 10, 125],
				[_format_right],
				[_format_text, "Objects:", fntMedium, fa_middle],
				[_format_checklist, "spawn_map_objects_list", objs, 10, 125],

			], ___level_settings_handle)
		
			break
	
	}
	popup.identifier = argument0


}
