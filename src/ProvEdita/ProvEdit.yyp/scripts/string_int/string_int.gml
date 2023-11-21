function string_int(argument0) {
	//string_digits with support for - sign at start

	return string_char_at(argument0, 1) == "-" ? "-" + string_digits(argument0) : string_digits(argument0)


}
