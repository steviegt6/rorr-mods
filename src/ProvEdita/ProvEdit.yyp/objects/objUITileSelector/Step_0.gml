
event_inherited()

var ts = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.image]
var w = sprite_get_width(ts)
var h = sprite_get_height(ts)
if (parent.occupied_mouse && point_in_rectangle(mouse_ui_x, mouse_ui_y, x, y, x + w - 1, y + h - 1)) {
	if (mouse_check_button_pressed(mb_left)) {
		clicked_on = true
		click_tile_x = floor((mouse_ui_click_x - x) / 16)
		click_tile_y = floor((mouse_ui_click_y - y) / 16)
	}
}
if (mouse_check_button_released(mb_left) && clicked_on) {
	clicked_on = false
	
	var tmx = clamp(floor((mouse_ui_x - x) / 16), 0, floor(w / 16) - 1)
	var tmy = clamp(floor((mouse_ui_y - y) / 16), 0, floor(h / 16) - 1)
	var msx1 = min(click_tile_x, tmx)
	var msy1 = min(click_tile_y, tmy)
	var msx2 = max(click_tile_x, tmx) + 1
	var msy2 = max(click_tile_y, tmy) + 1
	if (msx1 == msx2) msx1 = msx2 + 1
	if (msy1 == msy2) msy1 = msy2 + 1
	
	global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.selectionInfo] = [
		msx1,
		msy1,
		msx2 - msx1,
		msy2 - msy1
	]
}