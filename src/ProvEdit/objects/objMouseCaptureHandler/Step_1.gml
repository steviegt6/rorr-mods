if (!instance_exists(force_capture))
	force_capture = noone
var mx = mouse_ui_click_x, my = mouse_ui_click_y

var hover

if (super_force_capture != noone) {
	hover = super_force_capture
} else {
	hover = force_capture
	// With all hoverable UI bits
	// "with" statement iterates over in depth order,
	// rather than resource tree order of step events
	with (parCaptureMouse) {
		if (point_in_rectangle(mx, my, x, y, x + width - 1, y + height - 1)) {
			// Mouse is over the element
			if (hover == noone) {
				// No other element being hovered so hover this one
				hover = id
			} else if (hover.depth >= depth) {
				// Is something IS being hovered then compare depths
				hover = id
			}
		}
	}
}

if (instance_exists(last_capture)) {
	// Already captured by an element
	if (hover == noone) {
		// If uncapturing an element
		last_capture.captured = false
		mouse_state = MouseStates.ready
		last_capture = noone
	} else if (last_capture != hover) {
		// If capturing a new element
		last_capture.captured = false
		mouse_state = MouseStates.busyUI
		hover.captured = true
		last_capture = hover
	}
} else {
	if (hover != noone && mouse_free) {
		// Capture the new hovered element
		mouse_state = MouseStates.busyUI
		hover.captured = true
		last_capture = hover
	} else if (last_capture != noone) {
		// If the previous capture was destroyed without freeing
		// the mouse, free it now
		mouse_state = MouseStates.ready
		last_capture = noone
	}
}
