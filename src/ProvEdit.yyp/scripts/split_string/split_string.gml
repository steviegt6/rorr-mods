/// @function split_string
/// @param string
/// @param delimiter
function split_string(argument0, argument1) {
	var arr = [];
	var at = 0;
	var my_str = argument0;
	var sub_str = "";
	var quote = false;
	for(var i = 1; i < string_length(my_str)+1; i++) {
		var next_char = string_char_at(my_str,i);
		if(next_char == "\"") {
			quote = !quote;
		} else if (next_char != argument1 || quote) {
			sub_str = sub_str + next_char;
		} else {
			if(sub_str!="")
				arr[at++] = sub_str;
			sub_str = "";
		}
	}
	if(sub_str!="")
		arr[at++] = sub_str;
	return arr;


}
