var ts = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.image]
var w = sprite_get_width(ts)
var h = sprite_get_height(ts)

draw_set_colour(Colours.sidebar_mid)
draw_rectangle(x - 3, y - 3, x + w + 2, y + h + 2, false)
draw_set_colour(Colours.sidebar)
draw_rectangle(x - 1, y - 1, x + w, y + h, false)
draw_sprite(ts, 0, x, y)

draw_sprite(sprTileRegionCorner, 0, x, y)
draw_sprite(sprTileRegionCorner, 1, x + w, y)
draw_sprite(sprTileRegionCorner, 3, x, y + h)
draw_sprite(sprTileRegionCorner, 2, x + w, y + h)

draw_set_colour(c_yellow)

var choice_info = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.selectionInfo]

var sx = x + choice_info[0] * 16
var sy = y + choice_info[1] * 16
var sw = choice_info[2] * 16
var sh = choice_info[3] * 16

draw_rectangle(sx - 1, sy - 1, sx + sw, sy + sh, true)

if (clicked_on) {
	var msx1 = grid(min(mouse_ui_click_x, mouse_ui_x) - x)
	var msy1 = grid(min(mouse_ui_click_y, mouse_ui_y) - y)
	var msx2 = grid(max(mouse_ui_click_x, mouse_ui_x) - x) + 16
	var msy2 = grid(max(mouse_ui_click_y, mouse_ui_y) - y) + 16
	if (msx1 == msx2) msx1 = msx2 + 16
	if (msy1 == msy2) msy1 = msy2 + 16
	
	draw_set_alpha(0.5)
	draw_rectangle(
		x + max(msx1, 0) - 1,
		y + max(msy1, 0) - 1,
		x + min(msx2, w ),
		y + min(msy2, h ),
		true
	)
	draw_set_alpha(1)
}
