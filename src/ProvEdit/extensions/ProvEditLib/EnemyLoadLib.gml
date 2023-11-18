#define _____provedit_enemyloadlib_init
	// Macros
	enum PROVEDIT_ENEMY {
    	name,
    	modName,
    	objName,
    	gmobjKey
    }


	// Init globals
	global.____ProvEdit_enemy_map = ds_map_create()
	global.ProvEdit_enemy_number = 0

	return 0



#define ProvEdit_load_enemies
    // Reset data when re-loading
    ds_map_clear(global.____ProvEdit_enemy_map)
    global.ProvEdit_enemy_number = 0
    global.ProvEdit_enemy = undefined
    
    ProvEdit_load_enemies_path(global.____ProvEdit_asset_path_base + "/enemies/")
    
    
    
#define ProvEdit_load_enemies_path
    /// (path)
    for (var f = file_find_first(argument0 + "*.json", 0); f != ""; f = file_find_next()) {
    	var json = json_decode(file_read_text(argument0 + f))
    	// Skip if invalid file
    	if (!is_real(json) || !ds_exists(json, ds_type_map)) {
    		____ProvEdit_load_error("enemy", f, "Invalid JSON file")
    		continue
    	}
    	
    	// Read properties
    	var name = json[? "name"]
    	var namespace = json[? "namespace"]
    	var interface = json[? "interface"]
    	
    	// Skip if missing name or namespace
    	if (!is_string(name)) {
    		____ProvEdit_load_error("enemy", f, "Field 'name' missing or wrong type")
    		continue
    	}
    	if (!is_string(namespace)) {
    		____ProvEdit_load_error("enemy", f, "Field 'namespace' missing or wrong type")
    		continue
    	}
    	
    	// Create interface name if missing
    	if (!is_string(interface))
    		interface = namespace + ":" + name
    
    	// Add to list
    	Provedit_enemy_add(interface, namespace, name)
    }
    
    
    
#define Provedit_enemy_add
    /// (name, mod, object)
    var i = global.ProvEdit_enemy_number
    var key = argument1 + ":" + argument2
    global.ProvEdit_enemy[i, PROVEDIT_ENEMY.name] = argument0
    global.ProvEdit_enemy[i, PROVEDIT_ENEMY.modName] = argument1
    global.ProvEdit_enemy[i, PROVEDIT_ENEMY.objName] = argument2
    global.ProvEdit_enemy[i, PROVEDIT_ENEMY.gmobjKey] = key
    
    global.____ProvEdit_enemy_map[? key] = i;
    
    global.ProvEdit_enemy_number += 1
    
    
    
#define ProvEdit_enemy_exists
	gml_pragma("forceinline")
	return (argument0 >= 0 && argument0 < global.ProvEdit_enemy_number)
	
	
	
#define ProvEdit_enemy_find
	///(name)
	var val = global.____ProvEdit_enemy_map[? argument0]
	return is_undefined(val) ? -1 : val
	
	
	