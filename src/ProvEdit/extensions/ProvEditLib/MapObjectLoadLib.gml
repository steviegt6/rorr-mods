#define _____provedit_mapobjectloadlib_init
	// Macros
	enum PROVEDIT_LEVELOBJECT {
		name,
		sprite,
		modName,
		objName,
		gmobjKey,
		variables
	}
	enum PROVEDIT_LEVELOBJECT_VAR {
		name,
		variableName,
		type,
		defaultValue,
		range
	}

	// Init globals
	global.____ProvEdit_object_map = ds_map_create()
	global.ProvEdit_object_number = 0

	return 0



#define ProvEdit_load_objects
	// Reset data when re-loading
	ds_map_clear(global.____ProvEdit_object_map)
	global.ProvEdit_object = undefined
	global.ProvEdit_object_number = 0

	ProvEdit_load_objects_path(global.____ProvEdit_asset_path_base + "/objects/")



#define ProvEdit_load_objects_path
	/// load_objects_path(path)
	// Load all level objects from a folder
	for (var f = file_find_first(argument0 + "*.json", 0); f != ""; f = file_find_next()) {
		var json = json_decode(file_read_text(argument0 + f))
		// Skip if invalid file
		if (!is_real(json) || !ds_exists(json, ds_type_map)) {
			____ProvEdit_load_error("object", f, "Invalid JSON file")
			continue
		}
		
		// Read properties
		var name = json[? "name"]
		var namespace = json[? "namespace"]
		var interface = json[? "interface"]
		var sprite = json[? "sprite"]
		var xorigin = json[? "xorigin"]
		var yorigin = json[? "yorigin"]
		var variables = json[? "variables"]
		
		// Skip if missing name or namespace
		if (!is_string(name)) {
			____ProvEdit_load_error("object", f, "Field 'name' missing or wrong type")
			continue
		}
		if (!is_string(namespace)) {
			____ProvEdit_load_error("object", f, "Field 'namespace' missing or wrong type")
			continue
		}
		
		// Create interface name if missing
		if (!is_string(interface))
			interface = namespace + ":" + name
		
		// Verify type of x/y origin overrides
		if (!is_real(xorigin))
			xorigin = undefined
		if (!is_real(yorigin))
			yorigin = undefined
		
		// Get sprite image
		var sprite_img
		if (!is_string(sprite) || !file_exists(argument0 + sprite)) {
			sprite_img = sprMapObject
		} else {
			var sprite_img = sprite_add(argument0 + sprite, 1, false, false, 0, 0)
			if (sprite_exists(sprite_img)) {
				if (is_undefined(xorigin))
					xorigin = sprite_get_width(sprite_img) / 2
				if (is_undefined(yorigin))
					yorigin = sprite_get_height(sprite_img)
				sprite_set_offset(sprite_img, xorigin, yorigin)
			} else {
				sprite_img = sprMapObject
			}
		}
		
		// Parse variable details, or create an empty list if it doesn't exist
		var variableList = ds_list_create()
		if (!is_undefined(variables) && ds_exists(variables, ds_type_list)) {
			for (var i = 0; i < ds_list_size(variables); i += 1) {
				
				var varMap = ds_list_find_value(variables, i)
				// Check if it's a map
				if (is_undefined(variables) || !ds_exists(varMap, ds_type_map)) {
					____ProvEdit_load_error("object", f, "Variable " + string(i+1) + " is not a valid variable")
					continue
				}
				
				var varName = varMap[? "name"]
				var varVariableName = varMap[? "variableName"]
				var varType = varMap[? "type"]
				var varDefaultValue = varMap[? "default"]
				var varRange = varMap[? "range"]
				
				// Skip if missing variable name or type
				if (!is_string(varVariableName)) {
					____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'name' missing or wrong type")
					continue
				}
				if (!is_string(varType)) {
					____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'type' missing or wrong type")
					continue
				}
				
				// Check if type is a valid type
				if (varType != "int" && varType != "string" && varType != "bool") {
					____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'type' is not a valid type")
					continue
				}
				
				// If name is missing, make it the same as the variable name
				if (!is_string(varName))
					varName = varVariableName
				
				// If default value is missing, set it based on the type
				if (!is_string(varDefaultValue) && !is_real(varDefaultValue) && !is_bool(varDefaultValue)) {
					switch (varType) {
						case "int": varDefaultValue = 0
						break
						case "string": varDefaultValue = ""
						break
						case "bool": varDefaultValue = false
						break
					}
				} else {
					// Check if default value is correct for the type
					var valid = false
					switch (varType) {
						case "int": valid = is_real(varDefaultValue)
						break
						case "string": valid = is_string(varDefaultValue)
						break
						// yeah turns out boolean parses into 0 and 1, no surprise there
						// "is_bool" is always gonna return false here so we gotta compare it to 0 and 1 directly
						case "bool": valid = (varDefaultValue == 1 or varDefaultValue == 0)
						break
					}
					if (!valid) {
						____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'defaultValue' is not the same type as 'type'")
						continue
					}
				}
				
				if (is_undefined(varRange))
					varRange = ds_list_create()
				else {
					// Check if range exists but is not a list
					if (!ds_exists(varRange, ds_type_list)) {
						____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": wrong type for field 'range'")
						continue
					}
					
					// Check if type is int or string
					if (varType != "int" && varType != "string") {
						____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'range' can only exist for 'type' int or string")
						continue
					}
					
					if (varType == "int") {
						// Check if range only has two values
						if (ds_list_size(varRange) != 2) {
							____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'range' can only have exactly two values")
							continue
						}
					
						// Check if values are numbers
						if (!is_real(varRange[| 0]) || !is_real(varRange[| 1])) {
							____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'range' values are not int")
							continue
						}
					
						// Check if first value is smaller than the second one
						if (varRange[| 0] >= varRange[| 1]) {
							____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'range' values are not ordered")
							continue
						}
					} else {
						// Check if values are strings
						var found = false
						for (var j = 0; j < ds_list_size(varRange); j += 1) {
							if (!is_string(ds_list_find_value(varRange, j))) {
								____ProvEdit_load_error("object", f, "Variable " + string(i+1) + ": field 'range' values are not string")
								found = true
								break
							}
						}
						if (found)
							continue
					}
				}
				
				ds_list_add(variableList, [varName, varVariableName, varType, varDefaultValue, varRange])
			}
		}
		
		ProvEdit_object_add(interface, sprite_img, namespace, name, variableList)
	}



#define ProvEdit_object_add
	///(name, sprite, mod, object)

	var i = global.ProvEdit_object_number
	var key = argument2 + ":" + argument3
	global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.name] = argument0
	global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.sprite] = argument1
	global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.modName] = argument2
	global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.objName] = argument3
	global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.gmobjKey] = key
	global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.variables] = argument4

	global.____ProvEdit_object_map[? key] = i;

	global.ProvEdit_object_number += 1



#define ProvEdit_object_exists
	gml_pragma("forceinline")
	return (argument0 >= 0 && argument0 < global.ProvEdit_object_number)



#define ProvEdit_object_find
	///(name)
	var val = global.____ProvEdit_object_map[? argument0]
	return is_undefined(val) ? -1 : val

