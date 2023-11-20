#define _____provedit_tilesetloadlib_init
	// Macros
	enum PROVEDIT_TILESET {
		name,
		internalName,
		image,
		selectionInfo,
    	modName,
    	resName,
    	hasGrid, // Used for exporting
		brushes,
		brushChoice // Extra field only used by editor
	}
	
	enum PROVEDIT_BRUSH {
		middle,
		left, right,
		top, bottom,
		topLeft, topRight,
		bottomLeft, bottomRight,
		cornerTopLeft, cornerTopRight,
		cornerBottomLeft, cornerBottomRight,
	}

	// Map of brush key name -> index
	var m = ds_map_create()
	m[? "middle"] = PROVEDIT_BRUSH.middle
	m[? "left"] = PROVEDIT_BRUSH.left
	m[? "right"] = PROVEDIT_BRUSH.right
	m[? "top"] = PROVEDIT_BRUSH.top
	m[? "bottom"] = PROVEDIT_BRUSH.bottom
	m[? "topLeft"] = PROVEDIT_BRUSH.topLeft
	m[? "topRight"] = PROVEDIT_BRUSH.topRight
	m[? "bottomLeft"] = PROVEDIT_BRUSH.bottomLeft
	m[? "bottomRight"] = PROVEDIT_BRUSH.bottomRight
	m[? "cornerTopLeft"] = PROVEDIT_BRUSH.cornerTopLeft
	m[? "cornerTopRight"] = PROVEDIT_BRUSH.cornerTopRight
	m[? "cornerBottomLeft"] = PROVEDIT_BRUSH.cornerBottomLeft
	m[? "cornerBottomRight"] = PROVEDIT_BRUSH.cornerBottomRight
	global.____ProvEdit_brush_key_map = m

	// Init globals
	global.____ProvEdit_tileset_map = ds_map_create()
	global.ProvEdit_tileset_array = []
	global.ProvEdit_tileset_number = 0

	return 0



#define ProvEdit_load_tilesets
	///load_tilesets()
	// Reset data when re-loading
	ds_map_clear(global.____ProvEdit_tileset_map)
	global.ProvEdit_tileset = undefined
	global.ProvEdit_tileset_array = []
	global.ProvEdit_tileset_number = 0

	ProvEdit_load_tilesets_path(global.____ProvEdit_asset_path_base + "/tilesets/")



