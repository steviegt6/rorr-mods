/// @param b
var b = argument0;

var bgname = buffer_read(b, buffer_string)
var varname = buffer_read(b, buffer_string)
var undo, redo

var bgNum = ProvEdit_background_find(bgname)
var bgObj = -1
with (objBackground) {
	if (background == bgNum) {
		bgObj = id
		break
	}
}

if (bgObj != -1) {
	
	if (varname == "tile_x" || varname == "tile_y") {
		redo = buffer_read(b, buffer_u8)
		undo = buffer_read(b, buffer_u8)
	} else {
		redo = buffer_read(b, buffer_f32)
		undo = buffer_read(b, buffer_f32)
	}
	
	switch (varname) {
		case "tile_x": bgObj.tilex = argument1 ? undo : redo break
		case "tile_y": bgObj.tiley = argument1 ? undo : redo break
		case "parallax_x": bgObj.parallaxx = argument1 ? undo : redo break
		case "parallax_y": bgObj.parallaxy = argument1 ? undo : redo break
		case "offset_x": bgObj.offsetx = argument1 ? undo : redo break
		case "offset_y": bgObj.offsety = argument1 ? undo : redo break
		case "percent_x": bgObj.percentx = argument1 ? undo : redo break
		case "percent_y": bgObj.percenty = argument1 ? undo : redo break
	}
	
	with (bgObj)
		event_user(1)
}