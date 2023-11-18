gml_pragma("global", "global.___objCollisionRenderer_draw_list = ds_list_create()")

if (global.disp_collision_opacity && objMain.edit_mode != EditModes.collision)
	exit

var l = global.___objCollisionRenderer_draw_list
var x1 = global.view_x - 4
var y1 = global.view_y - 4
var x2 = global.view_x + camera_get_view_width(view_camera[0]) + 4
var	y2 = global.view_y + camera_get_view_height(view_camera[0]) + 4
// Typical collisions
collision_rectangle_list(x1, y1, x2, y2, parCollisionSolid, false, false, l, false)
// HIgh priority
collision_rectangle_list(x1, y1, x2, y2, parCollisionAbove, false, false, l, false)

var length = ds_list_size(l)

var pulse
if (!global.disp_collision_opacity)
	pulse = (abs(sin(current_time / 2500)) * 0.2 + 0.3) * (objMain.edit_mode == EditModes.collision ? 0.75 : 0.3)
else
	pulse = 1

for (var i = 0; i < length; i ++) {
	with (l[| i]) {
		draw_sprite_ext(sprite_index, global.disp_collision_icons, x, y, 1, 1, 0, c_white, object_get_parent(object_index) == parCollisionAbove ? pulse + 0.2 : pulse)
	}
}

ds_list_clear(l)