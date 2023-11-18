

draw_set_colour(Colours.sidebar_mid)
draw_rectangle(x - 2, y - 2, x + width + 2, y + height + 2, false)
draw_set_colour(Colours.sidebar)
draw_rectangle(x, y, x + width, y + height, false)

if (ProvEdit_object_exists(objMain.object_type)) {
	var obj_sprite = global.ProvEdit_object[objMain.object_type, PROVEDIT_LEVELOBJECT.sprite]
	var spr_w = min(sprite_get_width(obj_sprite), width + 1)
	var spr_h = min(sprite_get_height(obj_sprite), height + 1)
	draw_sprite_part(obj_sprite, 0, 0, 0, spr_w, spr_h, ceil(x + width / 2 - spr_w / 2), ceil(y + height / 2 - spr_h / 2))
}
