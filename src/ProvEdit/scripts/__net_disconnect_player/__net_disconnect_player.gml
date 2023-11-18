
var index = argument0

with (objServer) {
	with (cursors[| index]) {
		instance_destroy()
		if (set) {
			var st = "'" + name + "' has left the session."
			
			// Chat notif
			var sock = other.clients[| index]
			scr_alert(st)
			net_sync_chat(st, sock)
			
			// Disconnect packet
			var b = global.net_buff
			buffer_seek(b, buffer_seek_start, 0)
			buffer_write(b, buffer_u8, NetPacket.playerDisconnect)
			buffer_write(b, buffer_s16, sock)
			var _clients = other.clients
			var count = ds_list_size(_clients)
			for (var i = 0; i < count; i++) {
				if (_clients[| i] != sock)
					network_send_packet(_clients[| i], b, buffer_tell(b))
			}
		}
	}
	network_destroy(clients[| index])
	ds_list_delete(clients, index)
	ds_list_delete(cursors, index)
}