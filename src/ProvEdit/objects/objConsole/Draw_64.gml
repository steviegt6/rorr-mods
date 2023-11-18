
if (height != 0) {
	draw_set_colour(Colours.sidebar_dark)
	draw_rectangle(ui_left, ui_bottom, ui_right, ui_bottom_raw, false)
	draw_set_font(fntConsole)
	draw_set_align(fa_top, fa_left)
	
	////////////////////////////////////////////////
	//Redraw surface ///////////////////////////////
	
	// update size / refresh
	var _swidth = ui_right - ui_left;
	if (!surface_exists(surf)) {
		surf = surface_create(_swidth, maxheight)
	} else if (surface_get_width(surf) != _swidth || surface_get_height(surf) != maxheight) {
		surface_resize(surf, _swidth, maxheight)
	}
	
	surface_set_target(surf)
	draw_clear_alpha(c_white, 0)
	var tscroll = scroll % line_height;
	var yy = height - line_height + tscroll;
	var msgs = ds_list_size(messages);
	draw_set_colour(c_ltgray)
	// Draw messages
	for (var i = floor(scroll / line_height); i < msgs; i++) {
		var msg = messages[| i];
		
		draw_text(3, yy, msg)
		
		yy -= line_height;
		if (yy < -line_height)
			break
	}
	surface_reset_target()

	var _theight = floor(min(typeheight, height))
	
	draw_surface_part(surf, 0, _theight, surface_get_width(surf), surface_get_height(surf) - _theight, ui_left, ui_bottom_raw - round(height))
	
	
	if (maxscroll != 0) {
		var offs = typeheight + 4;
		var by = max(ui_bottom_raw - (height - offs) * scroll / maxscroll - offs, ui_bottom);
		draw_set_colour(Colours.sidebar_mid)
		draw_rectangle(ui_right - 4, ui_bottom, ui_right, ui_bottom_raw, false)
		draw_set_colour(c_white)
		draw_rectangle(ui_right - 4, by, ui_right, by + 3, false)
	}
	
	if (typeheight > 0) {
		// Draw typed line
		draw_set_colour(Colours.sidebar_mid)
		draw_rectangle(ui_left, ui_bottom_raw - _theight, ui_right, ui_bottom_raw, false)
		draw_set_colour(c_white)
		draw_text(3, ui_bottom_raw - _theight + 2, keyboard_string)
		// Cursor flash
		if (current_time % 1000 <= 500) {
			var rect_x = 3 + string_width(keyboard_string)
			var rect_y = ui_bottom_raw - _theight + 2
			draw_rectangle(rect_x, rect_y, rect_x + 7, rect_y + 7, false)
		}
	}
	
}
