
if ((occupied_mouse || mouse_free)
&& point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, ui_right - width, ui_bottom - height - 28, ui_right, ui_bottom)) {
	occupied_mouse = true
	mouse_state = MouseStates.busyUI
} else if (occupied_mouse) {
	occupied_mouse = false
	mouse_state = MouseStates.ready
}


if (objMain.tool == Tools.tilePencil) {
	var ts = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.image]
	width = sprite_get_width(ts) + 30
	height = sprite_get_height(ts) + 60
}