
#define _____provedit_levelformatlib_init
    #macro PROVEDIT_FORMAT_STRING "rorlvl"
    #macro PROVEDIT_FORMAT_VERSION "0.1.1"
    
    // Level structs
    enum PROVEDIT_LEVEL_FILE {
        // Basic level info
        name,
        subname,
        musicID,
        // Bounds
        boundsLeft,
        boundsTop,
        boundsRight,
        boundsBottom,
        // Spawns
        enemyIDs,
        interactableIDs,
        // Array of PROVEDIT_LEVEL_FILE_LAYER
        layers,
        // Array of PROVEDIT_LEVEL_FILE_BG
        backgrounds,
        // Array of PROVEDIT_LEVEL_FILE_OBJECT
        objects,
        // Array of PROVEDIT_LEVEL_FILE_COLLISION
        collision,
        //
        SIZE
    }
    enum PROVEDIT_LEVEL_FILE_LAYER {
    	name,
        tilesetID,
        depth,
        count,
        posXList,
        posYList,
        tileXList,
        tileYList,
        SIZE
    }
    enum PROVEDIT_LEVEL_FILE_BG {
        backgroundID, // String
        depth, // Int
        tiledX, // Bool
        tiledY, // Bool
        offsetX, // Int
        offsetY, // Int
        offsetPercentX, // 0 - 1
        offsetPercentY, // 0 - 1
        parallaxX, // 0 - 1
        parallaxY, // 0 - 1
        SIZE
    }
    enum PROVEDIT_LEVEL_FILE_OBJECT {
        objectID,
        posX,
        posY,
        variableMap,
        SIZE
    }
    enum PROVEDIT_LEVEL_FILE_COLLISION {
        collisionIndex,
        count,
        posXList,
        posYList,
        SIZE
    }
    enum PROVEDIT_LEVEL_FEATURE {
        // Whether BG offsetPercentX and offsetPercentY fields are loaded
        bg_percentOffset,
        SIZE
    }
    
    // Map of known level format versions
    var _m = ds_map_create()
	_m[? "0.1.0"] = true
	_m[? "0.1.1"] = true
    global.__ProvEdit_level_format_known = _m
    
#define ProvEdit_semver_get_level_features
    /// (semver or string i guess)
    // returns an array (indexed by PROVEDIT_LEVEL_FEATURE) listing features available in the level format
    
    var ver = is_array(argument0) ? argument0 : ProvEdit_semver_parse(argument0)
    var features = array_create(PROVEDIT_LEVEL_FEATURE.SIZE, false)
    
    features[PROVEDIT_LEVEL_FEATURE.bg_percentOffset]
        = ProvEdit_semver_compare(ver, /**/0,1,1/**/)
        
    return features

#define ProvEdit_level_read_buffer_background
    /// (buffer, features)
    // Returns [PROVEDIT_LEVEL_FILE_BG, error]
    var b = argument0, _features = argument1
    var bg = array_create(PROVEDIT_LEVEL_FILE_BG.SIZE)
    
    var _name = buffer_read(b, buffer_string)
    var _id = ProvEdit_background_find(_name)
    if (_id < 0) return [bg, "failed to resolve background '" + _name + "'"]
    
	bg[PROVEDIT_LEVEL_FILE_BG.backgroundID] = _id
	bg[PROVEDIT_LEVEL_FILE_BG.depth] = buffer_read(b, buffer_s32)
	bg[PROVEDIT_LEVEL_FILE_BG.tiledX] = buffer_read(b, buffer_u8)
	bg[PROVEDIT_LEVEL_FILE_BG.tiledY] = buffer_read(b, buffer_u8)
	bg[PROVEDIT_LEVEL_FILE_BG.parallaxX] = buffer_read(b, buffer_f32)
	bg[PROVEDIT_LEVEL_FILE_BG.parallaxY] = buffer_read(b, buffer_f32)
	bg[PROVEDIT_LEVEL_FILE_BG.offsetY] = buffer_read(b, buffer_f32)
	bg[PROVEDIT_LEVEL_FILE_BG.offsetX] = buffer_read(b, buffer_f32)
	if (_features[PROVEDIT_LEVEL_FEATURE.bg_percentOffset]) {
		bg[PROVEDIT_LEVEL_FILE_BG.offsetPercentX] = buffer_read(b, buffer_f32)
		bg[PROVEDIT_LEVEL_FILE_BG.offsetPercentY] = buffer_read(b, buffer_f32)
	}
    
    return [bg, undefined]

