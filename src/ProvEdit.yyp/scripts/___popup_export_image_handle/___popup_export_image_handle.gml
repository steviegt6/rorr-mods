function ___popup_export_image_handle(argument0, argument1) {

	if (argument0 == "Export" || argument0 == "Cancel") {
	
		return true
	} else if (argument1 == SP_EVENT.contentChanged) {
		switch (argument0) {
			case 0: break
		}
	}

	return false


}
