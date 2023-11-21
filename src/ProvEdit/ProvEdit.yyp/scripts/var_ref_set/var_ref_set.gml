/// @function var_ref_set(ref, value)
/// @param ref var_ref
/// @param value any
function var_ref_set(argument0, argument1) {

	gml_pragma("forceinline")
	if (instance_exists(argument0[0])) {
		variable_instance_set(argument0[0], argument0[1], argument1)
		return true
	} else {
		return false
	}



}
