
if (height > 0) {
	// Main rectangle --------------------------
	draw_set_colour(Colours.sidebar_dark)
	draw_rectangle(ui_right - width, ui_bottom - height, ui_right, ui_bottom, false)
	draw_set_colour(Colours.sidebar)
	draw_rectangle(ui_right - width + 8, ui_bottom - height - 28, ui_right, ui_bottom - height - 1, false)
	draw_sprite(sprToolPanelHead, 0, ui_right - width, ui_bottom - height - 28)

	// Text ------------------------------------
	draw_set_colour(c_white)
	draw_set_font(fntMedium)
	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)
	draw_text(ui_right - width + 12, ui_bottom - height - 15, header_text)
	draw_set_colour(c_gray)
	draw_text(ui_right - width + 12, ui_bottom - height - 3, header_subtext)
}