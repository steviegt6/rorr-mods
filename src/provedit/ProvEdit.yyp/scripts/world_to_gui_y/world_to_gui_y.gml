function world_to_gui_y(argument0) {
	gml_pragma("forceinline")
	// This script will need to be updated considerably if view rotation is implementated, but for just viewing / panning it's fine
	return ((argument0 - camera_get_view_y(view_camera[0])) * display_get_gui_height() / camera_get_view_height(view_camera[0]))


}
