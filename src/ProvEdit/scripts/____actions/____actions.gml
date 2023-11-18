gml_pragma("global", "____actions()")

enum Actions {
	placeMarker,
	tileData,
	colData,
	placeObject,
	updateObject,
	levelInfo,
	createLayer,
	updateLayer,
	deleteLayer,
	updateBackground
}

global.__action_name = []
global.__action_in = []
global.__action_out = []

// placeMarker x, y, index
__action_init(Actions.placeMarker, "placeMarker")
// tileData [instances]
__action_init(Actions.tileData, "tileData")

__action_init(Actions.colData, "colData")
// placeObject x, y, kind
__action_init(Actions.placeObject, "placeObject")
// updateObject x, y, kind, [variables]
__action_init(Actions.updateObject, "updateObject")
// levelInfo name, value
__action_init(Actions.levelInfo, "levelInfo")
// createLayer name, tileset, depth
__action_init(Actions.createLayer, "createLayer")
// updateLayer id, field [0: name, 1: tileset, 2: depth], value
__action_init(Actions.updateLayer, "updateLayer")
// deleteLayer id
__action_init(Actions.deleteLayer, "deleteLayer")
// updateBackground bgname, variable, value
__action_init(Actions.updateBackground, "updateBackground")