#define ProvEdit_level_read_buffer_object
    /// (buffer, features)
    // Returns [PROVEDIT_LEVEL_FILE_OBJECT, error]
    var b = argument0, _features = argument1
    var obj = array_create(PROVEDIT_LEVEL_FILE_OBJECT.SIZE)
	
	var _name = buffer_read(b, buffer_string)
	var _id = ProvEdit_object_find(_name)
	if (_id < 0) return [obj, "failed to resolve object '" + _name + "'"]
    
    obj[PROVEDIT_LEVEL_FILE_OBJECT.objectID] = _id
    obj[PROVEDIT_LEVEL_FILE_OBJECT.posX] = buffer_read(b, buffer_s16) << 3
    obj[PROVEDIT_LEVEL_FILE_OBJECT.posY] = buffer_read(b, buffer_s16) << 3
    
    //var unused = buffer_read(b, buffer_u8)
    var _variable_count = buffer_read(b, buffer_u8)
    var _variable_map = ds_map_create()
    for (var i = 0; i < _variable_count; i++) {
        var var_key = buffer_read(b, buffer_string)
        var var_type = buffer_read(b, buffer_bool)
        var var_val = buffer_read(b, var_type ? buffer_string : buffer_s32)
        _variable_map[? var_key] = var_val
    }
    obj[PROVEDIT_LEVEL_FILE_OBJECT.variableMap] = _variable_map
    
    return [obj, undefined]

#define ProvEdit_level_read_buffer_collision
    /// (buffer, features)
    // Returns [PROVEDIT_LEVEL_FILE_COLLISION, error]
    var b = argument0, _features = argument1
    var col = array_create(PROVEDIT_LEVEL_FILE_COLLISION.SIZE)
    
	var _type = buffer_read(b, buffer_u8)
	var _count = buffer_read(b, buffer_u32)
	// Hardcoded limits wee
	if (_type < 0 || _type > 6) return [col, "invalid collision type index " + string(_type)]
	
    var _xList = array_create(_count)
    var _yList = array_create(_count)
    for (var i = 0; i < _count; i++) {
        _xList[i] = buffer_read(b, buffer_s16) << 3
        _yList[i] = buffer_read(b, buffer_s16) << 3
    }
    
    col[PROVEDIT_LEVEL_FILE_COLLISION.collisionIndex] = _type
    col[PROVEDIT_LEVEL_FILE_COLLISION.count] = _count
    col[PROVEDIT_LEVEL_FILE_COLLISION.posXList] = _xList
    col[PROVEDIT_LEVEL_FILE_COLLISION.posYList] = _yList
    
    return [col, undefined]

