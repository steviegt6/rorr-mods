/// @description Button-specific init
x = ui_right - left
if (!bottom)
	y = ui_top + top
else
	y = ui_bottom - objToolPanel.height - 35 - 28
	
switch (group) {
	case 0:
		subimage = identity
		sprite = sprButtonsMode
		switch (identity) {
			case 0:
				hover_tip = "Tile Mode"
				long_tip = "TILE MODE:\nUsed to edit the visual part of the level.\nTiles make up the ground and decorations.\nTiles have no implicit interactions."
				break
			case 1:
				hover_tip = "Collision Mode"
				long_tip = "COLLISION MODE:\nUsed to add interactivity to solids, ropes, and special tiles.\nAlso used to indicate parts of the level where interactables, enemies, and bosses can spawn."
				break
			case 2:
				hover_tip = "Object Mode"
				long_tip = "OBJECT MODE:\nUsed to place objects that always appear.\nThese objects can be anything but are most often pre-placed interactables."
				break
		}
		break
	case 2:
		hover_tip = "Edit Layers"
		long_tip = "TILE LAYER MENU:\nUse this to add, remove, or modify layers."
		sprite = sprButtonLayer
		break
	case 101:
		// Tile tools
		sprite = sprButtonsTileTools
		switch identity {
			case Tools.tilePencil:
				hover_tip = "Pencil"
				long_tip = "PENCIL TOOL:\nBasic tile placement and eraser tool."
				subimage = 0
				break
			case Tools.tileBrush:
				hover_tip = "Brush"
				long_tip = "BRUSH TOOL:\nAuto-tiling placement tool.\nNote that the tileset must have brushes defined for this to be usable."
				subimage = 1
				break
			case Tools.tileSelector:
				hover_tip = "Selector"
				subimage = 2
				break
		}
		break
	case 102:
		// Collision tools
		sprite = sprButtonsCollisionTools
		switch identity {
			case Tools.collisionEditor:
				hover_tip = "Highlighter"
				long_tip = "HIGHLITER TOOL:\nAdd and remove collision boxes."
				subimage = 0
				break
			case Tools.zoneEditor:
				hover_tip = "Zones"
				subimage = 1
				break
		}
		break
	case 103:
		// Object tools
		sprite = sprButtonsObjectTools
		switch identity {
			case Tools.objectPlacer:
				hover_tip = "Chalk"
				long_tip = "CHALK TOOL:\nAdd, modify, and remove objects."
				subimage = 0
				break
			case Tools.objectSelector:
				hover_tip = "Selector"
				subimage = 1
				break
		}
		break
}