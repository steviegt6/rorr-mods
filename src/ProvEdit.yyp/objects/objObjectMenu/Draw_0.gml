if (!instance_exists(parent)) {
	instance_destroy()
	exit;
}

path_clear_points(pthObjectPropertyConnector)

var par_x = (parent.bbox_left + parent.bbox_right) / 2
var par_y = (parent.bbox_top + parent.bbox_bottom) / 2

var dist = max((bbox_right - bbox_left) / 2, (bbox_bottom - bbox_top) / 2) + 8

var dir = point_direction(par_x, par_y, world_x, world_y)

var ppar_x = par_x + lengthdir_x(dist, dir)
var ppar_y = par_y + lengthdir_y(dist, dir)

var ph = height * global.view_zoom
var pw = width * global.view_zoom
var dir2 = point_direction(world_x + pw / 2, world_y + ph / 2, ppar_x, ppar_y)
var pworld_y = clamp(lengthdir_y(height, dir2) + ph / 2, world_y + 4 * global.view_zoom, world_y + ph - 4)
var pworld_x = clamp(lengthdir_y(width, dir2) + pw / 2, world_x + 4, world_x + pw - 4)
//world_y + height / 2 * global.view_zoom)

path_add_point(pthObjectPropertyConnector, par_x, par_y, 0)
path_add_point(pthObjectPropertyConnector, ppar_x, ppar_y, 0)
path_add_point(pthObjectPropertyConnector, ppar_x * 0.7 + pworld_x * 0.3, ppar_y, 0)
//path_add_point(pthObjectPropertyConnector, (par_x + world_x) / 2, par_y * 0.7 + world_y * 0.3, 0)
//path_add_point(pthObjectPropertyConnector, (par_x + world_x) / 2, (par_y + world_y) / 2, 0)
//path_add_point(pthObjectPropertyConnector, (par_x + world_x) / 2, world_y * 0.7 + par_y * 0.3, 0)
path_add_point(pthObjectPropertyConnector, pworld_x * 0.7 + ppar_x * 0.3, pworld_y + 3, 0)
path_add_point(pthObjectPropertyConnector, pworld_x, pworld_y, 0)
//path_add_point(pthObjectPropertyConnector, world_x + 3, pworld_y, 0)

draw_path(pthObjectPropertyConnector, 0, 0, true)
with (parent) {
	gpu_set_fog(1, c_white, 0, 0)
	draw_sprite(sprite_index, -1, x + 1, y)
	draw_sprite(sprite_index, -1, x - 1, y)
	draw_sprite(sprite_index, -1, x, y + 1)
	draw_sprite(sprite_index, -1, x, y - 1)
	gpu_set_fog(0, 0, 0, 0)
	draw_self()
}
