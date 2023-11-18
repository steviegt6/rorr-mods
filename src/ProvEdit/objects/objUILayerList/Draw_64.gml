
var count = ds_list_size(layer_list)

// BACKGROUNd
draw_set_colour(Colours.sidebar_mid)
draw_rectangle(x - 3, y - 1, x + width + 14, y + height, false)
draw_rectangle(x - 1, y - 3, x + width + 12, y + height + 2, false)
draw_rectangle(x - 2, y - 2, x + width + 13, y + height + 1, false)
draw_set_colour(Colours.sidebar)
draw_rectangle(x - 1, y - 1, x + width, y + height, false)
draw_set_colour(Colours.sidebar_mid)
draw_rectangle(x, y, x + width - 1, y + height - 1, false)

// BUTTON
draw_set_halign(fa_middle)
draw_set_valign(fa_bottom)
draw_set_font(fntMedium)
var offs = 0
var frame = 0
if (hover == -2) {
	if (clicked_state == 1) {
		frame = 2
		offs = 1
	} else {
		frame = 1
	}
}
draw_sprite(sprLayerListButton, frame, x + width + 15 - 61, y + height + 3)
draw_set_colour(c_white)
draw_text(x + width + 15 - 30, y + height + 15 + offs, "Add")

// SCROLLBAR
var vis = (number_visible / count)
var bar_x = x + width + 4
draw_set_colour(Colours.sidebar)
draw_rectangle(bar_x + 3, y + 9, bar_x + 5, y + height - 10, false)
draw_sprite(sprLayerListScrollbar, 0, bar_x, y - 1)
draw_sprite(sprLayerListScrollbar, 1, bar_x, y + height - 4)
var bar_h = clamp(floor((height - 16) * vis), 15, height - 16)
var max_h = height - 16 - bar_h
var bar_y = y - 1 + 9
if (count > number_visible)
	bar_y += floor((index_visible / (count - number_visible)) * max_h)
var frame_ext = 0
if (hover == -3)
	frame_ext = 4
draw_sprite(sprLayerListScrollbar, 2 + frame_ext, bar_x, bar_y)
draw_sprite(sprLayerListScrollbar, 3 + frame_ext, bar_x, bar_y + bar_h - 5)
draw_sprite_ext(sprLayerListScrollbar, 4 + frame_ext, bar_x, bar_y + 5, 1, (bar_h - 10) / 5, 0, c_white, 1)
draw_sprite(sprLayerListScrollbar, 5 + frame_ext, bar_x, bar_y + floor(bar_h / 2 - 2.5))




// CONTENTS

draw_set_colour(c_white)
var tyy = 18
for (var i = index_visible; tyy <= height; i++) {
	var ytyy = y + tyy
	var col = c_white
	var cog_index = 0
	var trash_index = 0
	var check_index = 0
	if (i < count && (layer_list[| i] == objMain.layer_choice || i == hover)) {
		draw_set_colour(layer_list[| i] == objMain.layer_choice ? c_white : Colours.blue)
		draw_rectangle(x, ytyy - 17, x + width, ytyy, false)
		col = c_black
		cog_index = 1
		trash_index = 1
		check_index = 2
		if (i == hover && !mouse_check_button(mb_left)) {
			switch (hovering_cog) {
				case 1:
					cog_index = 2
					break
				case 2:
					trash_index = 2
					break
			}
		}
	} else if (i % 2 != 0) {
		draw_set_colour(Colours.sidebar)
		draw_rectangle(x, ytyy - 17, x + width, ytyy, false)
	}
	if (i < count) {
		var tlayer = layer_list[| i]
		var depthstr = string(tlayer.depth)
		if (tlayer.visible)
			check_index += 3
		draw_set_colour(col)
		draw_set_halign(fa_left)
		draw_text(x + 19, ytyy - 3, string_shorten(tlayer.name, width - 58 - string_width(depthstr)))
		draw_set_halign(fa_right)
		draw_set_colour(col == c_white ? c_ltgray : c_dkgray)
		draw_text(x + width - 32, ytyy - 3, depthstr)
		draw_sprite(sprLayerListCog, cog_index, x + width - 32 + 3, ytyy - 16)
		if (count > 1) draw_sprite(sprLayerListCog, trash_index + 3, x + width - 16 + 1, ytyy - 16)
		draw_sprite(sprCheckbox, check_index, x + 3, ytyy - 15)
	}
	tyy += 18
}

