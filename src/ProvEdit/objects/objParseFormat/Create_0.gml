event_inherited()

center = true
requires_action = true
objConsole.disabled += 1

format = []

format_width = 250
format_height = 300
form_title = "Confirm Action"
width = format_width
height = format_height

handle_button = ___format_handle_button_default

enum _SP {
	x,
	y,
	width,
	height,
	columnStart,
	widthInitial,
	heightInitial,
	xInitial,
	hasMouse,
	choice,
	hover,
	typing,
	typingLast,
	backdropColour,
	_owner,
	_clicked
}

enum SP_EVENT {
	clicked,
	contentChanged,
}

state = ds_map_create()
state[? _SP.widthInitial] = width
state[? _SP.heightInitial] = height
state[? _SP.choice] = ""
state[? _SP.typing] = ""
state[? _SP.typingLast] = ""
state[? _SP._owner] = id

data = ds_map_create()

