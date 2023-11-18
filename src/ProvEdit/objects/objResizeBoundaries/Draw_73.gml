var size = 1
if (global.view_zoom > 1)
	size = global.view_zoom * 1.005

draw_set_colour(c_black)
draw_set_alpha(0.5)
var cam = view_camera[0]
var cam_x = camera_get_view_x(cam)
var cam_y = camera_get_view_y(cam)
draw_rectangle(cam_x, cam_y, cam_x + camera_get_view_width(cam), cam_y + camera_get_view_height(cam), false)
draw_set_alpha(1)

draw_set_colour(c_yellow)
draw_rectangle_zoom(left, top, right, bottom, 2)

for (var i = 0; i < 8; i += 2) {
	var index = floor(i / 2) + 1
	var subimage = 0
	if (clicked == index) {
		subimage = 2
	} else if (hover == index) {
		subimage = 1
	}
	draw_sprite_ext(sprLevelResizeHandle, subimage, handles[i], handles[i + 1], size, size, (index <= 2) * 90, c_white, 1)
}