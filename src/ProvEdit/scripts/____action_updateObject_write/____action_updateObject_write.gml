// x, y, kind, [variables]

	
var b = buffer_create(1 + 4 + 4 + 2 + 2 + buffer_vars_size(argument3, true), buffer_fixed, 1)
buffer_write(b, buffer_u8, Actions.updateObject)
buffer_write(b, buffer_s32, argument0) // x
buffer_write(b, buffer_s32, argument1) // y
buffer_write(b, buffer_u16, argument2) // kind

buffer_vars_write(b, argument3, true)

return [b, "Changed variables of object type " + string(argument2)/* + " at x=" + string(argument0) + ", y=" + string(argument1)*/]//"Modified layer '" + global.tiles[argument0] + "'"]