if (argument1 == SP_EVENT.clicked) {
	switch (argument0) {
		case "Continue":
			global.net_username = data[? "player_name"]
			global.net_colour = data[? "colour"]
			global.net_host_port = real_int(data[? "port"])
			instance_create_depth(0, 0, -999, objServer)
		case "Cancel":
			return true
	}
}

return false  