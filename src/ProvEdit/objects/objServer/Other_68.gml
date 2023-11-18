
switch (async_load[? "type"]) {
	case (network_type_data):
		if (__net_handle_packet(async_load[? "buffer"], async_load[? "id"]))
			__net_server_relay(async_load[? "buffer"], async_load[? "id"])
		break
	case (network_type_connect):
		
		var tsock = async_load[? "socket"]
		
		___net_sync_player(global.net_username, -1, tsock, global.net_colour)
		with (objClientCursor) {
			if (set) {
				___net_sync_player(name, sock, tsock, colour_get_hue(image_blend))
			}
		}
		
		
		ds_list_add(clients, tsock)
		var cursor = instance_create_depth(0, 0, -999, objClientCursor)
		cursor.sock = tsock
		ds_list_add(cursors, cursor)
		
		break
	case (network_type_disconnect):
		var index = ds_list_find_index(clients, async_load[? "socket"]);
		__net_disconnect_player(index)
		break
}
