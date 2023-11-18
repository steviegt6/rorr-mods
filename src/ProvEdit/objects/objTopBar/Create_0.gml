sprite_index = -1

buttons = [
	["File",
		["Save", "CTRL+S", undefined, "Save the current level.\nOverwrites the original file on following saves.\nKeyboard shortcut: CTRL+S"],
		["Save As", "CTRL+SHIFT+S", undefined, "Save the current level under a different name.\nKeyboard shortcut: CTRL+SHIFT+S"],
		["Load", "CTRL+O", net_client, "Open a previously saved level file.\nKeyboard shortcut: CTRL+O"],
		["Export Lua", "CTRL+E", undefined, "Exports a Lua script to be loaded from a mod.\nNote that scripts cannot be re-imported.\nMake sure to save a level file as well!\nKeyboard shortcut: CTRL+E"],
		["New", "", net_client, "Clears the entire level."]],
	["Edit",
		["Undo", "CTRL+Z", undefined, "Revert the previous action.\nKeyboard shortcut: CTRL+Z"],
		["Redo", "CTRL+Y", undefined, "Perform the previously reverted action.\nKeyboard shortcut: CTRL+Y"]],
	["View",
		["UI Scale", "", undefined, "Toggles between 1x and 2x UI zoom scale.\nNote that this is buggy and likely to cause issues.\nReturning to 1x without visual artifacts may require restarting the program."],
		["Grid", "CTRL+G", undefined, "Toggles visibility of the tile grid.\nKeyboard shortcut: CTRL+G"],
		["Layer Opacity", "CTRL+H", undefined, "Toggles whether layers become transparent when deselected.\nKeyboard shortcut: CTRL+H"],
		["Collision Opacity", "CTRL+J", undefined, "Toggles collision opacity mode.\nBy default, collision is always visible but more opaque in collision mode.\nWhen this is toggled, collision is only visible in collision mode but is fully opaque.\nKeyboard shortcut: CTRL+J"],
		["Collision Icons", "", undefined, "Toggles between normal and high-visibility collision icons.\nHigh-visibility icons may improve readability for some users, but also increase visual clutter."]],
	["Net",
		["Host", "", net_online, "Start an online session."],
		["Join", "", net_online, "Connect to an online session."],
		["Disconnect", "", net_offline, "Disconnect from the host or close the server when connected."]]
]
button_count = 4
occupied_mouse = false
choice = -1
choice_clicked = -1
menu_open = noone