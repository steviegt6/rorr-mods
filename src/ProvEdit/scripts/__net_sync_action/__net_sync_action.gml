///@function __net_sync_action(buffer, undo)
///@param buffer id
///@param undo bool

with (objServer) {
	var length = ds_list_size(clients)
	if (length > 0) {
		var buffer = ____net_pack_action(argument0, argument1)
		for (var i = 0; i < length; i++)
			network_send_packet(clients[| i], buffer, buffer_get_size(buffer))
		buffer_delete(buffer)
	}
}

with (objClient) {
	var buffer = ____net_pack_action(argument0, argument1)
	network_send_packet(socket, buffer, buffer_get_size(buffer))
	buffer_delete(buffer)
}	
