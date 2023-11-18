var b = buffer_create(10 + string_byte_length(argument0), buffer_fixed, 1)
buffer_write(b, buffer_u8, Actions.createLayer)
buffer_write(b, buffer_string, argument0)
buffer_write(b, buffer_u32, argument1)
buffer_write(b, buffer_s32, argument2)

return [b, "Created layer " + argument0]