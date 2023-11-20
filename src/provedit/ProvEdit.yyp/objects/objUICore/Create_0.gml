/// @description 
sprite_index = -1

occupied_mouse = false

// Cam buttons
var tooltips = ["Zoom In", "PLUS", "Zoom Out", "MINUS", "Reset Zoom", "ZERO", "Snap View", ""]
for (var i = 0; i < 4; i++) {
	with (instance_create_depth(0, 0, -9991, objBottomLeftButton)) {
		left = 33 + i * 23
		identity = i
		subimage = i
		tooltip = tooltips[i * 2]
		shortcut = tooltips[i * 2 + 1]
	}
}
// Settings button
with (instance_create_depth(0, 0, -9991, objBottomLeftButton)) {
	left = 3
	identity = 4
	sprite = sprSettingsButton
	tooltip = "Settings"
	shortcut = "ESC"
}