/// prev, state, x, y, x last, y last, erase
function ____tool_tilePencil(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	if argument0 exit
	var _size = objMain.tool_tile_pencil_size
	if (_size != 1) {
		var _low = floor((_size - 1) / 2) * 16
		argument4 -= _low
		argument5 -= _low
		if (_size % 2 == 0) {
			argument4 -= 8
			argument5 -= 8
		}
	}

	if (argument1 == 3) {
		with (instance_create_depth(0, 0, objMain.layer_choice.depth, objPencilEventHandler)) {
			x0 = argument4 >> 4
			y0 = argument5 >> 4
			erase = argument6
			size = _size
			scramble = objMain.tool_tile_pencil_randomize && !erase
		}
	}

	with (objPencilEventHandler) {
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
