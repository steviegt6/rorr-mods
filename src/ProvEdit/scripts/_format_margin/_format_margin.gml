var f = argument0

if (f[? _SP.columnStart] == -1) {
	f[? _SP.columnStart] = f[? _SP.y]
} else {
	f[? _SP.y] = f[? _SP.columnStart]
}

var wi = f[? _SP.widthInitial]
var xi = f[? _SP.xInitial]
var tw = floor(wi * argument2)

f[? _SP.x] = floor(xi - wi / 2 + wi * argument1 + tw / 2)
f[? _SP.width] = tw