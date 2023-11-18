///@function __action_execute(buffer, [offset])
///@param buffer id
///@param offset ?number

var offset = 0
if (argument_count > 1)
	offset = argument[1]
buffer_seek(argument[0], buffer_seek_start, offset)
var scr = global.__action_out[buffer_read(argument[0], buffer_u8)]
// Argument is undo flag
script_execute(scr, argument[0], false)