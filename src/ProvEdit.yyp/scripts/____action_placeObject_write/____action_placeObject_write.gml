function ____action_placeObject_write(argument0, argument1, argument2, argument3, argument4) {
	// x, y, index, vars
	var extra = 0
	if (argument3)
		extra = buffer_vars_size(argument4, false)
	var b = buffer_create(14 + extra, buffer_fixed, 1)
	buffer_write(b, buffer_u8, Actions.placeObject)

	buffer_write(b, buffer_u8, argument3) // delete
	//buffer_write(b, buffer_u16, 1) // count
	buffer_write(b, buffer_s32, argument0) // x
	buffer_write(b, buffer_s32, argument1) // y
	buffer_write(b, buffer_u16, argument2) // kind

	if (argument3)
		buffer_vars_write(b, argument4, false)

	return [b, argument2 ? "Removed an object." : "Placed an object."]


}
