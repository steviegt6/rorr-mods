var f = argument[0]
var _y = f[? _SP.y] + 25
var _w = f[? _SP.width]
var _x = f[? _SP.x] - ceil(_w / 2)
draw_line_colour(_x, _y, _x + _w, _y, Colours.black, Colours.black)
draw_sprite(sprFormTabEdge, 0, _x, _y)
draw_sprite(sprFormTabEdge, 1, _x + _w - 13, _y)