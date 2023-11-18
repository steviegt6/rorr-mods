var mxn = device_mouse_x_to_gui(0), myn = device_mouse_y_to_gui(0)
var nww = window_get_width(), nwh = window_get_height()


if (control_on && keyboard_on) {
#region Mode
	if (mouse_state != MouseStates.busyDrawing) {
		if (keyboard_check_pressed(ord("1"))) {
			edit_mode = EditModes.tiles
			with (objSidebar) event_user(0)
		} else if (keyboard_check_pressed(ord("2"))) {
			edit_mode = EditModes.collision
			with (objSidebar) event_user(0)
		} else if (keyboard_check_pressed(ord("3"))) {
			edit_mode = EditModes.objects
			with (objSidebar) event_user(0)
		}
	}
#endregion

#region Layer
	if (keyboard_check_pressed(ord("Q"))) {
		var index = current_layer - 1
		if (index < 0)
			index = array_length_1d(global.tiles) - 1
		select_layer(global.tiles[index])
	}
	if (keyboard_check_pressed(ord("E"))) {
		var index = current_layer + 1
		if (index >= array_length_1d(global.tiles))
			index = 0
		select_layer(global.tiles[index])
	}
#endregion

#region Tool

	switch (edit_mode) {
		case EditModes.tiles:
			tool = tile_tool break
		case EditModes.collision:
			tool = collision_tool break
		case EditModes.objects:
			tool = object_tool break
		default:
			tool = -1
	}
	
	if (mouse_ready_cd == 0) {

		var cantool = true

		if (edit_mode == EditModes.tiles && tile_tool == Tools.tilePencil && mouse_free && keyboard_check(vk_control)) {
			cursor_index = CursorIndex.dropper
			cantool = false
			if (mouse_check_button(mb_left)) {
				var tile = tile_layer_get_at(current_layer, mouse_x >> 4, mouse_y >> 4)
				if (!is_undefined(tile)) {
					global.ProvEdit_tileset[layer_choice.tileset, PROVEDIT_TILESET.selectionInfo] = [
						tile_get_img_x(tile),
						tile_get_img_y(tile),
						1, 1
					]
				}
			}
		}

		if (tool >= 0 && (mouse_state == MouseStates.busyDrawing || (mouse_free && cantool) || was_using_tool == 1)) {
			var mb1_state = 0
	
			if (mouse_check_button_released(mb_left))
				mb1_state = 1
			else if (mouse_check_button_pressed(mb_left))
				mb1_state = 3
			else if (mouse_check_button(mb_left))
				mb1_state = 2

			if (mb1_state == 0)
				mb1_state = 1

			if (mb1_state == 3 || mouse_state == MouseStates.busyDrawing) {
				if (mb1_state != 0) {
					was_using_tool = 1
					tool_use(tool, mb1_state, mouse_x, mouse_y, mouse_x_last, mouse_y_last, false)
				}
		
				if (mb1_state < 2) {
					was_using_tool = 0
					mouse_state = MouseStates.ready
				} else {
					mouse_state = MouseStates.busyDrawing
				}
			}
		}

		if (tool >= 0 && (mouse_state == MouseStates.busyErasing || (mouse_free && cantool) || was_using_tool == 2)) {
			var mb2_state = 0
			if (mouse_check_button_released(mb_right))
				mb2_state = 1
			else if (mouse_check_button_pressed(mb_right))
				mb2_state = 3
			else if (mouse_check_button(mb_right))
				mb2_state = 2

			if (mb2_state == 0)
				mb2_state = 1

			if ((mb2_state == 3 && edit_mode != EditModes.objects) || mouse_state == MouseStates.busyErasing) {
				if (mb2_state != 0) {
					was_using_tool = 2
					tool_use(tool, mb2_state, mouse_x, mouse_y, mouse_x_last, mouse_y_last, true)
				}
		
				if (mb2_state < 2) {
					was_using_tool = 0
					mouse_state = MouseStates.ready
				} else {
					mouse_state = MouseStates.busyErasing
					cursor_index = CursorIndex.eraser
				}
			}
		}

		if (edit_mode == EditModes.objects && mouse_free) {
			if (mouse_check_button_pressed(mb_right)) {
				var tinst = collision_point(mouse_x, mouse_y, objMapObject, 1, 0)
				if (tinst != noone) {
					with objObjectMenu instance_destroy()
					with instance_create_depth(tinst.x, tinst.y, tinst.depth - 1, objObjectMenu) {
						parent = tinst
						world_x = parent.bbox_right + 12
						world_y = parent.bbox_top - 12
					}
				}
			}
		}
	} else {
		mouse_ready_cd -= 1
	}

#endregion

#region Camera
	// WASD MOVEMENT
	////////////////
	if (!keyboard_check(vk_control)) {
		var sp = 8 * global.view_zoom
		if (keyboard_check(vk_shift))
			sp = 32 * global.view_zoom
		
		if (keyboard_check(ord("W")))
			global.view_y -= sp
		if (keyboard_check(ord("A")))
			global.view_x -= sp
		if (keyboard_check(ord("S")))
			global.view_y += sp
		if (keyboard_check(ord("D")))
			global.view_x += sp
	}
	
	// ZOOMING
	//////////
	if (mouse_state != MouseStates.busyUI) {
		var mwdelta = mouse_wheel_down() - mouse_wheel_up()
		if (mwdelta != 0) {
			var old_zoom = global.view_zoom
			global.view_zoom = clamp(global.view_zoom * 1 + mwdelta * 0.2, 0.2, 4)
			if (global.view_zoom < 1.15 && global.view_zoom > 0.85)
				global.view_zoom = 1
			global.view_x += (nww * old_zoom - nww * global.view_zoom) / 2
			global.view_y += (nwh * old_zoom - nwh * global.view_zoom) / 2
		}
	}
	
	// PANNING
	//////////
	if ((mouse_free && mouse_check_button_pressed(mb_middle)) ||  (mouse_check_button(mb_middle) && mouse_state == MouseStates.busyPanning)) {
		mouse_state = MouseStates.busyPanning
		cursor_index = CursorIndex.move
		
		global.view_x += (mouse_ui_x - mxn) * global.view_zoom
		global.view_y += (mouse_ui_y - myn) * global.view_zoom
		
		// Mouse wrapping
		if (mxn <= 0) {
			// Left side
			mxn = nww - 2
			window_mouse_set(mxn, myn)
		} else if (mxn >= nww - 1) {
			// Right side
			mxn = 1
			window_mouse_set(mxn, myn)
		}
		
		if (myn <= 0) {
			// Top side
			myn = nwh - 2
			window_mouse_set(mxn, myn)
		} else if (myn >= nwh - 1) {
			// Bottom text
			myn = 1
			window_mouse_set(mxn, myn)
		}
	} else if (mouse_state == MouseStates.busyPanning) {
		mouse_state = MouseStates.ready
	}
}


