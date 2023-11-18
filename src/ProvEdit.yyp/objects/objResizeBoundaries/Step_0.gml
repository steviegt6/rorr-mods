
if (objMain.edit_mode != EditModes.levelBounds) {
	old_mode = -1
	instance_destroy()
	exit
}

if (!mouse_check_button(mb_left)) {
	my_mouse_x = mouse_x
	my_mouse_y = mouse_y
} 

if (handles != undefined) {
	if (clicked == -1) {
		var dist = 8
		if (global.view_zoom > 1)
			dist = global.view_zoom * 8
	
		var _bar_x = clamp(my_mouse_x, left, right)
		var _bar_y = clamp(my_mouse_y, top, bottom)
	
		hover = -1
		for (var i = 0; i < 8; i += 2) {
			if (point_distance(my_mouse_x, my_mouse_y, handles[i], handles[i + 1]) < dist) {
				hover = floor(i / 2) + 1
				break
			}
		}
	
		if (mouse_check_button_pressed(mb_left)) {
			clicked = hover
			resize_left = false
			resize_right = false
			resize_top = false
			resize_bottom = false
			switch (hover) {
				case 1: resize_top = true break
				case 2: resize_bottom = true break
				case 3: resize_left = true break
				case 4: resize_right = true break
			}
		}
	} else {
		hover = -1
		if (mouse_check_button_released(mb_left)) {
			clicked = -1
		} else {
			if (resize_left) {left = clamp(grid(mouse_x), LV_LEFT_MIN + 16, right - LV_WIDTH_MIN)}
			if (resize_right) {right = clamp(grid(mouse_x), left + LV_WIDTH_MIN, LV_RIGHT_MAX - 16)}
			if (resize_top) {top = clamp(grid(mouse_y), LV_TOP_MIN + 16, bottom - LV_HEIGHT_MIN)}
			if (resize_bottom) {bottom = clamp(grid(mouse_y), top + LV_HEIGHT_MIN, LV_BOTTOM_MAX - 16)}
		}
	}
}

var margin = 16
if global.view_zoom > 1
	margin *= global.view_zoom
var _bar_x = clamp(my_mouse_x, left + margin, right - margin)
var _bar_y = clamp(my_mouse_y, top + margin, bottom - margin)
handles = [_bar_x, top, _bar_x, bottom, left, _bar_y, right, _bar_y]

if (mouse_check_button_pressed(mb_right)) {
	instance_destroy()
}