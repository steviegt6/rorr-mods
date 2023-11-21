
if (seen && can_close && keyboard_check_pressed(vk_escape)) {
	instance_destroy()
	exit
}

seen = true