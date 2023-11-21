
ds_list_clear(layer_list)
for (var i = 0; i < array_length_1d(global.tiles); i++) 
	ds_list_add(layer_list, global.tiles[i])// Modify this to sort by depth later
//with (objTileLayer) ds_list_add(other.layer_list, id)

var release_index = -1
var release_hover_cog = -1
if (mouse_check_button_released(mb_left)) {
	release_index = hover
	release_hover_cog = hovering_cog
}

var count = ds_list_size(layer_list)
hover = -1
hovering_cog = false

if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width + 15 - 61, y + height + 2, x + width + 14, y + height + 16)) {
	hover = -2
	objMain.mouse_tip = "Create a new tile layer."
} else if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width, y + 5, x + width + 13, y + height - 5)) {
	hover = -3
} else if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x - 2, y - 2, x + width + 14, y + height + 1)) {
	index_visible = clamp(index_visible - mouse_wheel_up() + mouse_wheel_down(), 0, max(count - number_visible, 0))
	var tyy = 18
	for (var i = index_visible; tyy <= height && i < count; i++) {
		var ytyy = y + tyy
		if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, ytyy - 18, x + width, ytyy - 1)) {
			hover = i
			if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width - 32, ytyy - 17, x + width - 16, ytyy - 2)) {
				hovering_cog = 1
				objMain.mouse_tip = "Modify this layer's settings."
			} else if (count > 1 && point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width - 16, ytyy - 17, x + width - 2, ytyy - 2)) {
				hovering_cog = 2
				objMain.mouse_tip = "Delete this layer."
			} else if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + 2, ytyy - 17, x + 16, ytyy - 2)) {
				hovering_cog = 3
				objMain.mouse_tip = "Toggle layer visibility."
			}
		}
		tyy += 18
	}
}

if (hover != -1) {
	clicked_state = mouse_check_button(mb_left)
} else {
	clicked_state = 0
}

if (hover == -3 && mouse_check_button(mb_left) && count > number_visible) {
	index_visible = clamp(round((mouse_ui_y - y + 5) / (height - 10) * (count - number_visible)), 0, count - number_visible)
}

if (hover == release_index && hovering_cog == release_hover_cog) {
	if (hover >= 0) {
		switch (hovering_cog) {
			case 1:
				_popup_edit_layer(layer_list[| hover])
				instance_destroy(parent)
				break
			case 2:
				if (count == 1) break
				var str = "Are you sure you want to delete the layer '" + layer_list[| hover].name + "'?"
				draw_set_font(fntMedium)
				var popup = show_popup("Confirm Action", 200, 80 + string_height_ext(str, global.font_height[fntMedium], 200 - 4) - 24, [
					[_format_colour, c_black],
					[_format_text, str],
					[_format_colour, c_white],
					[_format_left],
					[_format_button, "Cancel"],
					[_format_right],
					[_format_button, "Delete"],
				], ___popup_delete_layer_handle)
				popup.layer_id = layer_list[| hover]
				instance_destroy(parent)
				break
			case 3:
				layer_list[| hover].visible = !layer_list[| hover].visible
				break
			case 0:
				select_layer(layer_list[| hover])
				break
		}
	} else {
		if (hover == -2) {
			_popup_edit_layer(-1)
			instance_destroy(parent)
		}
	}
}