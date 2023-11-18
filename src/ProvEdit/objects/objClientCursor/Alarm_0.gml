/// @description disconnect
if (instance_exists(objServer))
	__net_disconnect_player(ds_list_find_index(objServer.cursors, id))
