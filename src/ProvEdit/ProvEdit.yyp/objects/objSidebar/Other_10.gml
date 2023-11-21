/// @description Refresh tool icons

with (objSidebarButton)
	if (group > 100)
		instance_destroy()

if (objMain.edit_mode >= EditModes.tiles && objMain.edit_mode <= EditModes.objects) {
	var tools = global.mode_tools[objMain.edit_mode]
	for (var i = 0; i < array_length_1d(tools); i++) {
		with (instance_create_depth(0, 0, -9991, objSidebarButton)) {
			identity = tools[i]
			group = 100 + objMain.edit_mode
			top = 170
			top_offset = i * 48
			top_collapse = 48
			event_user(0)
		}
	}
}
