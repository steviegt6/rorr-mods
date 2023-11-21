/// @function _create_level_object
/// @param x
/// @param y
/// @param type
function _create_level_object(argument0, argument1, argument2) {
	gml_pragma("forceinline")
	with (instance_create_depth(argument0, argument1, -999, objMapObject)) {
		obj_id = argument2
		sprite_index = global.ProvEdit_object[argument2, PROVEDIT_LEVELOBJECT.sprite]
		return id
	}


}
