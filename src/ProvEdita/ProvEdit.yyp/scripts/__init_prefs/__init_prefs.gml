function __init_prefs() {
	ini_open("editor_prefs.ini")

	global.net_username = ini_read_string("net", "name", "User")
	global.net_colour = floor(clamp(ini_read_real("net", "color", irandom(255)), 0, 255))
	global.net_host_port = floor(ini_read_real("net", "host_port", 11100))
	global.net_join_ip = ini_read_string("net", "join_ip", "127.0.0.1")
	global.net_join_port = floor(ini_read_real("net", "join_port", 11100))

	global.disp_grid_on = ini_read_real("disp", "grid_on", true) != false
	global.disp_layer_opacity = ini_read_real("disp", "layer_opacity", false) != false
	global.disp_collision_opacity = ini_read_real("disp", "collision_opacity", false) != false
	global.disp_collision_icons = ini_read_real("disp", "collision_icons", false) != false

	ini_close()


}
