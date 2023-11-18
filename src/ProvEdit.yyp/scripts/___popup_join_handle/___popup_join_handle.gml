function ___popup_join_handle(argument0, argument1) {
	if (argument1 == SP_EVENT.clicked) {
		switch (argument0) {
			case "Continue":
				global.net_username = data[? "player_name"]
				global.net_colour = data[? "colour"]
				global.net_join_port = real_int(data[? "port"])
				global.net_join_ip = data[? "ip"]
				instance_create_depth(0, 0, -999, objClient)
			case "Cancel":
				return true
		}
	}

	return false


}
