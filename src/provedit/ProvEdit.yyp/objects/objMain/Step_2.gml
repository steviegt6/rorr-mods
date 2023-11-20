/// @description 

if (mouse_x_last != mouse_x || mouse_y_last != mouse_y) {
	mouse_tip_time = 0
} else {
	mouse_tip_time += 1
}


mouse_x_last = mouse_x
mouse_y_last = mouse_y

window_set_caption("ProvEdit [" + global.level_name + "]")