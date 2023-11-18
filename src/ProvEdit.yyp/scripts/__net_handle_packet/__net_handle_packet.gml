///@function __net_handle_packet(buffer, source)
///@param buffer id
///@param source number
function __net_handle_packet(argument0, argument1) {

	enum NetPacket {
		action,
		cursor,
		cursorSync,
		playerInfo,
		playerSync,
		playerDisconnect,
		chat
	}

	switch (buffer_read(argument0, buffer_u8)) {
		case (NetPacket.action):
			if (!buffer_read(argument0, buffer_u8))
				__action_execute(argument0, 2)
			else
				__action_revert(argument0, 2)
			return true
		case (NetPacket.cursor):
			if (object_index == objServer) {
				with (cursors[| ds_list_find_index(clients, argument1)]) {
					targ_x = buffer_read(argument0, buffer_f64)
					targ_y = buffer_read(argument0, buffer_f64)
					alarm[0] = 60 * 10
				}
			}
			return false
		case (NetPacket.cursorSync):
			if (object_index == objClient) {
				var count = buffer_read(argument0, buffer_u8)
				for (var i = 0; i < count; i ++) {
					var idx = buffer_read(argument0, buffer_s16)
					var tx = buffer_read(argument0, buffer_f64)
					var ty = buffer_read(argument0, buffer_f64)
					var c = cursors[? idx];
					if (!is_undefined(c)) {
						with (c) {
							targ_x = tx
							targ_y = ty
						}
					}
				}
			}
			return false
		case (NetPacket.playerInfo):
			if (object_index == objServer) {
				var index = ds_list_find_index(clients, argument1)
				with (cursors[| index]) {
					if (!set) {
						name = buffer_read(argument0, buffer_string)
						set = true
					
						var col = buffer_read(argument0, buffer_u8)
						image_blend = make_colour_hsv(col, 180, 255)
					
						___net_sync_player(name, argument1, -1, col)
					
						// Message
						var st = "'" + name + "' has joined the session."
						scr_alert(st)
						net_sync_chat(st, argument1)
						// Sync level
						var b = __level_save_buffer()
						network_send_packet(argument1, b, buffer_get_size(b))
						buffer_delete(b)
					}
				}
			}
			return false
		case (NetPacket.playerSync):
			if (object_index == objClient) {
				var c = instance_create_depth(0, 0, -999, objClientCursor)
				c.sock = buffer_read(argument0, buffer_s16)
				cursors[? c.sock] = c
				c.name = buffer_read(argument0, buffer_string)
				c.image_blend = make_colour_hsv(buffer_read(argument0, buffer_u8), 180, 255)
				c.set = true
			}
			return false
		case (NetPacket.playerDisconnect):
			if (object_index == objClient) {
				var sock = buffer_read(argument0, buffer_s16)
				if (!is_undefined(cursors[? sock])) {
					instance_destroy(cursors[? sock])
					ds_map_delete(cursors, sock)
				}
			}
			return false
		case (NetPacket.chat):
			scr_message(buffer_read(argument0, buffer_string))
			return true
		case (114):
			// level info
			// 114 is character r
			// "r" is the start of the header
			if (object_index == objClient) {
				// Verify real header
				var st = "orlvl"
				for (var i = 0; i < 5; i ++)
					if (buffer_read(argument0, buffer_u8) != string_byte_at(st, i + 1))
						return false;
				// Reset pos and load it
				__level_clear()
				buffer_seek(argument0, buffer_seek_start, 0)
				global.level_path = ""
				__level_load_buffer(argument0)
			}
			return false
	}

	return true


}
