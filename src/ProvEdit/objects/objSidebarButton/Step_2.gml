

switch (group) {
	case 0:
		selected = objMain.edit_mode - 1 == identity
		break
	case 101:
		selected = objMain.tile_tool == identity
		break
	case 102:
		selected = objMain.collision_tool == identity
		break
	case 103:
		selected = objMain.object_tool == identity
		break
	case 2:
		selected = instance_exists(objLayerPanel)
		break
}