#define ProvEdit_level_read_buffer_layer
    /// (buffer, features)
    // Returns [PROVEDIT_LEVEL_FILE_LAYER, error]
    var b = argument0, _features = argument1
    var lay = array_create(PROVEDIT_LEVEL_FILE_LAYER.SIZE)
    
	var _name = buffer_read(b, buffer_string)
	var _tileset_name = buffer_read(b, buffer_string)
	var _depth = buffer_read(b, buffer_s16)

	var _tileset = ProvEdit_tileset_find(_tileset_name)
	if (_tileset < 0) return [lay, "failed to resolve tileset '" + _tileset_name + "'"]
	
	var l_count_tile = buffer_read(b, buffer_u32)
	
    var _tiles_x = array_create(l_count_tile)
    var _tiles_y = array_create(l_count_tile)
    var _tiles_xt = array_create(l_count_tile)
    var _tiles_yt = array_create(l_count_tile)
    
	for (var i = 0; i < l_count_tile; i++) {
		_tiles_xt[i] = buffer_read(b, buffer_u8)
		_tiles_yt[i] = buffer_read(b, buffer_u8)
		_tiles_x[i] = buffer_read(b, buffer_s16)
		_tiles_y[i] = buffer_read(b, buffer_s16)
	}
	
	lay[PROVEDIT_LEVEL_FILE_LAYER.count] = l_count_tile
	lay[PROVEDIT_LEVEL_FILE_LAYER.name] = _name
	lay[PROVEDIT_LEVEL_FILE_LAYER.depth] = _depth
	lay[PROVEDIT_LEVEL_FILE_LAYER.tilesetID] = _tileset
	
	lay[PROVEDIT_LEVEL_FILE_LAYER.posXList] = _tiles_x
	lay[PROVEDIT_LEVEL_FILE_LAYER.posYList] = _tiles_y
	lay[PROVEDIT_LEVEL_FILE_LAYER.tileXList] = _tiles_xt
	lay[PROVEDIT_LEVEL_FILE_LAYER.tileYList] = _tiles_yt
	
	return [lay, undefined]

#define ProvEdit_level_read
    /// (buffer)
    // returns [PROVEDIT_LEVEL_FILE, error string]

    var b = argument0
    var _ver, _features

    var _level = array_create(PROVEDIT_LEVEL_FILE.SIZE)

    // FILE FORMAT HEADER {
        // Check the file format
    	var magic_string = ""
    	repeat(6)
    		magic_string += chr(buffer_read(b, buffer_u8))
    	if (magic_string != "rorlvl")
    		return [_level, "incorrect file type"]
    	// Dummy bytes
    	repeat (7)
    		buffer_read(b, buffer_u8)
    	// Check format version
    	var format_string = ""
    	repeat(5)
    		format_string += chr(buffer_read(b, buffer_u8))
    	if (is_undefined(global.__ProvEdit_level_format_known[? format_string]))
    		return [_level, "unknown file format version"]
    	_ver = ProvEdit_semver_parse(format_string)
    	_features = ProvEdit_semver_get_level_features(_ver)
    // }
    
    // LEVEL HEADER {
    	// Name and subname
    	_level[PROVEDIT_LEVEL_FILE.name] = buffer_read(b, buffer_string)
    	_level[PROVEDIT_LEVEL_FILE.subname] = buffer_read(b, buffer_string)
    	// Map top left (useless lo)
    	repeat (2) buffer_read(b, buffer_s16)
    	// Map bounds
    	_level[PROVEDIT_LEVEL_FILE.boundsLeft] = buffer_read(b, buffer_s16) * 16
    	_level[PROVEDIT_LEVEL_FILE.boundsTop] = buffer_read(b, buffer_s16) * 16
    	_level[PROVEDIT_LEVEL_FILE.boundsRight] = buffer_read(b, buffer_s16) * 16
    	_level[PROVEDIT_LEVEL_FILE.boundsBottom] = buffer_read(b, buffer_s16) * 16
    	// Layer number
    	var layer_number = buffer_read(b, buffer_u16)
    	// Collision type number
    	var collision_number = buffer_read(b, buffer_u8)
    	// Level object number
    	var object_number = buffer_read(b, buffer_u16)
    	// MUSIC {
        	var music_filename = buffer_read(b, buffer_string)
        	var music_index = ProvEdit_music_find(music_filename)
        	if (music_index == undefined) music_index = 0 // Default to first ID
        	_level[PROVEDIT_LEVEL_FILE.musicID] = music_index
    	// }
    	// Background, map objects, and enemy numbers
    	var background_number = buffer_read(b, buffer_u8)
    	var mapobject_spawn_number = buffer_read(b, buffer_u8)
    	var enemy_spawn_number = buffer_read(b, buffer_u8)
    // }
    
   // Tiles {
    	var _layers = array_create(layer_number, undefined)
    	for (var i = 0; i < layer_number; i++) {
            var _layer = ProvEdit_level_read_buffer_layer(b, _features)
            if (_layer[1] != undefined) return [_level, _layer[1]]
            _layers[i] = _layer[0]
    	}
    	_level[PROVEDIT_LEVEL_FILE.layers] = _layers
    // }
    
    // Collision {
        var _cols = array_create(collision_number, undefined)
        for (var i = 0; i < collision_number; i++) {
            var _col = ProvEdit_level_read_buffer_collision(b, _features)
            if (_col[1] != undefined) return [_level, _col[1]]
            _cols[i] = _col[0]
        }
    	_level[PROVEDIT_LEVEL_FILE.collision] = _cols
    // }
    
    // Objects {
        var _objs = array_create(object_number, undefined)
        for (var i = 0; i < object_number; i++) {
            var _obj = ProvEdit_level_read_buffer_object(b, _features)
            if (_obj[1] != undefined) return [_level, _obj[1]]
            _objs[i] = _obj[0]
        }
    	_level[PROVEDIT_LEVEL_FILE.objects] = _objs
    // }
    
    // Backgrounds {
        var _bgs = array_create(background_number, undefined)
        for (var i = 0; i < background_number; i++) {
            var _bg = ProvEdit_level_read_buffer_background(b, _features)
            if (_bg[1] != undefined) return [_level, _bg[1]]
            _bgs[i] = _bg[0]
        }
        _level[PROVEDIT_LEVEL_FILE.backgrounds] = _bgs
    // }

    // Interactables {
        var _interactables = array_create(mapobject_spawn_number)
        for (var i = 0; i < mapobject_spawn_number; i++) {
    		var mapobj_name = buffer_read(b, buffer_string)
    		var mapobj_index = ProvEdit_interactable_find(mapobj_name)
    		if (mapobj_index < 0)
    		    return [_level, "failed to resolve interactable '" + mapobj_name + "'"]
            _interactables[i] = mapobj_index
        }
        _level[PROVEDIT_LEVEL_FILE.interactableIDs] = _interactables
    // }
    
    // Enemies {
        var _enemies = array_create(enemy_spawn_number)
        for (var i = 0; i < enemy_spawn_number; i++) {
    		var enemy_name = buffer_read(b, buffer_string)
    		var enemy_index = ProvEdit_enemy_find(enemy_name)
    		if (enemy_index < 0)
    		    return [_level, "failed to resolve enemy '" + enemy_name + "'"]
            _enemies[i] = enemy_index
        }
        _level[PROVEDIT_LEVEL_FILE.enemyIDs] = _enemies
    // }

    return [_level, undefined]

