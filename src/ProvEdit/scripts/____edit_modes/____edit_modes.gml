gml_pragma("global", "____edit_modes()")

enum EditModes {
	none,
	tiles,
	collision,
	objects,
	levelBounds
}

global.__edit_mode_name = ["nothing", "tiles", "collision", "objects"]