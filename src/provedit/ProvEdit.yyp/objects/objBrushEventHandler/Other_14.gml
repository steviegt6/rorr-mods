/// @description Add tile at x0, y0
var choice_data = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.selectionInfo]

var tx = x0
var ty = y0

var tileset = objMain.layer_choice.tileset

var brush_choice = objMain.tool_tile_brush_selection - 1 //global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.brushChoice]
var brushes = global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.brushes]
var brush_dat = brushes[brush_choice]
var brush = brush_dat[1]

var key = __smart_brush_proc(tx, ty, 0, brush_dat[2])
if (key == -1)
	key = PROVEDIT_BRUSH.middle
//if (tile_key_at(tx, ty, brush_dat[2], space_covered) == key)
//	exit
var p = brush[key]
if (array_length_1d(p) == 0)
	p = brush[PROVEDIT_BRUSH.middle]
var tile = p[irandom(array_length_1d(p) - 1)]

var t_dat = [tx, ty, tile[0], tile[1]]
//__tile_layer_set_tile(layer_id, t_dat[0], t_dat[1], t_dat[2], t_dat[3])
if (!brush_same_tile_pool(layer_id, t_dat[0], t_dat[1], p))
	brush_set_tile(layer_id, t_dat[0], t_dat[1], t_dat[2], t_dat[3])

var tdat = smart_brush_use(tx, ty)
for (var k = 0; k < array_length_1d(tdat); k++) {
	var tile = tdat[k]
	//__tile_layer_set_tile(layer_id, tile[0], tile[1], tile[2], tile[3])
	brush_set_tile(layer_id, tile[0], tile[1], tile[2], tile[3])
	/*var str_key = string(tile[0]) + ", " + string(tile[1])
	if (is_undefined(space_covered[? str_key])) {
		// Add tile
		data[count] = tile;
		space_covered[? str_key] = [count, data[count]]
		count++
	} else {
		// Overwrite tile
		var e = space_covered[? str_key]
		data[e[0]] = tile;
	}*/
}
