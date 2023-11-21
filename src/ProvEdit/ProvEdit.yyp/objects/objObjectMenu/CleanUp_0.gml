event_inherited()
ds_map_destroy(state)
ds_map_destroy(data)
ds_map_destroy(temp_data)

if (surface_exists(surface))
	surface_free(surface)

if (objMouseCaptureHandler.force_capture == id)
	objMouseCaptureHandler.force_capture = noone