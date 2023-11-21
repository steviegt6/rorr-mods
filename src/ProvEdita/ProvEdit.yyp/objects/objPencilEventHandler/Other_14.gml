/// @description Add tile at x0, y0

var tx = x0//ceil(x0 - choice_data[2] / 2 + 0.4)
var ty = y0//ceil(y0 - choice_data[3] / 2 + 0.4)

if (!erase) {
	var choice_data = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.selectionInfo]
	var choice_x = choice_data[0]
	var choice_y = choice_data[1]
	var choice_w = choice_data[2] - 1
	var choice_h = choice_data[3] - 1
	var tw, th
	if (scramble) {
		tw = 1
		th = 1
	} else {
		tw = choice_w + 1
		th = choice_h + 1
	}
	tw += size - 1
	th += size - 1

	for (var i = 0; i < tw; i++) {
		for (var j = 0; j < th; j++) {
			var pos = coordinates_pack(tx + i, ty + j)
			if (written[? pos] == undefined) {
				var r = tile_layer_get_at(layer_id, tx + i, ty + j)
				overwritten[? pos] = r
			}
			var tile
			if (scramble) {
				if (written[? pos] != undefined)
					continue;
				tile = tile_pack(choice_x + irandom(choice_w), choice_y + irandom(choice_h))
			} else {
				tile = tile_pack(choice_x + min(i, choice_w), choice_y + min(j, choice_h))
			}
			tile_layer_set_at(layer_id, tx + i, ty + j, tile)
			written[? pos] = tile
		}
	}
} else {
	var tx2 = tx + size
	var ty2 = ty + size
	for (var ix = tx; ix < tx2; ix++) {
		for (var iy = ty; iy < ty2; iy++) {
			var pos = coordinates_pack(ix, iy)
			if (written[? pos] == undefined) {
				overwritten[? pos] = tile_layer_get_at(layer_id, ix, iy)
				tile_layer_delete_at(layer_id, ix, iy)
				written[? pos] = 0xFFFFFFFF
			}
		}
	}
}