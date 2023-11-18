function find_free_index(argument0) {
	var s = array_length_1d(argument0)
	for (var i = 0; i < s; i++) {
		if (argument0[i] == 0)
			return i
	}
	return s


}
