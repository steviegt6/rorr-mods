function __level_load_buffer_old(argument0) {
	var b = argument0

	var _ver

#region file header
		var magic_string = ""
		repeat(6)
			magic_string += chr(buffer_read(b, buffer_u8))
		if (magic_string != "rorlvl")
			return "incorrect file type"
		repeat (7)
			buffer_read(b, buffer_u8)
		var format_string = ""
		repeat(5)
			format_string += chr(buffer_read(b, buffer_u8))
		if (is_undefined(global.____format_known[? format_string]))
			return "unknown file format version"
		_ver = ProvEdit_semver_parse(format_string)
#endregion

#region level header
		// Name and subname
		global.level_name = buffer_read(b, buffer_string)
		global.level_subname = buffer_read(b, buffer_string)
		// Map top left
		buffer_read(b, buffer_s16)
		buffer_read(b, buffer_s16)
		// Map size
		lv_left = buffer_read(b, buffer_s16) * 16
		lv_top = buffer_read(b, buffer_s16) * 16
		lv_right = buffer_read(b, buffer_s16) * 16
		lv_bottom = buffer_read(b, buffer_s16) * 16
		// Layer number
		var layer_number = buffer_read(b, buffer_u16)
		// Collision type number
		var collision_number = buffer_read(b, buffer_u8)
		// Level object number
		var object_number = buffer_read(b, buffer_u16)
		// Music
		var music_filename = buffer_read(b, buffer_string)
		var music_index = ProvEdit_music_find(music_filename)
		if (music_index == undefined) {
			global.level_music = 0 // Default to first music ID
		} else {
			global.level_music = music_index
		}
		// Background, map objects, and enemy numbers
		var background_number = buffer_read(b, buffer_u8)
		var mapobject_spawn_number = buffer_read(b, buffer_u8)
		var enemy_spawn_number = buffer_read(b, buffer_u8)
#endregion

#region tile data
		global.tiles = []
		for (var i = 0; i < layer_number; i++) {
			var l_name = buffer_read(b, buffer_string)
			var l_tileset_name = buffer_read(b, buffer_string)
			var l_depth = buffer_read(b, buffer_s16)

			var l_tileset = ProvEdit_tileset_find(l_tileset_name)
			if (l_tileset < 0)
				return "Unable to resolve tileset '" + l_tileset_name + "'"
			var index = layer_add(l_name, l_tileset, l_depth).index
		
			var l_count_tile = buffer_read(b, buffer_u32)
		
			repeat (l_count_tile) {
				var t_ts_x = buffer_read(b, buffer_u8)
				var t_ts_y = buffer_read(b, buffer_u8)
				var t_x = buffer_read(b, buffer_s16)
				var t_y = buffer_read(b, buffer_s16)
				__tile_layer_set_tile(index, t_x, t_y, t_ts_x, t_ts_y)
			}
		}
#endregion

#region collision data
		repeat (collision_number) {
			var type = buffer_read(b, buffer_u8)
			var count = buffer_read(b, buffer_u32)
			var obj = global.collision_types[type, CollisionType.object]
			repeat (count) {
				var t_x = buffer_read(b, buffer_s16) << 3
				var t_y = buffer_read(b, buffer_s16) << 3
				instance_create_depth(t_x, t_y, -99, obj)
			}
		}
#endregion

#region object data
		repeat (object_number) {
			var obj_name = buffer_read(b, buffer_string)
			var obj = ProvEdit_object_find(obj_name)
			if (obj < 0)
				return "Unable to resolve object '" + obj_name + "'"
			var t_x = buffer_read(b, buffer_s16) << 3
			var t_y = buffer_read(b, buffer_s16) << 3
			_create_level_object(t_x, t_y, obj)
			var special = buffer_read(b, buffer_u8)
		}
#endregion

#region background
		global.level_backgrounds = []
		repeat (background_number) {
			var bg_name = buffer_read(b, buffer_string)
			var bg_depth = buffer_read(b, buffer_s32)
			var bg_tilex = buffer_read(b, buffer_u8)
			var bg_tiley = buffer_read(b, buffer_u8)
			var bg_parallaxx = buffer_read(b, buffer_f32)
			var bg_parallaxy = buffer_read(b, buffer_f32)
			var bg_offsetx = buffer_read(b, buffer_f32)
			var bg_offsety = buffer_read(b, buffer_f32)
			var bg_percentx = 0, bg_percenty = 0
			if (ProvEdit_semver_compare(_ver,/**/0,1,1/**/)) {
				bg_percentx = buffer_read(b, buffer_f32)
				bg_percenty = buffer_read(b, buffer_f32)
			}
			var bg_num = ProvEdit_background_find(bg_name)
			if (bg_num != -1) {
				var bg_obj = instance_create_depth(0, 0, bg_depth, objBackground)
				with (bg_obj) {
					background = bg_num
					tilex = bg_tilex
					tiley = bg_tiley
					parallaxx = bg_parallaxx
					parallaxy = bg_parallaxy
					offsetx = bg_offsetx
					offsety = bg_offsety
					percentx = bg_percentx
					percenty = bg_percenty
					event_user(0)
				}
				var arr_length = array_length_1d(global.level_backgrounds)
				global.level_backgrounds[arr_length] = bg_obj
			}
		}
#endregion

#region map object spawns
		global.level_map_objects = []
		repeat (mapobject_spawn_number) {
			var mapobj_name = buffer_read(b, buffer_string)
			var mapobj_index = ProvEdit_interactable_find(mapobj_name)
			if (mapobj_index != -1) {
				var arr_length = array_length_1d(global.level_map_objects)
				global.level_map_objects[arr_length] = mapobj_index
			}
		}
#endregion

#region enemy spawns
		global.level_enemies = []
		repeat (enemy_spawn_number) {
			var enemy_name = buffer_read(b, buffer_string)
			var enemy_index = ProvEdit_enemy_find(enemy_name)
			if (enemy_index != -1) {
				var arr_length = array_length_1d(global.level_enemies)
				global.level_enemies[arr_length] = enemy_index
			}
		}
#endregion

	select_layer(objTileLayer.id)

	return ""


}
