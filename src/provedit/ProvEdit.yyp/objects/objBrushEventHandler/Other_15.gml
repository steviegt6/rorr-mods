
var s = size

var tx0 = x0, ty0 = y0

x0 -= ceil(s / 2) - 1
y0 -= ceil(s / 2) - 1

for (var i = 0; i < s; i++) {
	for (var j = 0; j < s; j++) {
		if (i == 0 || j == 0 || i == s - 1 || j == s - 1)
		event_user(4)
		y0 ++
	}
	y0 -= s
	x0 ++
}

x0 = tx0
y0 = ty0