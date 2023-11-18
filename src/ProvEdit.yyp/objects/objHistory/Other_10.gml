/// @description Undo
if (history_pos < ds_list_size(history)) {
	__action_revert(history[| history_pos])
	__net_sync_action(history[| history_pos], true)
	history_pos += 1
}