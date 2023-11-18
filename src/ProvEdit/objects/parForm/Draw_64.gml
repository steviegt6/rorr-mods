
// CORNERS /////
////////////////

// Top
draw_sprite(sprWindowSliceTopCorners, 0, x, y)
draw_sprite(sprWindowSliceTopCorners, 1, x + width - 5, y)

// Bottom
var by = y + height - 6
draw_sprite(sprWindowSliceBottomCorners, 0, x, by)
draw_sprite(sprWindowSliceBottomCorners, 1, x + width - 6, by)



// EDGES ///////
////////////////

draw_sprite_ext(sprWindowSliceRightEdge, 0, x + width - 6, y + 30, 1, (height - 36) / 2, 0, c_white, 1)
draw_sprite_ext(sprWindowSliceBottom, 0, x + 6, y + height - 6, (width - 12) / 2, 1, 0, c_white, 1)

var tw = min(width - 9, 468)
var needs_double = tw != width - 9
draw_sprite_part(sprWindowSliceTop, 0, 0, 0, tw, 30, x + 4, y)
if (needs_double)
	draw_sprite_part(sprWindowSliceTop, 0, 0, 0, width - 9 - 468, 30, x + 4 + 468, y)



// MIDDLE //////
////////////////

draw_sprite_ext(sprWindowMiddle, 0, x, y + 30, (width - 6) / 16, (height - 36) / 16, 0, c_white, 1)



// NAME ////////
////////////////

draw_set_font(fntMedium)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_text_outline(x + 10, y + 18, form_title, c_dkgray, c_white)

// CLOSE ///////
////////////////
if (can_close)
	draw_sprite(sprFormClose, close_button_state, x + width - 16 - 8, y + 4)