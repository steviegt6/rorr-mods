/// @function var_ref(instance, name)
/// @param instance id
/// @param name string
function var_ref(argument0, argument1) {

	gml_pragma("forceinline")
	return [argument0.id, argument1]


}
