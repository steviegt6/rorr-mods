//form_width = 512
//form_height = 256
//form_title = "Empty Form"
//captured = false
//requires_action = false

world_x = 0

world_y = 0

width = 250
height = 1

form_width = width
form_height = height

surface = surface_create(width, 200)

hover_bar = false
move_bar = false
move_bar_x = 0
move_bar_y = 0

captured = false
requires_action = true
//center = true

//format = [
//	[_format_colour, c_black],
//	[_format_text, "This will discard any unsaved changes.\nContinue?"],
//	[_format_colour, c_white],
//	[_format_left],
//	[_format_button, "No"],
//	[_format_right],
//	[_format_button, "Yes"],
//]

format = []

handle_button = ___object_menu_handle_button


state = ds_map_create()
state[? _SP.widthInitial] = width
state[? _SP.heightInitial] = height
state[? _SP.choice] = ""
state[? _SP.typing] = ""
state[? _SP.typingLast] = ""
state[? _SP._owner] = id

data = ds_map_create()

temp_data = ds_map_create()

// Used for checking if the menu is closed in the packet
destroyed = false