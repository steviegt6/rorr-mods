var _name, _tileset, _depth

if (argument0 == -1) {
	_name = "Layer " + string(global.layers_total + 1)
	_tileset = global.ProvEdit_tileset[0, PROVEDIT_TILESET.name]
	_depth = "12"
} else {
	_name = argument0.name
	_tileset = global.ProvEdit_tileset[argument0.tileset, PROVEDIT_TILESET.name]
	_depth = string(argument0.depth)
}

var popup = show_popup("Layer Settings", 320, 160, [
	[_format_text_fancy, argument0 == -1 ? "Create Layer" : "Edit Layer", fntMedium2X],
	[_format_colour, c_black],
	[_format_margin, 0, 0.15],
	[_format_text, "Name:", fntMedium, fa_left],
	[_format_text, "Tileset:", fntMedium, fa_left],
	[_format_text, "Depth:", fntMedium, fa_left],
	[_format_colour, c_white],
	[_format_margin, 0.3, 0.7],
	[_format_input_text, "name", _name, false, 88 + 8 * 6],
	[_format_dropdown, "tileset", _tileset, global.ProvEdit_tileset_array, 88 + 8 * 6],
	[_format_input_text, "depth", _depth, 2, 88 + 8 * 6],
	[_format_middle],
	[_format_button, "Done"]
], ___popup_edit_layer_handle)
popup.layer_id = argument0