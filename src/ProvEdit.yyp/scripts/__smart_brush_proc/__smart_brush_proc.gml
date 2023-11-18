/// x, y, mask, brush map
function __smart_brush_proc(argument0, argument1, argument2, argument3) {

	var n = 0;

	if (tile_key_at(argument0, argument1 - 1, argument3) >= 0)
		n += 1
	if (tile_key_at(argument0 + 1, argument1, argument3) >= 0)
		n += 2
	if (tile_key_at(argument0, argument1 + 1, argument3) >= 0)
		n += 4
	if (tile_key_at(argument0 - 1, argument1, argument3) >= 0)
		n += 8

	n |= argument2

	var key = PROVEDIT_BRUSH.middle


	switch (n) {
		case 14: key = PROVEDIT_BRUSH.top break
		case 11: key = PROVEDIT_BRUSH.bottom break
		case 13: key = PROVEDIT_BRUSH.right break
		case 7: key = PROVEDIT_BRUSH.left break
		case 6: key = PROVEDIT_BRUSH.topLeft break
		case 12: key = PROVEDIT_BRUSH.topRight break
		case 3: key = PROVEDIT_BRUSH.bottomLeft break
		case 9: key = PROVEDIT_BRUSH.bottomRight break
		case 0: key = -1 break
		case 15:
			if (tile_key_at(argument0 - 1, argument1 - 1, argument3) < 0)
				key = PROVEDIT_BRUSH.cornerTopLeft
			else if (tile_key_at(argument0 + 1, argument1 - 1, argument3) < 0)
				key = PROVEDIT_BRUSH.cornerTopRight
			else if (tile_key_at(argument0 - 1, argument1 + 1, argument3) < 0)
				key = PROVEDIT_BRUSH.cornerBottomLeft
			else if (tile_key_at(argument0 + 1, argument1 + 1, argument3) < 0)
				key = PROVEDIT_BRUSH.cornerBottomRight
			break
	
	}

	return (key)


}
