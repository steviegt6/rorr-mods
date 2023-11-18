/// x, y, tool data map

var tileset = objMain.layer_choice.tileset

var brush_choice = objMain.tool_tile_brush_selection - 1 //global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.brushChoice]
var brushes = global.ProvEdit_tileset[tileset, PROVEDIT_TILESET.brushes]
var brush_dat = brushes[brush_choice]
var brush = brush_dat[1]

var data = []
var count = 0

for (var i = argument0 - 1; i <= argument0 + 1; i++) {
	for (var j = argument1 - 1; j <= argument1 + 1; j++) {
		if (i != argument0 || j != argument1) {
			var ckey = tile_key_at(i, j, brush_dat[2])
			if (ckey != -1) {
				var key = __smart_brush_proc(i, j, 0, brush_dat[2])
				if (key != ckey && key != -1) {
					var p = brush[key]
					if (array_length_1d(p) == 0)
						p = brush[PROVEDIT_BRUSH.middle]
					var tile = p[irandom(array_length_1d(p) - 1)]
					if (!brush_same_tile_pool(layer_id, i, j, p)) {
						data[count] = [i, j, tile[0], tile[1]]
						count++
					}
				}
			}
		}
	}
}

return data