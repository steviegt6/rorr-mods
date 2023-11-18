/// prev, state, x, y, x last, y last, erase


if argument0 exit

if (argument1 == 3) {
	if (!instance_exists(objSelectorEventHandler))
		instance_create_depth(0, 0, objMain.layer_choice.depth, objSelectorEventHandler)
	with (objSelectorEventHandler) {
		x0 = argument4 >> 4
		y0 = argument5 >> 4
	}
}


with (objSelectorEventHandler) {
	if (argument1 != 1) {
		x1 = argument4 >> 4
		y1 = argument5 >> 4
	}
	event_user(argument1)
}

exit
var u1 = argument2
var u2 = argument3