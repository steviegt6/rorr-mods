/// @description Click start


var choice_data = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.selectionInfo]

var tx = x0 - ceil(size / 2) + 1
var ty = y0 - ceil(size / 2) + 1

var tileset = objMain.layer_choice.tileset

var brush_choice = objMain.tool_tile_brush_selection - 1 //global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.brushChoice]
var brushes = global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.brushes]
var brush_dat = brushes[brush_choice]
var brush = brush_dat[1]
var tiles = brush[PROVEDIT_BRUSH.middle]

for (var i = 0; i < size; i++) {
	for (var j = 0; j < size; j++) {
		var tile = tiles[irandom(array_length_1d(tiles) - 1)]
		//__tile_layer_set_tile(layer_id, tx, ty, tile[0], tile[1])
		if (!brush_same_tile_pool(layer_id, tx, ty, tiles))
			brush_set_tile(layer_id, tx, ty, tile[0], tile[1])
		ty ++
	}
	tx ++
	ty -= size
}

event_user(5)
