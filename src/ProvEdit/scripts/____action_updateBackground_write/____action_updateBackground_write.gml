var b = buffer_create(16, buffer_grow, 1)
buffer_write(b, buffer_u8, Actions.updateBackground)
buffer_write(b, buffer_string, argument0) // background name
buffer_write(b, buffer_string, argument1) // variable

var bgNum = ProvEdit_background_find(argument0)
var bgObj = -1
with (objBackground) {
	if (background == bgNum) {
		bgObj = id
		break
	}
}

if (bgObj != -1) {
	var typ = buffer_f32
	if (argument1 == "tile_x" || argument1 == "tile_y")
		typ = buffer_u8
	var oldval = 0
	switch (argument1) {
		case "tile_x": oldval = bgObj.tilex break
		case "tile_y": oldval = bgObj.tiley break
		case "parallax_x": oldval = bgObj.parallaxx break
		case "parallax_y": oldval = bgObj.parallaxy break
		case "offset_x": oldval = bgObj.offsetx break
		case "offset_y": oldval = bgObj.offsety break
		case "percent_x": oldval = bgObj.percentx break
		case "percent_y": oldval = bgObj.percenty break
	}
	buffer_write(b, typ, argument2)		// value
	buffer_write(b, typ, oldval)		// old value
	return [b, "Changed background " + string(argument0) + "'s " + argument1 + " to " + string(argument2)]
}