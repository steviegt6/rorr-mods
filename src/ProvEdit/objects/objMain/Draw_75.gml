/// @description Cursor

if (cursor_visible) {
	window_set_cursor(cr_none)
	draw_sprite(sprCursor, cursor_index, mouse_ui_x, mouse_ui_y)
	if (mouse_free && mouse_ready_cd == 0) {
		draw_set_font(fntTinyCasable)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		if (edit_mode != EditModes.levelBounds) {
			draw_text_outline(
				mouse_ui_x + 18, mouse_ui_y,
				layer_choice.name + "\nDepth: " + string(layer_choice.depth),
				$493935, layer_choice.visible ? $FFF1ED : c_red
			)
		} else {
			draw_text_outline(
				mouse_ui_x + 18, mouse_ui_y,
				"Resizing level bounds.\nRight click to exit.",
				$493935, Colours.blue
			)
		}
	}
} else {
	window_set_cursor(cr_default)
}


if (mouse_tip_time > 50 && mouse_tip != "") {
	draw_set_font(fntMedium)
	draw_set_align(fa_left, fa_top)
	var _tx = mouse_ui_x + 20, _ty = mouse_ui_y + 4
	var _tty = _ty, _ttx = _tx // tip coords
	var _tidx = 0 // tip index
	// rect bounds
	var _tr = _tx + string_width(mouse_tip) + 4
	var _targ_height = string_height(mouse_tip) + 2
	var _height =  + min(_targ_height, (mouse_tip_time - 50) * 12)
	var _tb = _ty + _height
	
	if (_tb > ui_bottom - 8) {
		// Snap to bottom 
		var _diff = _tb - (ui_bottom - 8)
		_tb -= _diff
		_ty -= _diff
		
	}
	if (_tb - 8 <= _tty) {
		_tty = _tb - 8
		_tidx = 1
	}
	
	
	if (_tr > ui_right - 4) {
		// Flip on right 
		var _diff = _tr - (mouse_ui_x - 10)
		_tr -= _diff
		_tx -= _diff
		_tidx += 2
		_ttx = _tr + 6
	}
	
	draw_set_colour(c_black)
	draw_roundrect_ext(_tx - 1, _ty, _tr - 1, _tb, 4, 4, false)
	draw_roundrect_ext(_tx, _ty + 3, _tr, _tb + 2, 4, 4, false)
	draw_set_colour(0xB2DBEA)
	draw_roundrect_ext(_tx, _ty, _tr, _tb, 4, 4, false)
	draw_sprite(sprCursorTipEnd, _tidx, _ttx, _tty)
	
	if (_height == _targ_height) {
		draw_set_colour(c_black)
		draw_text(_tx + 3, _ty + 2, mouse_tip)
	}
}
