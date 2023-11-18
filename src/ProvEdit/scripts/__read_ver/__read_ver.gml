
var values = split_string(argument0, ".")

var ret = [0, 0, 0]
for (var i = 0; i < array_length_1d(values); i++) {
	ret[i] = real_int(values[i])
}

return ret