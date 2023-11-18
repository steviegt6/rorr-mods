function __level_load_buffer(argument0) {

	var dat = ProvEdit_level_read(argument0)

	if (dat[1] != undefined) {
	    // Parse error
	    return dat[1]
	} else {
	    // Parse success
	    dat = dat[0]
	}

	// Basic settings
	global.level_name = dat[PROVEDIT_LEVEL_FILE.name]
	global.level_subname = dat[PROVEDIT_LEVEL_FILE.subname]
	global.level_music = dat[PROVEDIT_LEVEL_FILE.musicID]
	global.level_map_objects = dat[PROVEDIT_LEVEL_FILE.interactableIDs]
	global.level_enemies = dat[PROVEDIT_LEVEL_FILE.enemyIDs]
	lv_left = dat[PROVEDIT_LEVEL_FILE.boundsLeft]
	lv_right = dat[PROVEDIT_LEVEL_FILE.boundsRight]
	lv_top = dat[PROVEDIT_LEVEL_FILE.boundsTop]
	lv_bottom = dat[PROVEDIT_LEVEL_FILE.boundsBottom]

	// Layers
	var _layers = dat[PROVEDIT_LEVEL_FILE.layers]
	for (var i = 0; i < array_length_1d(_layers); i++) {
	    var _layer = _layers[i]
		var _layer_inst = layer_add(_layer[PROVEDIT_LEVEL_FILE_LAYER.name],
			_layer[PROVEDIT_LEVEL_FILE_LAYER.tilesetID], _layer[PROVEDIT_LEVEL_FILE_LAYER.depth])
		var _index =_layer_inst.index
	
		var _pos_x = _layer[PROVEDIT_LEVEL_FILE_LAYER.posXList]
		var _pos_y = _layer[PROVEDIT_LEVEL_FILE_LAYER.posYList]
		var _tile_x = _layer[PROVEDIT_LEVEL_FILE_LAYER.tileXList]
		var _tile_y = _layer[PROVEDIT_LEVEL_FILE_LAYER.tileYList]
	
		var _count = _layer[PROVEDIT_LEVEL_FILE_LAYER.count]
	
		for (var j = 0; j < _count; j++) {
			tile_layer_set_at(_index, _pos_x[j], _pos_y[j], tile_pack(_tile_x[j], _tile_y[j]))
		}
	}

	select_layer(global.tiles[0])

	// Objects
	var _objs = dat[PROVEDIT_LEVEL_FILE.objects]
	for (var i = 0; i < array_length_1d(_objs); i++) {
		var _obj = _objs[i]
		var _obj_inst = _create_level_object(_obj[PROVEDIT_LEVEL_FILE_OBJECT.posX],
											 _obj[PROVEDIT_LEVEL_FILE_OBJECT.posY],
											 _obj[PROVEDIT_LEVEL_FILE_OBJECT.objectID])
		_obj_inst.variables = _obj[PROVEDIT_LEVEL_FILE_OBJECT.variableMap]
	}

	// Collision
	var _cols = dat[PROVEDIT_LEVEL_FILE.collision]
	for (var i = 0; i < array_length_1d(_cols); i++) {
		var _col = _cols[i]
		var _kind  = _col[PROVEDIT_LEVEL_FILE_COLLISION.collisionIndex]
		var _count = _col[PROVEDIT_LEVEL_FILE_COLLISION.count]
		var _col_x = _col[PROVEDIT_LEVEL_FILE_COLLISION.posXList]
		var _col_y = _col[PROVEDIT_LEVEL_FILE_COLLISION.posYList]
		var _obj = global.collision_types[_kind, CollisionType.object]
		for (var j = 0; j < _count; j++) {
			instance_create_depth(_col_x[j], _col_y[j], -99, _obj)
		}
	}

	// Backgrounds
	var _bgs = dat[PROVEDIT_LEVEL_FILE.backgrounds]
	global.level_backgrounds = array_create(array_length_1d(_bgs))
	for (var i = 0; i < array_length_1d(_bgs); i++) {
	    var _bg = _bgs[i]
	    with (instance_create_depth(0, 0, _bg[PROVEDIT_LEVEL_FILE_BG.depth], objBackground)) {
			background = _bg[PROVEDIT_LEVEL_FILE_BG.backgroundID]
			tilex = _bg[PROVEDIT_LEVEL_FILE_BG.tiledX]
			tiley = _bg[PROVEDIT_LEVEL_FILE_BG.tiledY]
			parallaxx = _bg[PROVEDIT_LEVEL_FILE_BG.parallaxX]
			parallaxy = _bg[PROVEDIT_LEVEL_FILE_BG.parallaxY]
			offsetx = _bg[PROVEDIT_LEVEL_FILE_BG.offsetX]
			offsety = _bg[PROVEDIT_LEVEL_FILE_BG.offsetY]
			percentx = _bg[PROVEDIT_LEVEL_FILE_BG.offsetPercentX]
			percenty = _bg[PROVEDIT_LEVEL_FILE_BG.offsetPercentY]
	        global.level_backgrounds[i] = id
			event_user(0)
	    }
	}

	return ""


}
