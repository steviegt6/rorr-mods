/// prev, state, x, y, x last, y last, erase
function ____tool_colPencil(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {


	if argument0 exit

	if (argument1 == 3) {
		with (instance_create_depth(0, 0, objMain.layer_choice.depth, objHighlighterEventHandler)) {
			x0 = argument4 >> 4
			y0 = argument5 >> 4
			erase = argument6
			type = objMain.collision_type
		}
	}

	with (objHighlighterEventHandler) {
		if (argument1 != 1) {
			x1 = argument4 >> 4
			y1 = argument5 >> 4
		}
		event_user(argument1)
	}

	// Because gamemaker is fucking stupid
	exit
	var u1 = argument2
	var u2 = argument3


}
