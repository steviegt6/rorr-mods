/// prev, state, x, y, x last, y last, erase
function ____tool_objectPlacer() {


	if argument[0] exit
	if !ProvEdit_object_exists(objMain.object_type) exit

	if (argument[1] == 3) {
		var xx, yy;
		xx = ((argument[2]) >> 3) << 3
		yy = ((argument[3] + 8) >> 3) << 3
	
		if (argument[6]) {
			var tinst = collision_point(argument[2], argument[3], objMapObject, 1, 0)
			if (tinst == noone) {
				with (objMapObject) {
					if (x == xx && y == yy) {
						tinst = id;
						break;
					}
				}
			}
			if (tinst != noone)
				action_do(Actions.placeObject, tinst.x, tinst.y, tinst.obj_id, true, tinst.variables)
		} else {
			with (objMapObject) {
				if (x == xx && y == yy)
					exit
			}
			action_do(Actions.placeObject, xx, yy, objMain.object_type, false)
		}
	}


}
