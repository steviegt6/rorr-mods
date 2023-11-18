if !instance_exists(parent) {
	instance_destroy()
	exit
}

var count = array_length_1d(format)

if (!surface_exists(surface))
	surface = surface_create(width, max(height, 400))

if (count == 0) {
	format = [[_format_colour, c_white]]
	var varList = global.ProvEdit_object[parent.obj_id, PROVEDIT_LEVELOBJECT.variables]
	var i = 0
	for (var j = 0; j < ds_list_size(varList); j += 1) {
		var varListList = varList[| j]
		
		var varName = varListList[PROVEDIT_LEVELOBJECT_VAR.name]
		var varVariableName = varListList[PROVEDIT_LEVELOBJECT_VAR.variableName]
		var varType = varListList[PROVEDIT_LEVELOBJECT_VAR.type]
		var varDefaultValue = varListList[PROVEDIT_LEVELOBJECT_VAR.defaultValue]
		var varRange = varListList[PROVEDIT_LEVELOBJECT_VAR.range]
		
		// setup default values if they're not setup yet
		if is_undefined(parent.variables[? varVariableName])
			parent.variables[? varVariableName] = varDefaultValue
		
		format[++i] = [_format_left, -48]
		format[++i] = [_format_text, varName, fntMedium, fa_left]
		format[++i] = [_format_right]
		i += 1 
		switch (varType) {
			case "int":
				var rangeList = undefined
				if (ds_list_size(varRange))
					rangeList = [varRange[| 0], varRange[| 1]]
				format[i] = [
					_format_input_number,
					varVariableName,
					parent.variables[? varVariableName],
					rangeList,
					1,
					25
				]
			break
			case "string":
				if (!ds_list_size(varRange)) {
					format[i] = [
						_format_input_text,
						varVariableName,
						parent.variables[? varVariableName],
						false,
						25
					]
				} else {
					var rangeArray = []
					var k = 0
					repeat (ds_list_size(varRange)) {
						rangeArray[k] = ds_list_find_value(varRange, k)
						k += 1
					}
					format[i] = [
						_format_dropdown,
						varVariableName,
						parent.variables[? varVariableName],
						rangeArray,
						25
					]
				}
			break
			default: // default is bool
				format[i] = [
					_format_checkbox,
					varVariableName,
					parent.variables[? varVariableName]
				]
			break
		}
	}
	format[++i] = [_format_right]
	format[++i] = [_format_button, "Done"]
	format[++i] = [_format_left]
	format[++i] = [_format_colour, merge_colour(c_red, c_white, 0.5)]
	format[++i] = [_format_button, "Remove Object"]
}

draw_set_colour(move_bar ? Colours.blue : (hover_bar ? Colours.sidebar_light : Colours.sidebar))
draw_rectangle(x, y, x + form_width, y + 12, false)
draw_set_colour(Colours.sidebar_dark)
draw_rectangle(x, y + 12, x + form_width, y + form_height, false)
draw_set_colour(c_white)
draw_set_align(fa_left, fa_bottom)
draw_set_font(fntSmallSquare)
draw_text(x + 2, y + 11, "Object Settings")

var tclick = state[? _SP.choice]
if (!mouse_check_button(mb_left))
	state[? _SP.choice] = ""


matrix_set(matrix_world, matrix_build(-x, -y, 0, 0, 0, 0, 1, 1, 1))

state[? _SP.x] = x + width / 2
state[? _SP.y] = y + 16
state[? _SP.xInitial] = x + width / 2
state[? _SP.width] = width
state[? _SP.height] = height
state[? _SP.widthInitial] = width
state[? _SP.heightInitial] = height
state[? _SP.columnStart] = -1
state[? _SP.hasMouse] = captured

surface_set_target(surface)
draw_clear_alpha(0, 0)

for (var i = 0; i < count; i++) {
	var f = format[i]
	var args = array_length_1d(f)
	switch (args) {
		case 1: script_execute(f[0], state) break
		case 2: script_execute(f[0], state, f[1]) break
		case 3: script_execute(f[0], state, f[1], f[2]) break
		case 4: script_execute(f[0], state, f[1], f[2], f[3]) break
		case 5: script_execute(f[0], state, f[1], f[2], f[3], f[4]) break
		case 6: script_execute(f[0], state, f[1], f[2], f[3], f[4], f[5]) break
		default: show_error("Too many format args!", true)
	}
}

surface_reset_target()

matrix_set(matrix_world, matrix_build_identity())

draw_surface_part(surface, 0, 0, width, height, x, y)

//if (mouse_check_button_released(mb_left) && tclick != "" && tclick == state[? _SP.choice])
//	if (script_execute(handle_button, tclick))
//		instance_destroy()


if (mouse_check_button_released(mb_left) && tclick != "" && tclick == state[? _SP.choice]) {
	state[? _SP._clicked] = tclick
	if (script_execute(handle_button, tclick, SP_EVENT.clicked)) {
		instance_destroy()
		exit
	}
} else {
	state[? _SP._clicked] = ""
}
		
state[? _SP.typingLast] = state[? _SP.typing]

// Resize visible region


if (state[? _SP.y] - y > height) {
	height = min(height + 32, state[? _SP.y] - y)
	if (height > surface_get_height(surface))
		surface_resize(surface, width, height + 200)
	form_height = height
}