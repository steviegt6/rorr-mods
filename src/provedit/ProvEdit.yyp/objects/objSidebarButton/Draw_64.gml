
var glow = false;
var xoff = 0;

if (selected) {
	xoff = -4
	glow = true
} else
	xoff = max(-hover_time, -4)

if (xoff != 0 && !glow)
	draw_sprite(sprButtonShadow, 0, x, y)
draw_sprite(sprite, subimage, x + xoff, y)
if (glow)
	draw_sprite(sprButtonChoice, 0, x + xoff, y)



if (hover_time > 0 && (group != 2 || !selected)) {
	var box_right = ui_right - 48 - 9;
	var box_top = y + 9;
	
	draw_set_font(fntMedium)
	
	var maxwidth = string_width(hover_tip) + 35
	var width = min(maxwidth, hover_time * 16)
	
	draw_set_colour(Colours.sidebar_light)
	draw_sprite(sprTooltipEnd, 0, box_right + 1, box_top)
	draw_rectangle(box_right - width + 1, box_top, box_right, box_top + 15, false)
	draw_rectangle(box_right - width, box_top + 1, box_right, box_top + 14, false)
	
	if (width == maxwidth) {
		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		//draw_set_colour(c_black)
		//draw_text(box_right - width + 5, box_top + 15, hover_tip)
		draw_set_colour(c_white)
		draw_text(box_right - width + 5, box_top + 13, hover_tip)
	}
}