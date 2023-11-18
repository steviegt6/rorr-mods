/// @function __tile_layer_set_tile(id, x, y, tile x, tile y)
/// @param id
/// @param x
/// @param y
/// @param tilex
/// @param tiley
function __tile_layer_set_tile(argument0, argument1, argument2, argument3, argument4) {

	with (global.tiles[argument0]) {
		//var map_key = string(argument1) + ", " + string(argument2)
	
		if (argument3 < 0 || argument4 < 0) {
			var tobj = tile_layer_get_at(argument0, argument1, argument2)
			if (tobj != undefined) {
				/*var old_tile = tobj
				layer_tile_destroy(old_tile)
				ds_list_delete(contents, ds_list_find_index(contents, old_tile))
				content_map[? map_key] = undefined*/
				tile_layer_set_at(argument0, argument1, argument2, undefined)
			}
		} else {
			/*var new_tile = layer_tile_create(my_layer, argument1 * 16, argument2 * 16, global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.image], argument3 * 16, argument4 * 16, 16, 16)
			layer_tile_alpha(new_tile, 0)
			if (!is_undefined(content_map[? map_key])) {
				var old_tile = content_map[? map_key]
				layer_tile_destroy(old_tile)
				contents[| ds_list_find_index(contents, old_tile)] = new_tile
			} else {
				ds_list_add(contents, new_tile)
			}*/
	
			//content_map[? map_key] = new_tile
			/*show_debug_message("pack:")
			show_debug_message(argument3)
			show_debug_message(argument4)
			show_debug_message("to:")
			show_debug_message(tile_pack(argument3, argument4))
			show_debug_message(tile_get_img_x(tile_pack(argument3, argument4)))
			show_debug_message(tile_get_img_y(tile_pack(argument3, argument4)))*/
			tile_layer_set_at(argument0, argument1, argument2, tile_pack(argument3, argument4))
		}
	}


}
