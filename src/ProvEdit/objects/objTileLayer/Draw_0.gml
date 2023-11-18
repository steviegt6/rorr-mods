
var x1 = global.view_x >> 4
var y1 = global.view_y >> 4
var x2 = (global.view_x + camera_get_view_width(view_camera[0]) + 16) >> 4
var y2 = (global.view_y + camera_get_view_height(view_camera[0]) + 16) >> 4

tile_layer_draw_region(id, x1, y1, x2, y2, global.disp_layer_opacity ? (id != objMain.layer_choice) : false)