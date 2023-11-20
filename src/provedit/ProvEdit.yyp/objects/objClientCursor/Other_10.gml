if !set exit
var size = 1
if (global.view_zoom > 1)
	size = global.view_zoom * 1.005
var _x = floor(x), _y = floor(y);
draw_set_align(fa_left, fa_center)
draw_set_font(fntConsole)
draw_set_colour(image_blend)
draw_sprite_ext(sprCursor, 0, _x, _y, size, size, 0, image_blend, 0.3)
draw_set_alpha(0.4)
if (size != 1) draw_text_transformed(_x + 16 * size, _y + 4 * size, name, size, size, 0)
else draw_text(_x + 16, _y + 4, name)

gpu_set_blendmode(bm_add)
draw_sprite_ext(sprCursor, 0, _x, _y, size, size, 0, image_blend, 0.2)
draw_set_alpha(0.3)
if (size != 1) draw_text_transformed(_x + 16 * size, _y + 4 * size, name, size, size, 0)
else draw_text(_x + 16, _y + 4, name)
gpu_set_blendmode(bm_normal)
draw_set_alpha(1)

//if (instance_exists(objClient))
//draw_text(_x, _y + 24, string(sock) + ", " + string(objClient.cursors[? sock]))