function layer_delete(argument0) {

	// Copy old layers to new array
	var old_tiles = global.tiles
	var j = 0
	global.tiles = []
	for (var i = 0; i < array_length_1d(old_tiles); i++) {
		var next = old_tiles[i]
		if (next != argument0) {
			global.tiles[j] = next
			next.index = j
			j++
		}
	}

	// Re-select layer
	if (objMain.layer_choice == argument0) {
		// Selected the deleted layer, default
		select_layer(global.tiles[0])
	} else {
		// Re-select to fix index
		select_layer(objMain.layer_choice)
	}

	// Delete the layer instance
	instance_destroy(argument0)



}
