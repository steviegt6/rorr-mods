function ___popup_disconnect_handle(argument0, argument1) {
	if (argument1 == SP_EVENT.clicked) {
		switch (argument0) {
			case "Disconnect":
				with (objServer) instance_destroy()
				with (objClient) instance_destroy()
				with (objClientCursor) instance_destroy()
			case "Cancel":
				return true
		}
	}

	return false


}
