/// @description Insert description here
// You can write your code in this editor

layer_x(my_layer, camera_get_view_x(view_camera[0]) * parallaxx + offsetx + (camera_get_view_width(view_camera[0]) - 48 * global.view_zoom) * percentx)
layer_y(my_layer, (camera_get_view_y(view_camera[0]) + 16 * global.view_zoom) * parallaxy + offsety + (camera_get_view_height(view_camera[0]) - 16 * global.view_zoom) * percenty)