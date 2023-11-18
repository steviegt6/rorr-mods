gml_pragma("forceinline")
// This script will need to be updated considerably if view rotation is implementated, but for just viewing / panning it's fine
return ((argument0 - camera_get_view_x(view_camera[0])) * display_get_gui_width() / camera_get_view_width(view_camera[0]))