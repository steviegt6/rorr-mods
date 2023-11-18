if (!instance_exists(owner) || objMain.window_was_resized)
	instance_destroy()

height = number_visible * 21
if (array_length_1d(visible_elements) == 0) {
	visible_elements = []
	unpicked_elements = []
	count = 0
	var ucount = 0
	for (var i = 0; i < array_height_2d(elements); i++) {
		if (elements[i, 0]) {
			visible_elements[count] = i
			count++
		} else {
			unpicked_elements[ucount] = i
			ucount++
		}
	}
	if (orderable) {
		for (var i = 0; i < array_length_1d(visible_elements) - 1; i++) {
			var maxval = [i, elements[visible_elements[i], 2]]
			for (var j = i + 1; j < array_length_1d(visible_elements); j++) {
				var curval = [j, elements[visible_elements[j], 2]]
				if (curval[1] > maxval[1])
					maxval = curval
			}
			var tempvar = visible_elements[maxval[0]]
			visible_elements[maxval[0]] = visible_elements[i]
			visible_elements[i] = tempvar
		}
	}
}

var tyy = 16

var release_index = -1
var release_checkbox = -1
var release_order = -2
if (mouse_check_button_released(mb_left)) {
	release_index = hover
	release_checkbox = hover_checkbox
	release_order = hover_order
}

hover = -1
hover_checkbox = 0
hover_order = 0

var oy = 0
if (number_visible < count) {
	oy = -6
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, y, x + width, y + height)) {
		hover = -2
	}
}
for (var i = index_visible; tyy < height && i < count; i++) {
	var ytyy = y + tyy
	if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, ytyy - 16, x + width, ytyy + 5)) {
		hover = visible_elements[i]
		if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width - 11 + oy - 8, ytyy - 6 - 8, x + width - 11 + oy + 8, ytyy - 6 + 8))
			hover_checkbox = 1
		if (orderable) {
			if (i != 0 && point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, ytyy - 16 + 1, x + 10, ytyy - 16 + 10 + 1))
				hover_order = -1
			else if (i != array_length_1d(visible_elements) - 1 && point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, ytyy - 16 + 10 + 1, x + 10, ytyy - 16 + 10 + 1 + 10))
				hover_order = 1
		}
	}
	tyy += 21
}

if (release_index >= 0 && hover == release_index) {
	choice = hover
	if (release_checkbox != -1)
		choice_checkbox = hover_checkbox
	if (release_order != -2)
		choice_order = hover_order
}

if (hover != -1) {
	index_visible = clamp(index_visible - mouse_wheel_up() + mouse_wheel_down(), 0, max(count - number_visible, 0))
}

// dropdown

var open = false
var dropdown_identifier = identifier + "_dropdown"
with (objDropdownDisplay) {
	if (self.identifier == dropdown_identifier) {
		if (!is_undefined(self.clicked)) {
			var selected_elem = other.unpicked_elements[hover_element]
			if (other.dropdown_selected != selected_elem) {
				other.dropdown_selected = selected_elem
			}
			instance_destroy()
		} else {
			open = true
		}
	}
}
var dy = y + height + 3 + 21
if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x, y + height + 3, x + width - 21 - 2, y + height + 3 + 21))
	hover = -3
if (release_index == -3) {
	if (!open) {
		open = true
		var uelems = []
		var uc = 0
		for (var i = 0; i < array_length_1d(unpicked_elements); i++) {
			uelems[uc] = elements[unpicked_elements[i], 1]
			uc++
		}
		with (instance_create_depth(x, dy, depth - 1, objDropdownDisplay)) {
			identifier = dropdown_identifier
			width = other.width - 21
			owner = other
			elements = uelems
		}
	}
}

if (point_in_rectangle(mouse_ui_click_x, mouse_ui_click_y, x + width - 21, y + height + 3, x + width, y + height + 3 + 21))
	hover = -4
if (dropdown_selected != -1 && release_index == -4) {
	choice = dropdown_selected
	choice_checkbox = 1
	dropdown_selected = -1
}