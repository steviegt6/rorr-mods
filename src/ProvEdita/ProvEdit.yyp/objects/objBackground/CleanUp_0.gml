if (my_layer != -1) {
	if (layer_background_exists(my_layer, my_layer_bg))
		layer_background_destroy(my_layer_bg)
	if (layer_exists(my_layer))
		layer_destroy(my_layer)
}