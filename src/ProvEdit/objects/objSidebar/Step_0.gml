var hover = false;

if ((mouse_state == MouseStates.busyUI && occupied_mouse) || mouse_free) {
	if (mouse_ui_x >= ui_right - 48) 
		hover = true
	/*else {
		var img = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.image]
		var top = ui_bottom - sprite_get_height(img) -4
		var left = ui_right - 48 - sprite_get_width(img) - 4
		if (mouse_ui_x >= left && mouse_ui_y >= top) {
			hover = true
		}
	}*/
}

if (hover || force_occupy) {
	mouse_state = MouseStates.busyUI
	force_occupy = false
	occupied_mouse = true
} else if (mouse_state == MouseStates.busyUI && occupied_mouse) {
	mouse_state = MouseStates.ready
	occupied_mouse = false
}
