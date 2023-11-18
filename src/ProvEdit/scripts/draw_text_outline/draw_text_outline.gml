/// @function draw_text_outline(x,y,string,outlineColour,textColour)
/// @param x
/// @param y
/// @param string
/// @param outlineColour
/// @param textColour

draw_set_colour(argument3)
draw_text(argument0 - 1, argument1, argument2)
draw_text(argument0, argument1 - 1, argument2)
draw_text(argument0 + 1, argument1, argument2)
draw_text(argument0, argument1 + 1, argument2)

draw_set_colour(argument4)
draw_text(argument0, argument1, argument2)