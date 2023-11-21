#define _____provedit_interactableloadlib_init
	// Macros
	enum PROVEDIT_INTERACTABLE {
    	name,
    	modName,
    	objName,
    	gmobjKey
    }


	// Init globals
	global.____ProvEdit_interactable_map = ds_map_create()
	global.ProvEdit_interactable_number = 0

	return 0



#define ProvEdit_load_interactables
    // Reset data when re-loading
    ds_map_clear(global.____ProvEdit_interactable_map)
    global.ProvEdit_interactable_number = 0
    global.ProvEdit_interactable = undefined
    
    ProvEdit_load_interactables_path(global.____ProvEdit_asset_path_base + "/interactables/")
    
    
    
#define ProvEdit_load_interactables_path
    /// (path)
    for (var f = file_find_first(argument0 + "*.json", 0); f != ""; f = file_find_next()) {
    	var json = json_decode(file_read_text(argument0 + f))
    	// Skip if invalid file
    	if (!is_real(json) || !ds_exists(json, ds_type_map)) {
    		____ProvEdit_load_error("interactable", f, "Invalid JSON file")
    		continue
    	}
    	
    	// Read properties
    	var name = json[? "name"]
    	var namespace = json[? "namespace"]
    	var interface = json[? "interface"]
    	
    	// Skip if missing name or namespace
    	if (!is_string(name)) {
    		____ProvEdit_load_error("interactable", f, "Field 'name' missing or wrong type")
    		continue
    	}
    	if (!is_string(namespace)) {
    		____ProvEdit_load_error("interactable", f, "Field 'namespace' missing or wrong type")
    		continue
    	}
    	
    	// Create interface name if missing
    	if (!is_string(interface))
    		interface = namespace + ":" + name
    
    	// Add to list
    	Provedit_interactable_add(interface, namespace, name)
    }
    
    
    
#define Provedit_interactable_add
    /// (name, mod, object)
    var i = global.ProvEdit_interactable_number
    var key = argument1 + ":" + argument2
    global.ProvEdit_interactable[i, PROVEDIT_INTERACTABLE.name] = argument0
    global.ProvEdit_interactable[i, PROVEDIT_INTERACTABLE.modName] = argument1
    global.ProvEdit_interactable[i, PROVEDIT_INTERACTABLE.objName] = argument2
    global.ProvEdit_interactable[i, PROVEDIT_INTERACTABLE.gmobjKey] = key
    
    global.____ProvEdit_interactable_map[? key] = i;
    
    global.ProvEdit_interactable_number += 1
    
    
    
#define ProvEdit_interactable_exists
	gml_pragma("forceinline")
	return (argument0 >= 0 && argument0 < global.ProvEdit_interactable_number)
	
	
	
#define ProvEdit_interactable_find
	///(name)
	var val = global.____ProvEdit_interactable_map[? argument0]
	return is_undefined(val) ? -1 : val
	
	
	