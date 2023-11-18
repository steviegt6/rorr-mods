
switch (async_load[? "type"]) {
	case (network_type_data):
		__net_handle_packet(async_load[? "buffer"], -1)
		break
}
