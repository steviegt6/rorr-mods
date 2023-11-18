sprite_index = -1

server = network_create_server(network_socket_tcp, global.net_host_port, 32)

cursors = ds_list_create()
clients = ds_list_create()

scr_message("Now hosting on port " + string(global.net_host_port))

sync_mouse = 3

show_popup("Start Online", 220, 100 - 32, [
	[_format_colour, c_black],
	[_format_text, "Session hosted successfully."],
	[_format_colour, c_white],
	[_format_button, "Continue"]
], scr_true)