/// @function show_popup
/// @param name string
/// @param width number
/// @param height number
/// @param format array
/// @param handler id
function show_popup(argument0, argument1, argument2, argument3, argument4) {

	with (instance_create_depth(0, 0, -9999, objParseFormat)) {
		form_title = argument0
		width = argument1 + 2
		format_width = argument1
		height = argument2 + 32
		format_height = argument2
		format = argument3
		handle_button = argument4
		return id
	}


}
