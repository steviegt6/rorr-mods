function ____action_levelInfo_write(argument0, argument1, argument2, argument3, argument4) {


	var b = buffer_create(16, buffer_grow, 1)
	buffer_write(b, buffer_u8, Actions.levelInfo)
	buffer_write(b, buffer_string, argument0)               // NAME
	switch (argument0) {
		case "name":
			buffer_write(b, buffer_string, argument1)       // value
			buffer_write(b, buffer_string, global.level_name)       // oldvalue
			break;
		case "subname":
			buffer_write(b, buffer_string, argument1)       // value
			buffer_write(b, buffer_string, global.level_subname)       // oldvalue
			break;
		case "music":
			buffer_write(b, buffer_string, argument1)       // value
			buffer_write(b, buffer_string, global.ProvEdit_music[global.level_music, PROVEDIT_MUSIC.internalName])       // oldvalue
			break;
		case "bounds":
			buffer_write(b, buffer_s16, argument1)       // values
			buffer_write(b, buffer_s16, argument2)
			buffer_write(b, buffer_s16, argument3)
			buffer_write(b, buffer_s16, argument4)
			buffer_write(b, buffer_s16, lv_left)       // oldvalues
			buffer_write(b, buffer_s16, lv_right)
			buffer_write(b, buffer_s16, lv_top)
			buffer_write(b, buffer_s16, lv_bottom)
			break;
		case "enemies":
			var enemy_array = []
			for (var i = 0; i < array_length_1d(global.level_enemies); i++) {
				enemy_array[i] = global.ProvEdit_enemy[global.level_enemies[i], PROVEDIT_ENEMY.gmobjKey]
			}
			buffer_write(b, buffer_string, array_to_string(argument1, ","))       // value
			buffer_write(b, buffer_string, array_to_string(enemy_array, ","))       // oldvalue
			break;
		case "map_objects":
			var objs_array = []
			for (var i = 0; i < array_length_1d(global.level_map_objects); i++) {
				objs_array[i] = global.ProvEdit_interactable[global.level_map_objects[i], PROVEDIT_INTERACTABLE.gmobjKey]
			}
			buffer_write(b, buffer_string, array_to_string(argument1, ","))       // value
			buffer_write(b, buffer_string, array_to_string(objs_array, ","))       // oldvalue
			break;
		case "backgrounds":
			var bgs_array = []
			var c = 0
			for (var i = 0; i < array_length_1d(global.level_backgrounds); i++) {
				var currBg = global.level_backgrounds[i]
				bgs_array[c] = global.ProvEdit_background[currBg.background, PROVEDIT_BACKGROUND.internalName]
				bgs_array[c + 1] = currBg.depth
				bgs_array[c + 2] = currBg.tilex
				bgs_array[c + 3] = currBg.tiley
				bgs_array[c + 4] = currBg.parallaxx
				bgs_array[c + 5] = currBg.parallaxy
				bgs_array[c + 6] = currBg.offsetx
				bgs_array[c + 7] = currBg.offsety
				c += 8
			}
			buffer_write(b, buffer_string, array_to_string(argument1, ","))       // value
			buffer_write(b, buffer_string, array_to_string(bgs_array, ","))       // oldvalue
			break;
	}
	buffer_write(b, buffer_string, global.level_subname)
	return [b, "Changed level " + argument0 + " to " + string(argument1)] // might break because of arrays (!)


}
