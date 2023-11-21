/// @description Update render settings

#macro ui_left 0
#macro ui_top 16
#macro ui_right global.__ui_right
#macro ui_bottom global.__ui_bottom
#macro ui_bottom_raw global.__ui_bottom_raw
#macro ui_hmid round(global.__ui_right / 2)
#macro ui_vmid round(global.__ui_bottom / 2)

ui_right = display_get_gui_width()
ui_bottom = floor(display_get_gui_height() - objConsole.height)
ui_bottom_raw = display_get_gui_height()

cursor_visible = point_in_rectangle(
	display_mouse_get_x() - window_get_x(),
	display_mouse_get_y() - window_get_y(),
	0, 0, window_get_width(), window_get_height()
)