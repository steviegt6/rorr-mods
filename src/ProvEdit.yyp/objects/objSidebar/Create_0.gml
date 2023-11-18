sprite_index = -1

occupied_mouse = false
force_occupy = false

instance_create_depth(0, 0, -9991, objToolPanel)

for (var i = 0; i < 3; i++) {
	with (instance_create_depth(0, 0, -9991, objSidebarButton)) {
		identity = i
		top = 12
		top_offset = i * 48
		event_user(0)
	}
}

with (instance_create_depth(0, 0, -9991, objSidebarButton)) {
	identity = 0
	group = 2
	bottom = true
	event_user(0)
}

event_user(0)