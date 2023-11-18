///@description __action_init(key, name)
///@argument key
///@argument name
///@argument size
///@argument args
function __action_init(argument0, argument1) {

	global.__action_name[argument0] = argument1

	var in = asset_get_index("____action_" + argument1 + "_write")
	var out = asset_get_index("____action_" + argument1 + "_read")

	// Just in case I make a typo
	if (is_undefined(in) || is_undefined(out)) 
		show_error("Unable to find script for action " + argument1, true)


	global.__action_in[argument0] = in
	global.__action_out[argument0] = out


}
