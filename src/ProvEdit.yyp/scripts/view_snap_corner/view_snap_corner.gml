function view_snap_corner(argument0) {
	var nww = window_get_width(), nwh = window_get_height();

	if (argument0 == 0 || argument0 == 3)
		global.view_x = lv_left
	else
		global.view_x = lv_right - (nww - 48) * global.view_zoom


	if (argument0 == 0 || argument0 == 1)
		global.view_y = lv_top - 16 * global.view_zoom
	else
		global.view_y = lv_bottom - nwh * global.view_zoom




}
