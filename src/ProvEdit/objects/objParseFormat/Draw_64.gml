if (center) {
	x = ui_hmid - width / 2
	y = (ui_bottom_raw - ui_top) / 2 - height / 2
}


event_inherited()

var count = array_length_1d(format)

var tclick = state[? _SP.choice]
if (!mouse_check_button(mb_left))
	state[? _SP.choice] = ""

state[? _SP.x] = x + format_width / 2
state[? _SP.y] = y + 32
state[? _SP.xInitial] = x + format_width / 2
state[? _SP.width] = format_width
state[? _SP.height] = format_height
state[? _SP.widthInitial] = format_width
state[? _SP.heightInitial] = format_height
state[? _SP.columnStart] = -1
state[? _SP.hasMouse] = captured

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
	
