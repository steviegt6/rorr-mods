function __level_load() {
	if (net_client()) exit
	var fname = get_open_filename("ProvEdit level file|*.rorlvl", "")
	if (fname == "") exit

	global.level_path = ""

	__level_clear()

	var b = buffer_load(fname)

	buffer_seek(b, buffer_seek_start, 0)

	var err = __level_load_buffer(b);
	if (err == "") {
		scr_alert("Loaded from file " + fname)
		with (objServer) {
			var ccount = ds_list_size(clients)
			var size = buffer_get_size(b)
			for (var i = 0; i < ccount; i++) {
				network_send_packet(clients[| i], b, size)
			}
			net_sync_chat("Level loaded by host.", -1)
		}
		global.level_path = fname
	} else {
		scr_alert("Failed to load file: " + err)
		__level_init()
	}

	buffer_delete(b)



}
