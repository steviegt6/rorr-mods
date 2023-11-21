function ___net_sync_player(argument0, argument1, argument2, argument3) {

	with (objServer) {
		var b = global.net_buff
		buffer_seek(b, buffer_seek_start, 0)
		buffer_write(b, buffer_u8, NetPacket.playerSync)
		buffer_write(b, buffer_s16, argument1)
		buffer_write(b, buffer_string, argument0)
		buffer_write(b, buffer_u8, argument3)
	
		// Host code
		var count = ds_list_size(clients)
	
		if (argument2 == -1) {
			for (var i = 0; i < count; i++) {
				if (clients[| i] != argument1)
					network_send_packet(clients[| i], b, buffer_tell(b))
			}
		} else
			network_send_packet(argument2, b, buffer_tell(b))
	}


}
