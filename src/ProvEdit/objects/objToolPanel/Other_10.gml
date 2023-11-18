with (parUIPanelElement)
	if (parent == objToolPanel || parent == objToolPanel.id)
		instance_destroy()

width = 128 
height = 96
header_text = "Tool Options"

switch (objMain.tool) {
	case -1:
		width = 0
		height = 0
		header_subtext = ""
		break
	case Tools.tilePencil:
		header_subtext = "Pencil"
		
		var ts = global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.image]
		ui_resize(max(sprite_get_width(ts), 128) + 30, sprite_get_height(ts) + 60)
		
		ui_add(objUITileSelector, 15, 40)
		with (ui_add(objUINumberEntry, 20, 16)) {
			ref = var_ref(objMain, "tool_tile_pencil_size")
			tip = "The size of the brush in tiles."
			limit = [1, 10]
		}
		with (ui_add(objUICheckbox, 20 + 48, 17)) {
			ref = var_ref(objMain, "tool_tile_pencil_randomize")
			tip = "Tick to enable random tile selection when multiple are selected.\nIf this is unticked then multi-selected tiles are treated as a stamp."
		}
		with (ui_add(objUILabel, 20 + 48, 4)) {
			text = "Randomize"
		}
		with (ui_add(objUILabel, 12, 4)) {
			text = "Size"
		}
		
		break
	case Tools.tileBrush:
		header_subtext = "Brush"
		
		ui_resize(128, 64)
		
		var numBrushes = array_length_1d(global.ProvEdit_tileset[objMain.layer_choice.tileset, PROVEDIT_TILESET.brushes])
		if (numBrushes > 0) {
		
			with (ui_add(objUILabel, 12, 4)) {
				text = "Size"
			}
			with (ui_add(objUINumberEntry, 20, 16)) {
				ref = var_ref(objMain, "tool_tile_brush_size")
				limit = [1, 10]
			}
		
			with (ui_add(objUILabel, 12 + 48, 4)) {
				text = "Brush"
			}
			objMain.tool_tile_brush_selection = clamp(objMain.tool_tile_brush_selection, 1, numBrushes)
			with (ui_add(objUINumberEntry, 20 + 48, 16)) {
				ref = var_ref(objMain, "tool_tile_brush_selection")
				limit = [1, numBrushes]
			}
		} else {
			with (ui_add(objUILabel, 64, 32)) {
				text = "No brushes available\nfor the selected tileset.\n:("
				halign = fa_middle
				valign = fa_middle
			}
		}
		
		break
	case Tools.tileSelector:
		header_subtext = "Selector"
		break
	case Tools.collisionEditor:
		header_subtext = "Highlighter"
		
		ui_resize(128 + 64, 96)
		with (ui_add(objUIListBox, 15, 15)) {
			ref = var_ref(objMain, "collision_type")
			for (var i = 0; i < global.collision_type_num; i++) {	
				contents[i] = global.collision_types[i, CollisionType.name]
				values[i] = i
			}
			width = 128 + 32
			count = global.collision_type_num
			title = "Collision Type"
		}
		
		break
	case Tools.zoneEditor:
		header_subtext = "Zone Editor"
		break
	case Tools.objectPlacer:
		header_subtext = "Chalk"
		
		ui_resize(128 + 64, 96)
		var disp_size = 12 * 5
		with (ui_add(objUIListBox, 15 + disp_size, 15)) {
			ref = var_ref(objMain, "object_type")
			for (var i = 0; i < global.ProvEdit_object_number; i++) {	
				contents[i] = global.ProvEdit_object[i, PROVEDIT_LEVELOBJECT.name]
				values[i] = i
			}
			width = 128 + 32 - disp_size
			count = global.ProvEdit_object_number
			title = "Object Choice"
		}
		with (ui_add(objUIMapObjectDisplay, 15, 15)) {
			width = disp_size
			height = disp_size
		}
		
		break
	case Tools.objectSelector:
		header_subtext = "Object Selector"
		break
	
	
}

with (parUIPanelElement)
	if (parent == objToolPanel || parent == objToolPanel.id)
		event_user(15)