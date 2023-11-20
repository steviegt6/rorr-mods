
draw_set_colour(instance_exists(objResizeBoundaries) ? c_gray : c_yellow)
draw_rectangle_zoom(lv_left, lv_top, lv_right, lv_bottom, 2)

#region Grid
if (global.disp_grid_on) {
	var alpha = abs(sin(current_time / 1000)) * 0.02 + 0.08
	if (global.view_zoom <= 1) {
		draw_sprite_tiled_ext(sprGrid16, 0, 0, 0, 1, 1, c_ltgray, alpha)
	} else if (true) {//global.view_zoom <= 2) {
		draw_set_colour(c_ltgray)
		draw_set_alpha(alpha)
		var vx = global.view_x
		var vy = global.view_y
		var vw = window_width * global.view_zoom
		var vh = window_height * global.view_zoom
		for (var i = -(vy % 16); i < vh; i += 16) {
			draw_line(vx, vy + i, vx + vw, vy + i)
		}
		for (var i = -(vx % 16); i < vw; i += 16) {
			draw_line(vx + i, vy, vx + i, vy + vh)
		}
		draw_set_alpha(1)
	}
}
#endregion

#region Tool

if (cursor_visible && mouse_ready_cd == 0) {
	if (mouse_free) {
		switch (edit_mode) {
			case EditModes.tiles:
				var tileset = layer_choice.tileset
				var xx, yy
				var tx1, tx2, ty1, ty2, tw, th
				var choice
				var dropper = false
				if (tool == Tools.tileBrush) {
					var size = tool_tile_brush_size * 16
					var offs = floor(tool_tile_brush_size - 0.5) * 8
					xx = grid(mouse_x - offs)
					yy = grid(mouse_y - offs)
					tx1 = xx
					ty1 = yy
					tx2 = tx1 + size
					ty2 = ty1 + size
				} else if (tool == Tools.tilePencil) {
					if (mouse_free && keyboard_check(vk_control)) {
						xx = grid(mouse_x)
						yy = grid(mouse_y)
						tx1 = xx
						ty1 = yy
						tx2 = xx + 16
						ty2 = yy + 16
						dropper = true
					} else {
						if (tool_tile_pencil_size % 2 != 0) {
							xx = grid(mouse_x)
							yy = grid(mouse_y)
						} else {
							xx = grid(mouse_x - 8)
							yy = grid(mouse_y - 8)
						}
						choice = global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.selectionInfo]
						tx1 = xx
						ty1 = yy
						if (tool_tile_pencil_randomize) {
							tx2 = tx1 + 16
							ty2 = ty1 + 16
							tw = 1
							th = 1
						} else {
							tx2 = tx1 + choice[2] * 16
							ty2 = ty1 + choice[3] * 16
							tw = choice[2]
							th = choice[3]
						}
						var _low = floor((tool_tile_pencil_size - 1) / 2) * 16
						var _high = ceil((tool_tile_pencil_size - 1) / 2) * 16
						tx1 -= _low
						ty1 -= _low
						tx2 += _high
						ty2 += _high
					}
				} else
					break
			
			
				//if (!keyboard_check(vk_shift)) {
					gpu_set_blendmode(bm_add)
					if (tool == Tools.tilePencil && !dropper) {
						var img = global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.image]
						var alpha = abs(sin(current_time / 900)) * 0.3 + 0.1
						if (tool_tile_pencil_size == 1) {
							draw_sprite_part_ext(
								img, 0, choice[0] * 16, choice[1] * 16, tw * 16, th * 16,
								tx1, ty1, 1, 1, c_yellow, alpha
							)
						} else {
							var mx = choice[0]
							var my = choice[1]
							var mw = tw - 1
							var mh = th - 1
							for (var i = 0; i < tool_tile_pencil_size + mw; i++) {
								for (var j = 0; j < tool_tile_pencil_size + mh; j++) {
									draw_sprite_part_ext(
										img, 0, (mx + min(i, mw)) * 16, (my + min(j, mh)) * 16, 16, 16,
										tx1 + i * 16, ty1 + j * 16, 1, 1, c_yellow, alpha
									)
								}
							}
						}
					}
					gpu_set_blendmode(bm_normal)
					draw_set_colour(!dropper ? c_yellow : c_aqua)
					draw_rectangle_zoom(tx1, ty1, tx2, ty2, 1)
				/*} else {
					draw_set_colour(c_aqua)
					draw_rectangle_zoom(xx, yy, xx, yy, 1)
				}*/
				break
			case EditModes.collision:
				var xx, yy
				var tx1, tx2, ty1, ty2
				var choice
				xx = grid(mouse_x)
				yy = grid(mouse_y)
			
				draw_set_colour(global.collision_types[collision_type, 1])
				gpu_set_blendmode(bm_add)
				draw_set_alpha(abs(sin(current_time / 900)) * 0.3 + 0.1)
				draw_rectangle(xx, yy, xx + 15, yy + 15, false)
				draw_set_alpha(1)
				gpu_set_blendmode(bm_normal)
				draw_rectangle_zoom(xx, yy, xx + 16, yy + 16, 1)
				break
		}
	} else if (mouse_state == MouseStates.busyErasing && edit_mode != EditModes.objects) {
		var xx, yy
		var ww, hh
		if (tool == Tools.tilePencil) {
			ww = (tool_tile_pencil_size * 16) - 1
			hh = ww
			if (tool_tile_pencil_size % 2 == 0) {
				xx = grid(mouse_x - 8)
				yy = grid(mouse_y - 8)
			} else {
				xx = grid(mouse_x)
				yy = grid(mouse_y)
			}
			var _low = floor((tool_tile_pencil_size - 1) / 2) * 16
			xx -= _low
			yy -= _low
		} else {
			xx = grid(mouse_x)
			yy = grid(mouse_y)
			ww = 15
			hh = 15
		}
		draw_set_colour(c_red)
		gpu_set_blendmode(bm_add)
		draw_set_alpha(abs(sin(current_time / 900)) * 0.3 + 0.1)
		draw_rectangle(xx, yy, xx + ww, yy + hh, false)
		gpu_set_blendmode(bm_normal)
		draw_set_alpha(1)
		draw_rectangle_zoom(xx, yy, xx + ww + 1, yy + hh + 1, 1)
	}

	if (edit_mode == EditModes.objects && (mouse_free || mouse_state == MouseStates.busyErasing || mouse_state == MouseStates.busyDrawing)) {
		var hover = collision_point(mouse_x, mouse_y, objMapObject, 1, 0)
		if (hover != noone) {
			with (hover) {
				draw_self()
				gpu_set_fog(1, Colours.blue, 0, 0)
				draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, 0, (abs(sin(current_time / 900)) * 0.5 + 0.3))
				gpu_set_fog(0, 0, 0, 0)
			}
		} else if (object_exists(object_type)) {
			var xx, yy
			var tx1, tx2, ty1, ty2
			var choice
			xx = ((mouse_x) >> 3) << 3
			yy = ((mouse_y + 8) >> 3) << 3
	
			draw_sprite_ext(global.ProvEdit_object[object_type, PROVEDIT_LEVELOBJECT.sprite], 0, xx, yy, 1, 1, 0, c_white, (abs(sin(current_time / 900)) * 0.3 + 0.1))
		}
	}
}

#endregion


with (objClientCursor)
	event_user(0)