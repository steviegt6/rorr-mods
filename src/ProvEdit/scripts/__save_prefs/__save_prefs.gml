ini_open("editor_prefs.ini")

ini_write_string("net", "name", global.net_username)
ini_write_real("net", "color", global.net_colour)
ini_write_real("net", "host_port", global.net_host_port)
ini_write_string("net", "join_ip", global.net_join_ip)
ini_write_real("net", "join_port", global.net_join_port)

ini_write_real("disp", "grid_on", global.disp_grid_on)
ini_write_real("disp", "layer_opacity", global.disp_layer_opacity)
ini_write_real("disp", "collision_opacity", global.disp_collision_opacity)
ini_write_real("disp", "collision_icons", global.disp_collision_icons)

ini_close()