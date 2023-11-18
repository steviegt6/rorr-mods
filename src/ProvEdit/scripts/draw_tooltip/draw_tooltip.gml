
draw_set_font(fntMedium)
draw_set_valign(fa_bottom)

var first = argument2 + " "
var shortcut = argument3

var box_top = argument1 - 17
var box_bottom = argument1 - 3

var first_width = string_width(first)
draw_set_font(fntTinyCasable)
var shortcut_width = string_width(shortcut)
draw_set_font(fntMedium)

var max_width = first_width + shortcut_width + 8
var box_width = min(argument4 * 16 + 17, max_width)

draw_set_colour(Colours.sidebar_light)
draw_sprite_ext(sprTooltipEnd, 0, argument0, argument1 - 2, -1, 1, 90, c_white, 1)
draw_sprite_ext(sprTooltipEnd, 0, argument0 + 1, argument1 - 2, -1, 1, 90, c_white, 1)
argument0 -= 2
draw_rectangle(argument0 + 1, box_top, argument0 + box_width - 1, box_bottom, false)
draw_rectangle(argument0, box_top + 1, argument0 + box_width, box_bottom - 1, false)
if (box_width == max_width) {
	draw_set_colour(c_white)
	draw_text(argument0 + 4, argument1 - 4, first)
	draw_set_font(fntTinyCasable)
	draw_set_colour(c_gray)
	draw_text(argument0 + first_width + 6, argument1 - 4, shortcut)
}

/*var box_right = ui_right - 48 - 9;
var box_top = y + 9;
	
	
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