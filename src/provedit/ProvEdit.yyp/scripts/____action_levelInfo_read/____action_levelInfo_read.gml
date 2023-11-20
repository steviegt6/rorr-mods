/// @param b
function ____action_levelInfo_read(argument0, argument1) {
	var b = argument0;

	var name = buffer_read(b, buffer_string)

	switch (name) {
		case "bounds":
			var _l_new, _r_new, _t_new, _b_new
			var _l_old, _r_old, _t_old, _b_old
			_l_new = buffer_read(b, buffer_s16)
			_r_new = buffer_read(b, buffer_s16)
			_t_new = buffer_read(b, buffer_s16)
			_b_new = buffer_read(b, buffer_s16)
			_l_old = buffer_read(b, buffer_s16)
			_r_old = buffer_read(b, buffer_s16)
			_t_old = buffer_read(b, buffer_s16)
			_b_old = buffer_read(b, buffer_s16)
	
			if (argument1) {
				lv_left = _l_old
				lv_right = _r_old
				lv_top = _t_old
				lv_bottom = _b_old
			} else {
				lv_left = _l_new
				lv_right = _r_new
				lv_top = _t_new
				lv_bottom = _b_new
			}
	
			break
		default:
			var undo, redo
			redo = buffer_read(b, buffer_string)
			undo = buffer_read(b, buffer_string)
			switch (name) {
				case "name":
					global.level_name = argument1 ? undo : redo
					break;
				case "subname":
					global.level_subname = argument1 ? undo : redo
					break;
				case "music":
					var name = argument1 ? undo : redo
					for (var i = 0; i < global.ProvEdit_music_number; i++) {
						if (global.ProvEdit_music[i, PROVEDIT_MUSIC.name] == name) {
							global.level_music = i
							break
						}
					}
					//global.level_music = global.music_map[? argument1 ? undo : redo]
					break;
				case "enemies":
					var new_enemies = split_string(argument1 ? undo : redo, ",")
					global.level_enemies = []
					for (var i = 0; i < array_length_1d(new_enemies); i++) {
						global.level_enemies[i] = ProvEdit_enemy_find(new_enemies[i])
					}
					break;
				case "map_objects":
					var new_objs = split_string(argument1 ? undo : redo, ",")
					global.level_map_objects = []
					for (var i = 0; i < array_length_1d(new_objs); i++) {
						global.level_map_objects[i] = ProvEdit_interactable_find(new_objs[i])
					}
					break;
				case "backgrounds":
					var new_objs = split_string(argument1 ? undo : redo, ",")
					for (var i = 0; i < array_length_1d(global.level_backgrounds); i++) {
						var inst = global.level_backgrounds[i]
						if (instance_exists(inst))
							instance_destroy(inst)
					}
					global.level_backgrounds = []
					var c = 0
					for (var i = 0; i < array_length_1d(new_objs) / 8; i++) {
						var currBgNum = ProvEdit_background_find(new_objs[c])
						var test = real(new_objs[c + 1])
						var currBgObj = instance_create_depth(0, 0, test, objBackground)
						with (currBgObj) {
							background = currBgNum
							tilex = real(new_objs[c + 2])
							tiley = real(new_objs[c + 3])
							parallaxx = real(new_objs[c + 4])
							parallaxy = real(new_objs[c + 5])
							offsetx = real(new_objs[c + 6])
							offsety = real(new_objs[c + 7])
							event_user(0)
						}
						c += 8
						global.level_backgrounds[i] = currBgObj
					}
					break;
			}
	}


}
