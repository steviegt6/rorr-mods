///@description do_action(action, ...)
///@argument action
///@argument ...
function action_do() {

	with (objHistory) {
		if (history_pos > 0) {
			repeat (history_pos) {
				ds_list_delete(history, 0)
			}
			history_pos = 0
		}
	
		if (ds_list_size(history) > history_max - 1) {
			var size = ds_list_size(history)
			do {
				size -= 1
				ds_list_delete(history, size)
			}
			until (size <= history_max)
		}
	}

	var scr = global.__action_in[argument[0]]
	var out

	switch (argument_count - 1) {
		case 0:
			out = script_execute(scr)
			break
		case 1:
			out = script_execute(scr, argument[1])
			break
		case 2:
			out = script_execute(scr, argument[1], argument[2])
			break
		case 3:
			out = script_execute(scr, argument[1], argument[2], argument[3])
			break
		case 4:
			out = script_execute(scr, argument[1], argument[2], argument[3], argument[4])
			break
		case 5:
			out = script_execute(scr, argument[1], argument[2], argument[3], argument[4], argument[5])
			break
		case 6:
			out = script_execute(scr, argument[1], argument[2], argument[3], argument[4], argument[5], argument[6])
			break
		case 7:
			out = script_execute(scr, argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7])
			break
		case 8:
			out = script_execute(scr, argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8])
			break
		default:
			show_error("Too many arguments to action call", true)
	}

	ds_list_insert(objHistory.history, 0, out[0])
	ds_list_insert(objHistory.history_text, 0, out[1])

	__action_execute(out[0])
	__net_sync_action(out[0], false)



}
