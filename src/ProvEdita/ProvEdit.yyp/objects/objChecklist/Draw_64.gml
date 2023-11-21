height = number_visible * 21

if (array_length_1d(visible_elements) == 0) {
	visible_elements = []
	unpicked_elements = []
	count = 0
	var ucount = 0
	for (var i = 0; i < array_height_2d(elements); i++) {
		if (elements[i, 0]) {
			visible_elements[count] = i
			count++
		} else {
			unpicked_elements[ucount] = i
			ucount++
		}
	}
	if (orderable) {
		for (var i = 0; i < array_length_1d(visible_elements) - 1; i++) {
			var maxval = [i, elements[visible_elements[i], 2]]
			for (var j = i + 1; j < array_length_1d(visible_elements); j++) {
				var curval = [j, elements[visible_elements[j], 2]]
				if (curval[1] > maxval[1])
					maxval = curval
			}
			var tempvar = visible_elements[maxval[0]]
			visible_elements[maxval[0]] = visible_elements[i]
			visible_elements[i] = tempvar
		}
	}
}

draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_set_font(fntMedium)

draw_set_colour(Colours.sidebar_mid)
draw_rectangle(x - 3, y - 3, x + width + 3, y + height + 3 + 21 + 3, false)
draw_set_colour(Colours.sidebar)
draw_rectangle(x, y, x + width, y + height, false)
draw_rectangle(x, y + height + 3, x + width - 21 - 2, y + height + 3 + 21, false)
draw_set_colour(Colours.sidebar_light)
draw_rectangle(x + width - 21, y + height + 3, x + width, y + height + 3 + 21, false)
draw_set_colour(Colours.sidebar_dark)
draw_rectangle(x + width - 21 + 4, y + height + 3 + 10, x + width - 4, y + height + 3 + 21 - 10, false)
draw_rectangle(x + width - 21 + 10, y + height + 3 + 4, x + width - 10, y + height + 3 + 21 - 4, false)


draw_set_colour(c_white)

var twidth = width - 11
var tyy = 16
if (number_visible < count) twidth -= 6
for (var i = index_visible; tyy < height && i < count; i++) {
	var ii = visible_elements[i]
	var ytyy = y + tyy
	var si = 2
	if (choice == ii) {
		draw_set_colour(c_gray)
		draw_rectangle(x, ytyy - 16, x + width, ytyy + 5, false)
		draw_set_colour(c_white)
		if (choice_checkbox) {
			si--
		} else if (hover == ii && hover_checkbox) {
			si++
		}
	} else if (hover == ii) {
		draw_set_colour(c_dkgray)
		draw_rectangle(x, ytyy - 16, x + width, ytyy + 5, false)
		draw_set_colour(c_white)
		if (hover_checkbox) {
			si++
		}
	//} else if (i mod 2) {
	//	draw_set_colour(c_gray)
	//	draw_rectangle(x, ytyy - 16, x + width, ytyy + 5, false)
	//	draw_set_colour(c_white)
	//} else {
	//	draw_set_colour(c_dkgray)
	//	draw_rectangle(x, ytyy - 16, x + width, ytyy + 5, false)
	//	draw_set_colour(c_white)
	}
	if (orderable) {
		var siu = 0
		var sid = 0
		if (i == 0)
			siu = 2
		else if (hover == ii && hover_order == -1)
			siu = 1
		if (i == array_length_1d(visible_elements) - 1)
			sid = 2
		else if (hover == ii && hover_order == 1)
			sid = 1
		
		draw_sprite_ext(sprFormDropdownButton, siu, x, ytyy - 16 + 10 + 1,
			10 / sprite_get_width(sprFormDropdownButton), -1 * 10 / sprite_get_height(sprFormDropdownButton), 0, c_white, 1)
		draw_sprite_ext(sprFormDropdownButton, sid, x, ytyy - 16 + 10 + 1,
			10 / sprite_get_width(sprFormDropdownButton), 10 / sprite_get_height(sprFormDropdownButton), 0, c_white, 1)
	}
	draw_sprite(sprFormCheckbox, si, x + twidth, ytyy - 6)
	if (orderable)
		draw_text(x + 4 + 10, ytyy, string_shorten(elements[ii, 1], twidth - 6 - 11 - 10))
	else
		draw_text(x + 4, ytyy, string_shorten(elements[ii, 1], twidth - 6 - 11))
	tyy += 21
}

if (number_visible < count) {
	
	draw_set_colour(Colours.sidebar_mid)
	//if (hover == -2)
	//	draw_set_colour(c_gray)
	draw_rectangle(x + width - 6, y + 10, x + width, y + height, false)
	
	draw_set_colour(c_white)
	var max_h = height - 10 - 6
	var ty = y + 10 + (index_visible / (count - number_visible)) * max_h	
	
	draw_rectangle(x + width - 6, ty, x + width, ty + 6, false)
	
}

if (dropdown_selected != -1) {
	draw_text(x + 4, y + height + 3 + 16, string_shorten(elements[dropdown_selected, 1], twidth - 6))
}

