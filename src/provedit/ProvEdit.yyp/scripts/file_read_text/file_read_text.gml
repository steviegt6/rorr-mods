function file_read_text(argument0) {
	var out = ""
	var file = file_text_open_read(argument0)
	while (!file_text_eof(file))
	    out += file_text_readln(file)
	file_text_close(file);
	return out


}
