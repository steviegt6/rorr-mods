draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_set_font(fntMedium)

draw_set_colour(Colours.sidebar_mid)
draw_rectangle(x - 2, y - 2, x + width + 2, y + height + 2, false)
draw_set_colour(Colours.sidebar)
draw_rectangle(x, y + 10, x + width, y + height, false)

draw_set_colour(c_gray)
draw_text(x + 2, y + 10, string_shorten(title, width - 8))

draw_set_colour(c_white)

var val = var_ref_get(ref)
for (var i = 0; i < count; i++) {
	if (values[i] == val) {
		choice = i
		break
	}
}

var twidth = width - 8
var tyy = 23
if (number_visible < count) twidth -= 6
for (var i = index_visible; tyy < height && i < count; i++) {
	var ytyy = y + tyy
	if (hover == i) {
		draw_set_colour(c_gray)
		draw_rectangle(x, ytyy - 13, x + width, ytyy + 1, false)
		draw_set_colour(c_white)
	} else if (choice == i) {
		draw_set_colour(c_dkgray)
		draw_rectangle(x, ytyy - 13, x + width, ytyy + 1, false)
		draw_set_colour(c_white)
	}
	draw_text(x + 4, ytyy, string_shorten(contents[i], twidth))
	tyy += 12
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


