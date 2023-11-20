function _format_checklist() {
	// f, identifier, element_2d_array, number_of_visible_elements, width
	var f = argument[0]
	var d = data

	var st = argument[1]

	var elements = argument[2]

	var elem = 4
	if argument_count > 3
		elem = argument[3]
	
	var width = 88
	if argument_count > 4
		width = argument[4]
	
	//draw_set_align(fa_left, fa_middle)

	//draw_set_font(fntConsole)


	var _x = f[? _SP.x]
	var _y = f[? _SP.y]

	var l = _x - floor(width / 2)

	if (is_undefined(d[? st])) {
		d[? st] = elements
	}

	var target = noone
	with (objChecklist) {
		if (identifier == st) {
			target = id
			break
		}
	}
	if (target == noone) {
		target = instance_create_depth(l, _y, depth - 1, objChecklist)
		with (target) {
			identifier = st
			self.elements = elements
			self.width = width
			number_visible = elem
			owner = other
		}
	}

	with (target) {
		if (choice != -1) {
			if (choice_checkbox) {
				self.elements[choice, 0] = !self.elements[choice, 0]
				if (orderable) {
					if (!self.elements[choice, 0])
						self.elements[choice, 2] = 10000 //2147483500
					else {
						// has extra 100 that will be taken away afterwards
						var mindepth = 10000 + 100 //2147483500 + 100 
						for (var i = 0; i < array_height_2d(self.elements); i++) {
							if (i != choice && self.elements[i, 0] && self.elements[i, 2] < mindepth)
								mindepth = self.elements[i, 2]
						}
						self.elements[choice, 2] = mindepth - 100
					}
				}
				d[? st] = self.elements
				choice = -1
				choice_checkbox = 0
				visible_elements = []
				with (other)
					___format_event(f, SP_EVENT.contentChanged, st)
			} else if (choice_order != 0) {
				var choicedepth = self.elements[choice, 2]
				var swapdepth = choice_order ? choicedepth - 100 : choicedepth + 100
				for (var i = 0; i < array_length_1d(visible_elements); i++) {
					if (self.elements[visible_elements[i], 2] == swapdepth) {
						self.elements[visible_elements[i], 2] = choicedepth
						self.elements[choice, 2] = swapdepth
						break
					}
				}
				d[? st] = self.elements
				choice = -1
				choice_order = 0
				visible_elements = []
				with (other)
					___format_event(f, SP_EVENT.contentChanged, st)
			}
		}
	}

	//draw_sprite_part(sprFormDropdown, min(si, 1), 0, 0, 4, 17, l, _ty)
	//draw_sprite(sprFormDropdownButton, si, r - 17, _ty)
	//draw_sprite_part_ext(sprFormDropdown, min(si, 1), 4, 0, 4, 17, l + 4, _ty, (r - 17 - l) / 4 - 1, 1, c_white, 1)

	f[? _SP.y] += (elem * 21 + 2 + 21) + 16


}
