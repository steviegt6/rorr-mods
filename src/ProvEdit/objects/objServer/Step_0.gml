
sync_mouse -= 1

if sync_mouse <= 0 {
	___net_sync_cursor_server()
	sync_mouse = 5
}