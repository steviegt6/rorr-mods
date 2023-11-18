sprite_index = -1

global.level_path = ""

cursors = ds_map_create()
sync_mouse = 1
socket = network_create_socket(network_socket_tcp)
network_set_config(network_config_connect_timeout, 1000 * 7)
if (network_connect(socket, global.net_join_ip, global.net_join_port) >= 0) {
	scr_message("Connected to IP " + string(global.net_join_ip) + " on port " + string(global.net_join_port))
	show_popup("Start Online", 220, 100 - 32, [
		[_format_colour, c_black],
		[_format_text, "Connection successful."],
		[_format_colour, c_white],
		[_format_button, "Continue"]
	], scr_true)
} else {
	scr_message("Failed to connect to IP " + string(global.net_join_ip) + " on port " + string(global.net_join_port))
	network_destroy(socket)
	show_popup("Start Online", 180, 80, [
		[_format_colour, c_black],
		[_format_text, "Failed to connect to the server:\nThe connection timed out."],
		[_format_colour, c_white],
		[_format_button, "Continue"]
	], scr_true)
	instance_destroy(id, false)
	exit
}

// Send player info
var packet = global.net_buff;
buffer_seek(packet, buffer_seek_start, 0)
buffer_write(packet, buffer_u8, NetPacket.playerInfo)
buffer_write(packet, buffer_string, global.net_username)
buffer_write(packet, buffer_u8, global.net_colour)
network_send_packet(socket, packet, buffer_tell(packet))
