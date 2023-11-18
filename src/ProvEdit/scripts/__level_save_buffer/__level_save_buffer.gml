
var b = buffer_create(1024, buffer_grow, 1);


#region file header
	for (var i = 1; i <= 6; i++)
		buffer_write(b, buffer_u8, string_byte_at("rorlvl", i))
	repeat (7)
		buffer_write(b, buffer_u8, 0)
	for (var i = 1; i <= 5; i++)
		buffer_write(b, buffer_u8, string_byte_at(FORMAT_VERSION, i))
#endregion


var collision_type_num = 0
for (var i = 0; i < global.collision_type_num; i++) {
	if (instance_number(global.collision_types[i, CollisionType.object]) > 0)
		collision_type_num += 1
}

#region level header
	// Name and subname
	buffer_write(b, buffer_string, global.level_name)
	buffer_write(b, buffer_string, global.level_subname)
	// Map top left
	buffer_write(b, buffer_s16, 0)
	buffer_write(b, buffer_s16, 0)
	// Map size
	buffer_write(b, buffer_s16, floor(lv_left / 16))
	buffer_write(b, buffer_s16, floor(lv_top / 16))
	buffer_write(b, buffer_s16, floor(lv_right / 16))
	buffer_write(b, buffer_s16, floor(lv_bottom / 16))
	// Layer number
	buffer_write(b, buffer_u16, instance_number(objTileLayer))
	// Collision type number
	buffer_write(b, buffer_u8, collision_type_num) // Collision types
	// Level object number
	buffer_write(b, buffer_u16, instance_number(objMapObject))
	// Music internal name
	buffer_write(b, buffer_string, global.ProvEdit_music[global.level_music, PROVEDIT_MUSIC.internalName])
	// Background number
	buffer_write(b, buffer_u8, array_length_1d(global.level_backgrounds)) // NYI
	// Map object number
	buffer_write(b, buffer_u8, array_length_1d(global.level_map_objects)) // NYI
	// PROVEDIT_ENEMY number
	buffer_write(b, buffer_u8, array_length_1d(global.level_enemies)) // NYI
#endregion

#region layer data
	for (var i = 0; i < array_length_1d(global.tiles); i++) {
		var l = global.tiles[i]
	
		// name
		buffer_write(b, buffer_string, l.name)
		// tileset
		buffer_write(b, buffer_string, global.ProvEdit_tileset[l.tileset, PROVEDIT_TILESET.internalName])
		// depth
		buffer_write(b, buffer_s16, l.depth)
		// tile number
		var content_number = 0
		var tile_data = l.tile_data
		var key = ds_map_find_first(tile_data)
		repeat (ds_map_size(tile_data)) {
			content_number += ds_map_size(tile_data[? key])
			key = ds_map_find_next(tile_data, key)
		}
		buffer_write(b, buffer_u32, content_number)
	
		#region layer tile data
			/*var s = ds_list_size(l.contents)
			for (var j = 0; j < s; j++) {
				var tile = l.contents[| j]
				
				// tileset x / y
				var region = layer_tile_get_region(tile)
				buffer_write(b, buffer_u8, region[0] / 16)
				buffer_write(b, buffer_u8, region[1] / 16)
				
				// position
				buffer_write(b, buffer_s16, layer_tile_get_x(tile) / 16)
				buffer_write(b, buffer_s16, layer_tile_get_y(tile) / 16)
			}*/
			var tile_data = l.tile_data
			var s = ds_map_size(tile_data)
			var key = ds_map_find_first(tile_data)
			repeat (s) {
				var tile_data2 = tile_data[? key]
				var s2 = ds_map_size(tile_data2)
				var key2 = ds_map_find_first(tile_data2)
				repeat (s2) {
					var tile = tile_data2[? key2]
					buffer_write(b, buffer_u8, tile_get_img_x(tile))
					buffer_write(b, buffer_u8, tile_get_img_y(tile))
					buffer_write(b, buffer_s16, key)
					buffer_write(b, buffer_s16, key2)
					key2 = ds_map_find_next(tile_data2, key2)
				}
				key = ds_map_find_next(tile_data, key)
			}
		#endregion
	}
#endregion

#region collision data
	for (var i = 0; i < global.collision_type_num; i++) {
		var obj = global.collision_types[i, CollisionType.object]
		var count = instance_number(obj)
		if (count > 0) {
			buffer_write(b, buffer_u8, i)
			buffer_write(b, buffer_u32, count)
			with(obj) {
				buffer_write(b, buffer_s16, x >> 3)
				buffer_write(b, buffer_s16, y >> 3)
			}
		}
	}
#endregion

#region objects
	with (objMapObject) {
		// Type
		buffer_write(b, buffer_string, global.ProvEdit_object[obj_id, PROVEDIT_LEVELOBJECT.gmobjKey])
		// Pos
		buffer_write(b, buffer_s16, x >> 3)
		buffer_write(b, buffer_s16, y >> 3)
		
		/*// Extra data bits (unused)
		buffer_write(b, buffer_u8, 0)*/
		
		// Variable count
		buffer_write(b, buffer_u8, ds_map_size(variables))
		// Variables
		for (var var_key = ds_map_find_first(variables); !is_undefined(var_key); var_key = ds_map_find_next(variables, var_key)) {
			var var_val = variables[? var_key]
			buffer_write(b, buffer_string, var_key)
			var var_type = is_string(var_val)
			buffer_write(b, buffer_bool, var_type)
			buffer_write(b, var_type ? buffer_string : buffer_s32, var_val)
		}
	}
#endregion

#region background
	for (var i = 0; i < array_length_1d(global.level_backgrounds); i++) {
		var currBgObj = global.level_backgrounds[i]
		buffer_write(b, buffer_string, global.ProvEdit_background[currBgObj.background, PROVEDIT_BACKGROUND.internalName])
		buffer_write(b, buffer_s32, currBgObj.depth)
		buffer_write(b, buffer_u8, currBgObj.tilex)
		buffer_write(b, buffer_u8, currBgObj.tiley)
		buffer_write(b, buffer_f32, currBgObj.parallaxx)
		buffer_write(b, buffer_f32, currBgObj.parallaxy)
		buffer_write(b, buffer_f32, currBgObj.offsetx)
		buffer_write(b, buffer_f32, currBgObj.offsety)
		/* VER: 0.1.1 */
		buffer_write(b, buffer_f32, currBgObj.percentx)
		buffer_write(b, buffer_f32, currBgObj.percenty)
		/*            */
	}
#endregion

#region map object spawns
	for (var i = 0; i < array_length_1d(global.level_map_objects); i++)
		buffer_write(b, buffer_string, global.ProvEdit_interactable[global.level_map_objects[i], PROVEDIT_INTERACTABLE.gmobjKey])
#endregion

#region enemy spawns
	for (var i = 0; i < array_length_1d(global.level_enemies); i++)
		buffer_write(b, buffer_string, global.ProvEdit_enemy[global.level_enemies[i], PROVEDIT_ENEMY.gmobjKey])
#endregion

var b2 = buffer_create(buffer_tell(b), buffer_fixed, 1)
buffer_copy(b, 0, buffer_tell(b), b2, 0)
buffer_delete(b)

return b2