// WINDOW RESIZED
/////////////////
if (nww != window_width || nwh != window_height) {
	view_set_xport(0, 0)
	view_set_yport(0, 0)
	view_set_wport(0, nww)
	view_set_hport(0, nwh)
	window_width = nww
	window_height = nwh
	window_was_resized = true
	if (nww > 0 && nwh > 0) {
		surface_resize(application_surface, nww, nwh)
		display_set_gui_size(floor(nww / global.ui_scale / 2) * 2, floor(nwh / global.ui_scale / 2) * 2)
	}
} else {
	window_was_resized = false
}


global.view_x = clamp(global.view_x, LV_LEFT_MIN, LV_RIGHT_MAX - (nww - 48) * global.view_zoom)
global.view_y = clamp(global.view_y, LV_TOP_MIN - 16 * global.view_zoom, LV_BOTTOM_MAX - nwh * global.view_zoom)

camera_set_view_size(global.view, nww * global.view_zoom, nwh * global.view_zoom)
camera_set_view_pos(global.view, global.view_x, global.view_y)
#endregion


mouse_ui_x = mxn
mouse_ui_y = myn

if (!mouse_check_button(mb_left)) {
	mouse_ui_click_x = mxn
	mouse_ui_click_y = myn
}

if (mouse_state == MouseStates.busyUI)
	mouse_ready_cd = 2
