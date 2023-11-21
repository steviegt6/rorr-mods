/// @description Clicked
switch (group) {
	// Mode buttons /////////////////////
	case 0:
		objMain.edit_mode = identity + 1
		with (objSidebar)
			event_user(0)
		break
	// Layer button /////////////////////
	case 2:
		with instance_create_depth(0, 0, -1000, objLayerPanel)
			parent = other.id
		break
	// Tile tools ///////////////////////
	case 101:
		objMain.tile_tool = identity
		break
	// Collision tools //////////////////
	case 102:
		objMain.collision_tool = identity
		break
	// Object tools /////////////////////
	case 103:
		objMain.object_tool = identity
		break

}