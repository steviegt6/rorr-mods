var _surf = surface_create(2048 * 4, 2048 * 4)

surface_set_target(_surf)
matrix_set(matrix_world, matrix_build(-lv_left, -lv_top, 0, 0, 0, 0, 1, 1, 1))
draw_clear_alpha(c_black, 1)
var _left = lv_left >> 4, _top = lv_top >> 4, _right = lv_right >> 4, _bottom = lv_bottom >> 4
with (objTileLayer) tile_layer_draw_region(id, _left, _top, _right, _bottom, false)
with (objMapObject) draw_self()
matrix_set(matrix_world, matrix_build_identity())
surface_reset_target()

return _surf