#define ProvEdit_semver_parse
	/// (string)
	// returns the string split into an array of 3 elements by .
	
	var str = argument0
	var values = []
	while (true) {
		var pos = string_pos(".", str)
		if (pos >= 1) {
			values[array_length_1d(values)] = string_copy(str, 1, pos - 1)
			str = string_copy(str, pos + 1, string_length(str))
		} else {
			values[array_length_1d(values)] = str
			break
		}
	}
	
	var ret = [0, 0, 0]
	for (var i = 0; i < array_length_1d(values); i++) {
		ret[i] = real_int(values[i])
	}
	
	return ret

#define ProvEdit_semver_compare
    /// (semver, major, [minor, patch])
    // if only major is provided then it is assumed to be semver array
    // otherwise uses the 3 separate params as the version

    var cmp = argument[0]
    var major, minor, patch
    if (argument_count > 2) {
        major = argument[1]
        minor = argument[2]
        patch = argument[3]
    } else {
        var ver = argument[1]
        major = ver[0]
        minor = ver[1]
        patch = ver[2]
    }

    if (cmp[0] > major) {
    	return true
    } else if (cmp[0] == major) {
    	if (cmp[1] > minor) {
    		return true
    	} else if (cmp[1] == minor) {
    		return cmp[2] >= patch
    	} else return false
    } else return false