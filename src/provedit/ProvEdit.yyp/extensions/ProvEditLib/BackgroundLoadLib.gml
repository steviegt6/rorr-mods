#define _____provedit_backgroundloadlib_init
	// Macros
	enum PROVEDIT_BACKGROUND {
    	name,
    	internalName,
    	modName,
    	resName,
    	image
    }


	// Init globals
	global.____ProvEdit_background_map = ds_map_create()
	global.ProvEdit_background_number = 0

	return 0



#define ProvEdit_load_backgrounds
    // Reset data when re-loading
    ds_map_clear(global.____ProvEdit_background_map)
    global.ProvEdit_background_number = 0
    global.ProvEdit_background = undefined
    
    ProvEdit_load_backgrounds_path(global.____ProvEdit_asset_path_base + "/backgrounds/")
    
    
    
#define ProvEdit_load_backgrounds_path
    /// (path)
	for (var f = file_find_first(argument0 + "*.json", 0); f != ""; f = file_find_next()) {
		var json = json_decode(file_read_text(argument0 + f))
		// Skip if invalid file
		if (!is_real(json) || !ds_exists(json, ds_type_map)) {
			____ProvEdit_load_error("background", f, "Invalid JSON file")
			continue
		}
		// Read properties
		var interface = json[? "interface"]
		var image = json[? "image"]
		var name = string_copy(f, 1, string_length(f) - 5)
    	var resName = json[? "name"]
    	var namespace = json[? "namespace"]
		
		// Check image missing
		if (!is_string(image)) {
			____ProvEdit_load_error("background", f, "Field 'image' missing or wrong type")
			continue
		} else if (!file_exists(argument0 + image)) {
			____ProvEdit_load_error("background", f, "The image file could not be found")
			continue
		}
		
		// Generate name if missing
		if (!is_string(interface))
			interface = name
		
    	// Skip if missing resource name or namespace
    	if (!is_string(resName)) {
    		____ProvEdit_load_error("background", f, "Field 'name' missing or wrong type")
    		continue
    	}
    	if (!is_string(namespace)) {
    		____ProvEdit_load_error("background", f, "Field 'namespace' missing or wrong type")
    		continue
    	}
    
		// Load the image
		var sprite = sprite_add(argument0 + image, 1, false, false, 0, 0)
		if (!sprite_exists(sprite)) {
			// Failed to load image, 
			____ProvEdit_load_error("background", f, "The image file failed to load")
			continue
		}
		
		ProvEdit_background_add(interface, sprite, name, resName, namespace)
	}
    
    
    
#define ProvEdit_background_add
    /// (name, sprite, internalName, mod, sprName)
	var i = global.ProvEdit_background_number
	
	global.ProvEdit_background[i, PROVEDIT_BACKGROUND.name] = argument0
	global.ProvEdit_background[i, PROVEDIT_BACKGROUND.internalName] = argument2
	global.ProvEdit_background[i, PROVEDIT_BACKGROUND.image] = argument1
	global.ProvEdit_background[i, PROVEDIT_BACKGROUND.resName] = argument3
	global.ProvEdit_background[i, PROVEDIT_BACKGROUND.modName] = argument4
	global.____ProvEdit_background_map[? argument2] = i
	
	global.ProvEdit_background_number += 1
	
	return i
    
    
    
#define ProvEdit_background_exists
	gml_pragma("forceinline")
	return (argument0 >= 0 && argument0 < global.ProvEdit_background_number)
	
	
	
#define ProvEdit_background_find
	///(name)
	var val = global.____ProvEdit_background_map[? argument0]
	return is_undefined(val) ? -1 : val
	
	
	