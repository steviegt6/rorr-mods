
var length = ds_list_size(clients)
for (var i = 0; i < length; i++) {
	if (clients[| i] != argument1)
		network_send_packet(clients[| i], argument0, buffer_get_size(argument0))
}