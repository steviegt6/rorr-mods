
draw_set_colour(Colours.sidebar)
draw_rectangle(ui_left, 0, ui_right, ui_top - 1, false)

draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_set_font(fntMedium)

for (var i = 0; i < button_count; i++) {
	var b = buttons[i]
	var bx = 4 + i * 36
	
	var frame = 0;
	var yoffs = 0;
	
	if (menu_open == noone) {
		if (i == choice && choice_clicked == -1)
			frame = 1
		else if (i == choice_clicked) {
			frame = 2
			yoffs = 2
		}
	} else {
		if (i == menu_open.parent_choice)
			frame = 1
	}
	
	draw_sprite(sprTopbarButton, frame, bx, 2)
	draw_set_colour(c_white)
	draw_text(bx + 5, ui_top - 3 + yoffs, b[0])
}

draw_set_halign(fa_right)
draw_text(ui_right - 3, ui_top - 3, global.level_name)

/*
draw_set_colour(c_ltgray)
draw_set_halign(fa_right)
draw_set_font(fntTinyCasable)
draw_text(ui_right - 2, ui_top, global.level_name)
*/