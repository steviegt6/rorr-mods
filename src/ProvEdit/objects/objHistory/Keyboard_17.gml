if (!keyboard_on) exit

// UNDO
/////////////////////
if (keyboard_check_pressed(ord("Z"))) {
	event_user(0)
}

// REDO
/////////////////////
if (keyboard_check_pressed(ord("Y"))) {
	event_user(1)
}