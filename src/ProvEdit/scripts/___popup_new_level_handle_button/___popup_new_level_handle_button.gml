
if (argument1 == SP_EVENT.clicked) {
	switch (argument0) {
		case "Continue":
			__level_clear()
			__level_init()
			scr_message("Cleared the level.")
			with (objServer) {
				var ccount = ds_list_size(clients)
				var buff = __level_save_buffer()
				var size = buffer_get_size(buff)
				for (var i = 0; i < ccount; i++) {
					network_send_packet(clients[| i], buff, size)
				}
				buffer_delete(buff)
				net_sync_chat("Level cleared by host.", -1)
			}
		case "Cancel":
			return true
	}
}

return false