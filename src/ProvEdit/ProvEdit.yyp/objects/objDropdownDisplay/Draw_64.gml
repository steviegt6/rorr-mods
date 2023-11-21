var midwidth = (width - 8) / 4
draw_set_colour(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_font(fntConsole)
var maxwidth = floor((width - 4) / 7)
for (var i = 0; i < elements_visible; i++) {
	var _y = y + i * 15
	
	// Get frame of body
	var frame
	if (hover_element == i)
		frame = 2
	else
		frame = i % 2
	if (i == elements_visible - 1)
		frame += 3
	
	// Draw body
	draw_sprite_part(sprFormDropdownList, frame, 0, 0, 4, 15, x, _y)
	draw_sprite_part_ext(sprFormDropdownList, frame, 4, 0, 4, 15, x + 4, _y, midwidth, 1, c_white, 1)
	draw_sprite_part(sprFormDropdownList, frame, 8, 0, 4, 15, x + width - 4, _y)
	
	// Draw text
	if (hover_element == i)
		draw_set_colour(c_dkgray)
	draw_text(x + 2, y + i * 15 + 4, string_shorten_monospace(elements[i], maxwidth))
	if (hover_element == i)
		draw_set_colour(c_white)
}