function ___popup_edit_layer_handle(argument0, argument1) {

	if (argument0 == "Done") {
		var _name = data[? "name"]
		var _tileset = data[? "tileset"]
		var _depth = real_int(data[? "depth"])
		// Get tileset ID
		for (var i = 0; i < global.ProvEdit_tileset_number; i++) {
			if (global.ProvEdit_tileset[i, PROVEDIT_TILESET.name] == _tileset) {
				_tileset = i
				break
			}
		}
		// Check for name collisions
		for (var i = 0; i < array_length_1d(global.tiles); i++) {
			if (global.tiles[i].name == _name && global.tiles[i] != layer_id) {
				// Name collision 
				show_popup("Edit Layer", 180, 80, [
					[_format_colour, c_black],
					[_format_text, "A layer with that name already exists."],
					[_format_colour, c_white],
					[_format_button, "Continue"]
				], scr_true)
				return true
			}
		}
		if (layer_id == -1) {
			action_do(Actions.createLayer, _name, _tileset, _depth)
			select_layer(global.tiles[array_length_1d(global.tiles) - 1])
		}
	
		return true
	} else if (layer_id != -1 && argument1 == SP_EVENT.contentChanged) {
		switch (argument0) {
			case ("name"):
				// Submit
				var _name = data[? "name"]
				if (layer_id.name != _name)
					action_do(Actions.updateLayer, layer_id.index, 0, _name)
				break
			case ("tileset"):
				var _tileset = data[? "tileset"]
				// Get tileset ID
				for (var i = 0; i < global.ProvEdit_tileset_number; i++) {
					if (global.ProvEdit_tileset[i, PROVEDIT_TILESET.name] == _tileset) {
						_tileset = i
						break
					}
				}
				// Submit
				if (layer_id.tileset != _tileset)
					action_do(Actions.updateLayer, layer_id.index, 1, _tileset)
				break
			case ("depth"):
				// Submit
				var _depth = real_int(data[? "depth"])
				if (layer_id.depth != _depth)
					action_do(Actions.updateLayer, layer_id.index, 2, _depth)
				break
		}
	}

	return false


}
