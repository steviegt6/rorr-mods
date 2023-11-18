draw_sprite(sprUIBottomLeft, 0, ui_left, ui_bottom)

#region Mouse info

draw_set_font(fntMedium)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
var st = string(floor(mouse_x) >> 4) + ", " + string(floor(mouse_y) >> 4)
/*
// Background
draw_set_colour(Colours.sidebar)
var width = 48, height = 8
draw_rectangle(0, ui_bottom - height, width, ui_bottom, false)
draw_triangle(width, ui_bottom - height - 1, width, ui_bottom, width + height + 1, ui_bottom, false)
*/
// Text
//var yy = ui_bottom - 31
//draw_set_colour(c_black)
//draw_text(3, yy + 1, st)
draw_set_colour(c_white)
draw_text(2, ui_bottom - 31, st)

#endregion