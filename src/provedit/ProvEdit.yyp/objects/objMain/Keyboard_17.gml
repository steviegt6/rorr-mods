if (!keyboard_on) exit

// SAVE
/////////////////////
if (keyboard_check_pressed(ord("S"))) {
	__level_save(keyboard_check(vk_shift))
}

// LOAD
/////////////////////
if (keyboard_check_pressed(ord("O")) && !net_client()) {
	__level_load()
}

// EXPORT
/////////////////////
if (keyboard_check_pressed(ord("E"))) {
	__level_export()
}

// GRID
/////////////////////
if (keyboard_check_pressed(ord("G"))) {
	global.disp_grid_on = !global.disp_grid_on
}

// OPACITY
/////////////////////
if (keyboard_check_pressed(ord("H"))) {
	global.disp_layer_opacity = !global.disp_layer_opacity
}


// COLLISION OPACITY
/////////////////////
if (keyboard_check_pressed(ord("J"))) {
	global.disp_collision_opacity = !global.disp_collision_opacity
}
