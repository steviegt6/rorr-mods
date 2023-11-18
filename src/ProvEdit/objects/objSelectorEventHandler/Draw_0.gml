var tx0 = min(x0, x1) * 16
var tx1 = max(x0, x1) * 16
var ty0 = min(y0, y1) * 16
var ty1 = max(y0, y1) * 16

gpu_set_blendmode(bm_add)
draw_set_alpha(abs(sin(current_time / 900) * 0.1))
draw_set_colour(merge_colour(c_aqua, c_white, 0.5))
draw_rectangle(tx0, ty0, tx1 + 15, ty1 + 15, false)
gpu_set_blendmode(bm_normal)
draw_set_alpha(1)
draw_rectangle_zoom(tx0, ty0, tx1 + 16, ty1 + 16, 2)