#define ProvEdit_load_tilesets_path
	/// load_tilesets_path(path)
	// Load all tilesets from a folder
	var empty_brush_keys = ds_list_create()

	for (var f = file_find_first(argument0 + "*.json", 0); f != ""; f = file_find_next()) {
		var json = json_decode(file_read_text(argument0 + f))
		// Skip if invalid file
		if (!is_real(json) || !ds_exists(json, ds_type_map)) {
			____ProvEdit_load_error("tileset", f, "Invalid JSON file")
			continue
		}
		
		// Read properties
		var interface = json[? "interface"]
		var image = json[? "image"]
		var name = string_copy(f, 1, string_length(f) - 5)
    	var resName = json[? "name"]
    	var namespace = json[? "namespace"]
    	var hasGrid = json[? "grid"]
		
		// Default hasGrid to false
		if (hasGrid != true)
			hasGrid = false
		
		// Skip if missing image
		if (!is_string(image)) {
			____ProvEdit_load_error("tileset", f, "Field 'image' missing or wrong type")
			continue
		} else if (!file_exists(argument0 + image)) {
			____ProvEdit_load_error("tileset", f, "The image file could not be found")
			continue
		}
		
    	// Skip if missing name or namespace
    	if (!is_string(resName)) {
    		____ProvEdit_load_error("tileset", f, "Field 'resName' missing or wrong type")
    		continue
    	}
    	if (!is_string(namespace)) {
    		____ProvEdit_load_error("tileset", f, "Field 'namespace' missing or wrong type")
    		continue
    	}
    	
		// Generate name if missing
		if (!is_string(interface))
			interface = name
		
		// Load the image
		var sprite = sprite_add(argument0 + image, 1, false, false, 0, 0)
		if (!sprite_exists(sprite)) {
			// Failed to load image, 
			____ProvEdit_load_error("tileset", f, "The image file failed to load")
			continue
		}
		
		var tileset_id = ProvEdit_tileset_add(interface, sprite, name, resName, namespace, hasGrid)
		
		////// Load brushes //////////////////////
		var brushes = json[? "brushes"]
		
		// Skip brush loading if brushes aren't present
		if (!is_real(brushes) || !ds_exists(brushes, ds_type_list))
			continue
		
		for (var i = 0; i < ds_list_size(brushes); i++) {
			var brush = brushes[| i]
			// Make sure the brush is an object
			if (!is_real(brush) || !ds_exists(brush, ds_type_list)) {
				____ProvEdit_load_error("brush", "unknown", "Bad value in brush list, expected a list of objects")
				continue
			}
			
			// Read properties
			var bname = brush[? "name"]
			
			// Skip if missing name
			if (!is_string(bname)) {
				____ProvEdit_load_error("brush", "unknown", "Field 'name' missing or wrong type")
				continue
			}
			
			//// Read data to arrays ////////////////////
			var data = []
			
			// Make sure the middle is defined
			data[PROVEDIT_BRUSH.middle] = [[0, 0]]
			
			var failed = false
			for (var key = ds_map_find_first(global.____ProvEdit_brush_key_map); key != undefined; key = ds_map_find_next(global.____ProvEdit_brush_key_map, key)) {
				var index = global.____ProvEdit_brush_key_map[? key]
				var next = brush[? key]
				
				// If there's nothing defined, skip reading
				if (next == undefined) {
					ds_list_add(empty_brush_keys, index)
					continue
				}
				
				// Make sure it's a list
				if (!is_real(next) || !ds_exists(next, ds_type_list)) {
					____ProvEdit_load_error("brush", bname, "Bad value for key " + key + ", expecting an array")
					failed = true
					break
				}
				
				var nsize = ds_list_size(next)
				
				// Make sure it's not empty
				if (nsize == 0) {
					ds_list_add(empty_brush_keys, index)
					continue
				}
				
				var idat = []
				
				// Loop over it
				for (var t = 0; t < nsize; t++) {
					var tile = next[| t]
					// Make sure the sub element is a list
					if (!is_real(tile) || !ds_exists(tile, ds_type_list)) {
						____ProvEdit_load_error("brush", bname, "Bad value inside of list for key " + key + ", expecting a 2 element array")
						failed = true
						break
					}
					// Verify size
					if (ds_list_size(tile) != 2) {
						____ProvEdit_load_error("brush", bname, "Incorrect length for tile data inside of list for key " + key)
						failed = true
						break
					}
					// Verify sub sub elements
					if (!is_real(tile[| 0])) {
						____ProvEdit_load_error("brush", bname, "Incorrect type for first index of tile data inside of list for key " + key)
						failed = true
						break
					}
					if (!is_real(tile[| 1])) {
						____ProvEdit_load_error("brush", bname, "Incorrect type for second index of tile data inside of list for key " + key)
						failed = true
						break
					}
					// Add to tiles
					idat[array_length_1d(idat)] = [tile[| 0], tile[| 1]]
				}
				// Failed inside inner loop
				if (failed)
					break
				
				data[index] = idat
			}
			
			// Something went wrong, skip adding the brush
			if (failed) {
				ds_list_clear(empty_brush_keys)
				continue
			}
			
			// Default missing keys to the middle
			for (var t = 0; t < ds_list_size(empty_brush_keys); t++)
				data[empty_brush_keys[| t]] = data[PROVEDIT_BRUSH.middle]
			ds_list_clear(empty_brush_keys)
			
			// Add the brush
			ProvEdit_brush_add(tileset_id, bname, data)
		}
		
	}

	ds_list_destroy(empty_brush_keys)



#define ProvEdit_tileset_add
	///tileset_add(name, image, internalName, resName, modName, hasGrid)
	// Sets up a new tileset slot with the provided properties
	var i = global.ProvEdit_tileset_number

	global.ProvEdit_tileset[i, PROVEDIT_TILESET.name] = argument0
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.internalName] = argument2
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.image] = argument1
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.selectionInfo] = [0, 0, 1, 1]
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.brushes] = []
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.brushChoice] = 0
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.resName] = argument3
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.modName] = argument4
	global.ProvEdit_tileset[i, PROVEDIT_TILESET.hasGrid] = argument5
	global.____ProvEdit_tileset_map[? argument2] = i
	global.ProvEdit_tileset_array[i] = argument0

	global.ProvEdit_tileset_number += 1

	return i



#define ProvEdit_brush_add
	///brush_add(tileset, name, data)
	var brushes = global.ProvEdit_tileset[argument0, PROVEDIT_TILESET.brushes]

	var map = ds_map_create()
	for (var i = 0; i < array_length_1d(argument2); i++) {
		var tarr = argument2[i]
		for (var j = 0; j < array_length_1d(tarr); j++) {
			var tarr2 = tarr[j]
			for (var k = 0; k < array_length_1d(tarr2); k++) {
				var tarr3 = tarr2[k]
				// Store the brush key
				map[? string(tarr2[0]) + ", " + string(tarr2[1])] = i
			}
		}
	}

	brushes[@ array_length_1d(brushes)] = [argument1, argument2, map]



#define ProvEdit_tileset_find
	///tileset_find(name)
	var val = global.____ProvEdit_tileset_map[? argument0]
	return is_undefined(val) ? -1 : val



#define ProvEdit_tileset_exists
	gml_pragma("forceinline")
	return (argument0 >= 0 && argument0 < global.ProvEdit_tileset_number)


