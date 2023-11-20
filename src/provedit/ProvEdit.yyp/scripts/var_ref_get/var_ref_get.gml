/// @function var_ref_get(ref)
/// @param ref var_ref
function var_ref_get(argument0) {

	gml_pragma("forceinline")

	if (instance_exists(argument0[0])) {
		return variable_instance_get(argument0[0], argument0[1])
	} else {
		return undefined
	}



}
