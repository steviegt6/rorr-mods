var f = argument[0]

if (f[? _SP.columnStart] == -1) {
	f[? _SP.columnStart] = f[? _SP.y]
} else {
	f[? _SP.y] = f[? _SP.columnStart]
	f[? _SP.columnStart] = -1
}

var x_offset = 0
if (argument_count > 1)
	x_offset = argument[1]

f[? _SP.width] = floor(f[? _SP.widthInitial] / 2)
f[? _SP.x] = f[? _SP.xInitial] - ceil(f[? _SP.widthInitial] / 4) + x_offset
