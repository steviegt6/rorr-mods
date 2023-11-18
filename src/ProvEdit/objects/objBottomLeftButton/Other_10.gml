
switch (identity) {
	// Zoom in / out
	case 0:
	case 1:
		var mwdelta = 1
		if (identity == 0)
			mwdelta = -1
		var nww = window_get_width(), nwh = window_get_height();
		var old_zoom = global.view_zoom
		if (global.view_zoom + 0.5 * mwdelta >= 1) {
			global.view_zoom = clamp(global.view_zoom + 0.5 * mwdelta, 1, 4)
		} else {
			global.view_zoom = clamp(1 / (round(1 / global.view_zoom) - mwdelta), 0.2, 1)
		}
		global.view_x += (nww * old_zoom - nww * global.view_zoom) / 2
		global.view_y += (nwh * old_zoom - nwh * global.view_zoom) / 2
		break
	// Reset zoom
	case 2:
		var nww = window_get_width(), nwh = window_get_height();
		var old_zoom = global.view_zoom
		global.view_zoom = 1
		global.view_x += (nww * old_zoom - nww * global.view_zoom) / 2
		global.view_y += (nwh * old_zoom - nwh * global.view_zoom) / 2
		break
	// Snap corners
	case 3:
		instance_create_depth(0, 0, -9990, objSnapCorners)
		break
	/// Settings
	case 4:
		_level_settings(0)
		break
	
	
}