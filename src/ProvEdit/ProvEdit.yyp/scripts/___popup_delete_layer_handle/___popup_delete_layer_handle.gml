function ___popup_delete_layer_handle(argument0) {

	if (argument0 == "Delete") {
		action_do(Actions.deleteLayer, layer_id.index)
	}

	return true


}
