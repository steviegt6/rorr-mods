#define _____provedit_musicloadlib_init
	// Macros
	enum PROVEDIT_MUSIC {
		name,
		internalName,
		file
	}

	// Init globals
	global.____ProvEdit_music_map = ds_map_create()
	global.ProvEdit_music_array = []
	global.ProvEdit_music_number = 0

	return 0
	
	
	
#define ProvEdit_load_music
	// Reset data when re-loading
	ds_map_clear(global.____ProvEdit_music_map)
	global.ProvEdit_music = undefined
	
	global.ProvEdit_music_number = 1
    global.ProvEdit_music[0, PROVEDIT_MUSIC.name] = "Silence"
    global.ProvEdit_music[0, PROVEDIT_MUSIC.internalName] = ":nothing:" 
    global.ProvEdit_music[0, PROVEDIT_MUSIC.file] = ""
    global.ProvEdit_music_array[0] = "Silence"
    global.____ProvEdit_music_map[? ":nothing:"] = 0

	ProvEdit_load_music_path(global.____ProvEdit_asset_path_base + "/music/")


#define ProvEdit_load_music_path
    /// (path)
    
    var name_prefix = ""
    if (string_pos(global.____ProvEdit_asset_path_base, argument0) < 1)
        name_prefix = "custom_"
    // Load JSON of music names
    var jsonpath = argument0 + "/music.json"
    var json = -1
    if (file_exists(jsonpath)) {
    	json = json_decode(file_read_text(jsonpath))
    	if (!is_real(json) || !ds_exists(json, ds_type_map)) {
    	    script_execute(global.____ProvEdit_error_handler_id, "Failed to load music.json: Invalid JSON file")
		}
    }

    // Load music from folder
    for (var f = file_find_first(argument0 + "/*.ogg", 0); f != ""; f = file_find_next()) {
    	var name = f
    	// Get name from JSON if present
    	if (!is_undefined(json[? f]))
    		name = json[? f]
    	global.ProvEdit_music[global.ProvEdit_music_number, PROVEDIT_MUSIC.name] = name
    	global.ProvEdit_music[global.ProvEdit_music_number, PROVEDIT_MUSIC.internalName] = f
    	global.ProvEdit_music_number += 1
    }
    
    // Add loaded music to other structures
    for (var i = 0; i < global.ProvEdit_music_number; i++) {
    	var name = global.ProvEdit_music[i, PROVEDIT_MUSIC.name]
    	global.ProvEdit_music_array[i] = name
    	global.____ProvEdit_music_map[? global.ProvEdit_music[i, PROVEDIT_MUSIC.internalName]] = i
    }
    
    // Destroy temp JSON map
    if (json != -1)
        ds_map_destroy(json)



#define ProvEdit_music_find
	///(name)
	var val = global.____ProvEdit_music_map[? argument0]
	return is_undefined(val) ? -1 : val



#define ProvEdit_music_exists
	gml_pragma("forceinline")
	return (argument0 >= 0 && argument0 < global.ProvEdit_music_number)


