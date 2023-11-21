function ____action_colData_write(argument0, argument1) {
	// list of typ, x, y

	var s = ds_list_size(argument1)

	var b = buffer_create(6 + s * 5, buffer_fixed, 1)
	buffer_write(b, buffer_u8, Actions.colData)
	buffer_write(b, buffer_u32, s / 3)
	buffer_write(b, buffer_u8, argument0)

	for (var i = 0; i < s; i += 3) {
		buffer_write(b, buffer_u8, argument1[| i])               // KIND
		buffer_write(b, buffer_s16, argument1[| i + 1] / 8)          // COL X
		buffer_write(b, buffer_s16, argument1[| i + 2] / 8)          // COL Y
	}

	return [b, "Created Collision"]


}
