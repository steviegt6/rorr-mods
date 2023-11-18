switch (argument0) {
	case ("Basic"):
		_level_settings(0)
		return true;
	case ("Background"):
		_level_settings(1)
		return true;
	case ("Spawns"):
		_level_settings(2)
		return true;
		
	// GENERAL SETTINGS
	case ("level_name"):
		if (argument1 == SP_EVENT.contentChanged)
			action_do(Actions.levelInfo, "name", data[? "level_name"])
		break
	case ("level_subname"):
		if (argument1 == SP_EVENT.contentChanged)
			action_do(Actions.levelInfo, "subname", data[? "level_subname"])
		break
	case ("level_music"):
		if (argument1 == SP_EVENT.contentChanged)
			action_do(Actions.levelInfo, "music", data[? "level_music"])
		break
	
	// BACKGROUND SETTINGS
	case ("background_list"):
		if (argument1 == SP_EVENT.contentChanged) {
			var new_bgs = []
			var c = 0
			var bg_2d_array = data[? "background_list"]
			for (var i = 0; i < array_height_2d(bg_2d_array); i++) {
				if (bg_2d_array[i, 0]) {
					var bgDepth = bg_2d_array[i, 2]
					var bgTileX = 1
					var bgTileY = 1
					var bgParallaxX = 0
					var bgParallaxY = 0
					var bgOffsetX = 0
					var bgOffsetY = 0
					with (objBackground) {
						if (background == i) {
							bgTileX = tilex
							bgTileY = tiley
							bgParallaxX = parallaxx
							bgParallaxY = parallaxy
							bgOffsetX = offsetx
							bgOffsetY = offsety
						}
					}
					new_bgs[c] = global.ProvEdit_background[i, PROVEDIT_BACKGROUND.internalName]
					new_bgs[c + 1] = bgDepth
					new_bgs[c + 2] = bgTileX
					new_bgs[c + 3] = bgTileY
					new_bgs[c + 4] = bgParallaxX
					new_bgs[c + 5] = bgParallaxY
					new_bgs[c + 6] = bgOffsetX
					new_bgs[c + 7] = bgOffsetY
					c += 8
				}
			}
			action_do(Actions.levelInfo, "backgrounds", new_bgs)
		}
		break
	case "bg_tile_x":
	case "bg_tile_y":
	case "bg_parallax_x%_r":
	case "bg_parallax_x%_l":
	case "bg_parallax_y%_r":
	case "bg_parallax_y%_l":
	case "bg_offset_x%_r":
	case "bg_offset_x%_l":
	case "bg_offset_y%_r":
	case "bg_offset_y%_l":
	case "bg_percent_x%_r":
	case "bg_percent_x%_l":
	case "bg_percent_y%_r":
	case "bg_percent_y%_l":
		if (argument1 == SP_EVENT.clicked || argument1 == SP_EVENT.contentChanged) {
			var varName = string_replace(string_replace(argument0, "%_r", ""), "%_l", "")
			var chosenBg = -1
			with (objChecklist) {
				if (identifier == "background_list") {
					chosenBg = choice
					break
				}
			}
			if (chosenBg != -1)
				action_do(Actions.updateBackground, global.ProvEdit_background[chosenBg, PROVEDIT_BACKGROUND.internalName], string_copy(varName, 4, string_length(varName) - 3), data[? varName])
		}
		break
	
	// SPAWN SETTINGS
	case ("spawn_enemies_list"):
		if (argument1 == SP_EVENT.contentChanged) {
			var new_enemies = []
			var c = 0
			var enemy_2d_array = data[? "spawn_enemies_list"]
			for (var i = 0; i < array_height_2d(enemy_2d_array); i++) {
				if (enemy_2d_array[i, 0]) {
					new_enemies[c] = global.ProvEdit_enemy[i, PROVEDIT_ENEMY.gmobjKey]
					c++
				}
			}
			action_do(Actions.levelInfo, "enemies", new_enemies)
		}
		break
	case ("spawn_map_objects_list"):
		if (argument1 == SP_EVENT.contentChanged) {
			var new_objs = []
			var c = 0
			var obj_2d_array = data[? "spawn_map_objects_list"]
			for (var i = 0; i < array_height_2d(obj_2d_array); i++) {
				if (obj_2d_array[i, 0]) {
					new_objs[c] = global.ProvEdit_interactable[i, PROVEDIT_INTERACTABLE.gmobjKey]
					c++
				}
			}
			action_do(Actions.levelInfo, "map_objects", new_objs)
		}
		break
}

// BASIC TAB
if (identifier == 0) {
	// Resize text is dynamic so it is stored in a variable
	if (argument0 == resize_button) {
		// Spawn resize control object
		instance_create_depth(0, 0, -9998, objResizeBoundaries)
		// Close the form
		return true
	}
}

return false
