
var yoff = 0

if (selected)
	yoff = 2
else if (hover_time > 0)
	yoff = min(hover_time, 2)
draw_sprite(sprite, subimage, x, y - yoff)
if (selected)
	draw_sprite(sprBottomLeftButtonChoice, 0, x, y - yoff)
else if (hover_time > 0)
	draw_sprite(sprBottomLeftButtonShadow, 0, x, y - yoff)

if (hover_time > 0 && !selected)
	draw_tooltip(x + 2, y - 12, tooltip, shortcut, hover_time - 1)
