with (objServer) {
	var b = global.net_buff
	buffer_seek(b, buffer_seek_start, 0)
	buffer_write(b, buffer_u8, NetPacket.cursorSync)
	
	// Cursor count
	buffer_write(b, buffer_u8, instance_number(objClientCursor) + 1)
	// Local cursor
	buffer_write(b, buffer_s16, -1) // player
	buffer_write(b, buffer_f64, mouse_x) // x
	buffer_write(b, buffer_f64, mouse_y) // y
	// Client cursors
	with (objClientCursor) {
		buffer_write(b, buffer_s16, other.clients[| ds_list_find_index(other.cursors, id)]) // player
		buffer_write(b, buffer_f64, targ_x) // x
		buffer_write(b, buffer_f64, targ_y) // y
	}

	// Send
	var count = ds_list_size(clients)
	for (var i = 0; i < count; i++) {
		network_send_packet(clients[| i], b, buffer_tell(b))
	}
}