sync_mouse -= 1

if (sync_mouse <= 0) {
	var packet = global.net_buff;
	buffer_seek(packet, buffer_seek_start, 0)
	buffer_write(packet, buffer_u8, NetPacket.cursor)
	buffer_write(packet, buffer_f64, mouse_x)
	buffer_write(packet, buffer_f64, mouse_y)
	network_send_packet(socket, packet, buffer_tell(packet))
	sync_mouse = 3
}
