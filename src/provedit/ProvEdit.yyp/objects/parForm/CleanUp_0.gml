if (requires_action) {
	objMain.control_on = true
	keyboard_on = true
	if (objMouseCaptureHandler.force_capture == id)
		objMouseCaptureHandler.force_capture = noone
}
