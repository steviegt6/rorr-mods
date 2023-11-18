sprite_index = -1

#macro LV_LEFT_MIN -4812
#macro LV_RIGHT_MAX 4812
#macro LV_TOP_MIN -4800
#macro LV_BOTTOM_MAX 4800
#macro LV_WIDTH_MIN 640
#macro LV_HEIGHT_MIN 480
#macro LV_WIDTH_DEFAULT 1920
#macro LV_HEIGHT_DEFAULT 1056

instance_create_depth(0, 0, -9999, objConsole)

window_set_min_width(660)
window_set_min_height(630)

ProvEdit_error_handler(_lib_error_handler)

__init_prefs()

global.net_buff = buffer_create(1, buffer_grow, 1)

global.marker = []
global.tiles = []
global.view = view_get_camera(0)
global.view_x = 0
global.view_y = 0
global.view_zoom = 1

global.ui_scale = 1

window_was_resized = false

#macro keyboard_on global.__keyboard_on
keyboard_on = true

#macro mouse_state global.__mouse_state
#macro mouse_free (global.__mouse_state == MouseStates.ready)
enum MouseStates {
	ready,
	busyUI,
	busyDrawing,
	busyPanning,
	busyErasing,
	busyLevel,
	typing
	
}
mouse_state = MouseStates.ready

ui_right = 0
ui_bottom = 0
window_width = window_get_width()
window_height = window_get_height()
#macro mouse_ui_x global.__mouse_ui_x
#macro mouse_ui_y global.__mouse_ui_y
#macro mouse_ui_click_x global.__mouse_ui_click_x
#macro mouse_ui_click_y global.__mouse_ui_click_y
#macro mouse_x_last global.__mouse_x_last
#macro mouse_y_last global.__mouse_y_last

mouse_x_last = mouse_x
mouse_y_last = mouse_y
mouse_ui_x = 0
mouse_ui_y = 0
mouse_ui_click_x = mouse_ui_x
mouse_ui_click_y = mouse_ui_y

#macro lv_left global.__lv_left
#macro lv_right global.__lv_right
#macro lv_top global.__lv_top
#macro lv_bottom global.__lv_bottom
lv_left = -LV_WIDTH_MIN / 2
lv_top = -LV_WIDTH_MIN / 2
lv_right = LV_HEIGHT_MIN / 2
lv_bottom = LV_HEIGHT_MIN / 2

ProvEdit_load_default_assets("resources/")

control_on = true

hover = noone
disable_mouse = false


cursor_index = 0
enum CursorIndex {
	normal,
	eraser,
	dropper,
	move
}

edit_mode = EditModes.tiles
tile_tool = Tools.tilePencil
object_tool = Tools.objectPlacer
collision_tool = Tools.collisionEditor
collision_type = 0
object_type = -1
tool = tile_tool

cursor_visible = true
// Used to stop mouse text from flashing for 1 frame when mouse capture changes
mouse_ready_cd = 0

__level_init()
//current_layer = 0
//layer_choice = global.tiles[0]

layer_force_draw_depth(true, 0)


instance_create_depth(0, 0, -99, objCollisionRenderer)

instance_create_depth(0, 0, -9990, objMouseCaptureHandler)

instance_create_depth(0, 0, -9999, objHistory)
instance_create_depth(0, 0, -9999, objTopBar)
instance_create_depth(0, 0, -9990, objUICore)
instance_create_depth(0, 0, -9990, objSidebar)


instance_create_depth(0, 0, -9999, objLogo)

tool_tile_brush_size = 5
tool_tile_brush_selection = 1
tool_tile_pencil_size = 1
tool_tile_pencil_randomize = false

was_using_tool = 0

mouse_tip = ""
mouse_tip_time = 0