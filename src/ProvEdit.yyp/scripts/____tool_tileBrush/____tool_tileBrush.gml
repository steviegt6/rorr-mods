/// prev, state, x, y, x last, y last
function ____tool_tileBrush(argument0, argument1, argument2, argument3, argument4, argument5) {


	if argument0 exit
	if (array_length_1d(global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.brushes]) == 0) exit

	var offs = floor((objMain.tool_tile_brush_size - 0.5) / 2)
	argument4 = (argument4 - offs) >> 4
	argument5 = (argument5 - offs) >> 4

	if (argument1 == 3) {
		with (instance_create_depth(0, 0, objMain.layer_choice.depth, objBrushEventHandler)) {
			x0 = argument4
			y0 = argument5
		}
	}

	with (objBrushEventHandler) {
		if (argument1 != 1) {
			x1 = argument4
			y1 = argument5
		}
		event_user(argument1)
	}

	// Because gamemaker is fucking stupid
	exit
	var u1 = argument2
	var u2 = argument3


}
