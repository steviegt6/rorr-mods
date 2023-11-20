function ___object_menu_handle_button(argument0, argument1) {
	if (argument1 == SP_EVENT.clicked || argument1 == SP_EVENT.contentChanged) {
		if (argument0 == "Done") {
			var something_changed = false
			var newMap = ds_map_create()
			for (var variable = ds_map_find_first(temp_data); !is_undefined(variable); variable = ds_map_find_next(temp_data, variable)) {
				if (!something_changed)
					something_changed = parent.variables[? variable] != temp_data[? variable]
				newMap[? variable] = [parent.variables[? variable], temp_data[? variable]]
			
				parent.variables[? variable] = temp_data[? variable]
			}
		
			destroyed = true
			if (something_changed)
				action_do(Actions.updateObject, parent.x, parent.y, parent.obj_id, newMap)
			ds_map_destroy(newMap)
		
			return true
		} else if (argument0 == "Remove Object") {
			action_do(Actions.placeObject, parent.x, parent.y, parent.obj_id, true, parent.variables)
		} else {
			var varName = string_replace(string_replace(argument0, "%_r", ""), "%_l", "")
			temp_data[? varName] = data[? varName]
		}
		//switch (argument0) {
		//	case "Continue":
		//		__level_clear()
		//		__level_init()
		//		scr_message("Cleared the level.")
		//		with (objServer) {
		//			var ccount = ds_list_size(clients)
		//			var buff = __level_save_buffer()
		//			var size = buffer_get_size(buff)
		//			for (var i = 0; i < ccount; i++) {
		//				network_send_packet(clients[| i], buff, size)
		//			}
		//			buffer_delete(buff)
		//			net_sync_chat("Level cleared by host.", -1)
		//		}
		//	case "Cancel":
		//		return true
		//}
	}

	return false


}
