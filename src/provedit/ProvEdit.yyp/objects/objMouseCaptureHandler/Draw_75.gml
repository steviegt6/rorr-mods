/// @description Debug
/*
draw_set_colour(c_white)
with (last_capture) {
	var offs = round(abs(sin(current_time / 500)) * 10)
	draw_rectangle(x - offs, y - offs, x + width + offs - 1, y + height + offs - 1, true)
}

with (parCaptureMouse) {
	draw_line(x - 5, y, x + 4, y)
	draw_line(x, y - 5, x, y + 4)
}
*/