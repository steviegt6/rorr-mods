function _format_background_settings() {
	var f = argument[0]
	var st = argument[1]
	var bgs = argument[2]

	if (is_undefined(data[? st])) data[? st] = -1

	var settings = [
		[_format_margin, 0.45, 0.5],
		[_format_colour, c_black],
		[_format_text, "No background currently selected.", fntMedium, fa_middle],
		[_format_colour, c_white]
	]

	with (objChecklist) {
		if (identifier == "background_list") {
			if (!orderable)
				orderable = 1
			if (other.data[? st] == -1 || other.data[? st] != choice) {
				other.data[? st] = choice
			
				other.data[? "bg_tile_x"] = undefined
				other.data[? "bg_tile_y"] = undefined
				other.data[? "bg_parallax_x"] = undefined
				other.data[? "bg_parallax_y"] = undefined
				other.data[? "bg_offset_x"] = undefined
				other.data[? "bg_offset_y"] = undefined
				other.data[? "bg_percent_x"] = undefined
				other.data[? "bg_percent_y"] = undefined
			
				break
			}
		}
	}
		
	if (data[? st] != -1) {
		var bgObj = -1
		for (var i = 0; i < array_length_1d(global.level_backgrounds); i++) {
			var currObj = global.level_backgrounds[i]
			if (currObj.background == data[? st]) {
				bgObj = currObj
				break
			}
		}
			
		if (bgObj != -1) {
			settings = [
				[_format_margin, 0.45, 0.5],
				[_format_colour, c_black],
				[_format_text, "Editing background:" + bgs[data[? st], 1], fntMedium, fa_middle],
				[_format_colour, c_white],
				[_format_margin, 0.45, 0],
				[_format_text, "", fntMedium, fa_middle], // here for padding reasons lmao
				[_format_text, "", fntMedium, fa_middle],
				[_format_text, "Tile horizontally", fntMedium, fa_left],
				[_format_text, "Tile vertically", fntMedium, fa_left],
				[_format_text, "Parallax X:", fntMedium, fa_left],
				[_format_text, "Parallax Y:", fntMedium, fa_left],
				[_format_text, "X offset:", fntMedium, fa_left],
				[_format_text, "Y offset:", fntMedium, fa_left],
				[_format_text, "X % offset:", fntMedium, fa_left],
				[_format_text, "Y % offset:", fntMedium, fa_left],
				[_format_margin, 0.70, 0.25],
				[_format_text, "", fntMedium, fa_middle], // here for padding reasons lmao
				[_format_text, "", fntMedium, fa_middle],
				[_format_checkbox, "bg_tile_x", bgObj.tilex],
				[_format_checkbox, "bg_tile_y", bgObj.tiley],
				[_format_input_number, "bg_parallax_x", bgObj.parallaxx, [0, 2], 0.1, 15],
				[_format_input_number, "bg_parallax_y", bgObj.parallaxy, [0, 2], 0.1, 15],
				[_format_input_number, "bg_offset_x", bgObj.offsetx, undefined, 1, 15],
				[_format_input_number, "bg_offset_y", bgObj.offsety, undefined, 1, 15],
				[_format_input_number, "bg_percent_x", bgObj.percentx, [0, 1], 0.1, 15],
				[_format_input_number, "bg_percent_y", bgObj.percenty, [0, 1], 0.1, 15]
			]
		}
	}

	for (var i = 0; i < array_length_1d(settings); i++) {
		var ff = settings[i]
		var args = array_length_1d(ff)
		switch (args) {
			case 1: script_execute(ff[0], f) break
			case 2: script_execute(ff[0], f, ff[1]) break
			case 3: script_execute(ff[0], f, ff[1], ff[2]) break
			case 4: script_execute(ff[0], f, ff[1], ff[2], ff[3]) break
			case 5: script_execute(ff[0], f, ff[1], ff[2], ff[3], ff[4]) break
			case 6: script_execute(ff[0], f, ff[1], ff[2], ff[3], ff[4], ff[5]) break
			default: show_error("Too many format args!", true)
		}
	}


}
