// x, y, index
var b = buffer_create(16, buffer_fixed, 1)
buffer_write(b, buffer_u8, Actions.placeMarker)

buffer_write(b, buffer_s32, floor(argument0))
buffer_write(b, buffer_s32, floor(argument1))
buffer_write(b, buffer_u16, argument2)

return [b, "Placed a marker."]