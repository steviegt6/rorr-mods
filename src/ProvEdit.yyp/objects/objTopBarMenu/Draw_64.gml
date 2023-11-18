draw_set_colour(Colours.sidebar)
draw_roundrect_ext(x, 0, x + width - 1, y + height - 1, 8, 8, false)

draw_set_valign(fa_bottom)
for (var i = 1; i <= elements; i++) {
	var c = contents[i]
	var l = array_length_1d(c)
	var disabled = false
	if (l > 2 && c[2] != undefined) disabled = script_execute(c[2])
	var ty = y + i * 16
	var col2 = c_gray
	var col1 = c_white
	
	if (disabled) {
		col1 = c_black
		col2 = c_black
	} else if (choice == i) {
		var col = c_gray
		if (clicked_choice != 0) {
			col = c_ltgray
			col2 = c_white
		} else {
			col2 = c_ltgray
		}
		draw_set_colour(col)
		draw_rectangle(x, ty - 14, x + width - 1, ty - 2, false)
		
	}
	
	draw_set_colour(col1)
	draw_set_halign(fa_left)
	draw_set_font(fntMedium)
	draw_text(x + 3, ty - 2, c[0])
	
	if (l > 1) {
		draw_set_colour(col2)
		draw_set_halign(fa_right)
		draw_set_font(fntTiny)
		draw_text(x + width - 2, ty - 2, c[1])
	}
}