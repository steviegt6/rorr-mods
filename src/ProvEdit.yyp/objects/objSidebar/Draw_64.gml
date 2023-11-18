
draw_set_colour(Colours.sidebar)


var bar_l = ui_right - 48;
draw_rectangle(bar_l, ui_top, ui_right, ui_bottom, false)

draw_sprite(sprSidebarRoundIn, 0, bar_l, ui_top)
draw_sprite(sprSidebarRoundIn, 0, bar_l, ui_bottom - objToolPanel.height - (objToolPanel.height > 0 ? 28 : 0))

draw_sprite(sprSidebarHeaders, 0, bar_l, ui_top)
if (objMain.edit_mode >= EditModes.tiles && objMain.edit_mode <= EditModes.objects)
	draw_sprite(sprSidebarHeaders, 1, bar_l, ui_top + 158)

/*
if (objMain.edit_mode == EditModes.tiles) {
	var img = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.image]
	var left = bar_l - sprite_get_width(img)
	var top = ui_bottom - sprite_get_height(img)
	draw_sprite(sprSidebarRoundOut, 0, left - 4, top - 4)
	draw_sprite(sprSidebarRoundIn, 0, bar_l, top - 4)
	draw_sprite(sprSidebarRoundIn, 0, left - 4, ui_bottom)
	draw_rectangle(left + 4, top - 4, bar_l, top, false)
	draw_rectangle(left - 4, top + 4, left, ui_bottom, false)
	draw_set_colour($2D2022)
	draw_rectangle(left, top, bar_l, ui_bottom, false)
	draw_sprite(img, 0, left, top)
	
	draw_set_colour(c_yellow)
	var tx = objMain.layer_choice.tile_choice_x, ty = objMain.layer_choice.tile_choice_y
	draw_rectangle(left - 1 + tx * 16, top - 1 + ty * 16, left + 16 + tx * 16, top + 16 + ty * 16, true)
	
	if (mouse_state == MouseStates.busyUI) {
		if (point_in_rectangle(mouse_ui_x, mouse_ui_y, left, top, left + sprite_get_width(img), top + sprite_get_height(img))) {
			var mrx = floor((mouse_ui_x - left) / 16), mry = floor((mouse_ui_y - top) / 16)
			draw_set_alpha(0.5)
			draw_rectangle(left - 1 + mrx * 16, top - 1 + mry * 16, left + 16 + mrx * 16, top + 16 + mry * 16, true)
			draw_set_alpha(1)
			
			// TODO: move to step
			if (mouse_check_button_pressed(mb_left)) {
				objMain.layer_choice.tile_choice_x = mrx
				objMain.layer_choice.tile_choice_y = mry
			}
		}
	}
}
*/