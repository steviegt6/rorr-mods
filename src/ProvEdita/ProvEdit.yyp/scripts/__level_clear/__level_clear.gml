function __level_clear() {
	for (var i = 0; i < array_length_1d(global.tiles); i++) {
		var l = global.tiles[i]
		instance_destroy(l)
	}
	global.tiles = []

	for (var i = 0; i < array_length_1d(global.level_backgrounds); i++) {
		var bg_inst = global.level_backgrounds[i]
		if (instance_exists(bg_inst))
			instance_destroy(bg_inst)
	}
	global.level_backgrounds = []

	with (objHistory) {
		var s = ds_list_size(history)
		for (var i = 0; i < s; i++)
			buffer_delete(history[| i])
		ds_list_clear(history)
		ds_list_clear(history_text)
	}

	with (parCollisionAll)
		instance_destroy()
	with (objMapObject)
		instance_destroy()
	
	global.layers_total = 0


}
