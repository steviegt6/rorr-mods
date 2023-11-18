function net_sync_chat(argument0, argument1) {

	var b = global.net_buff
	buffer_seek(b, buffer_seek_start, 0)
	buffer_write(b, buffer_u8, NetPacket.chat)
	buffer_write(b, buffer_string, argument0)

	with (objServer) {
		// Host code
		var count = ds_list_size(clients)
		for (var i = 0; i < count; i++) {
			if (clients[| i] != argument1)
				network_send_packet(clients[| i], b, buffer_tell(b))
		}
	}

	with (objClient) {
		// Client code
		network_send_packet(socket, b, buffer_tell(b))
	}


}
