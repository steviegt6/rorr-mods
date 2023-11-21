draw_sprite(sprSnapCornersBackdrop, 0, x, y)

for (var i = 0; i < 4; i++)
	if (choice != i)
		draw_sprite(sprSnapCornersButtons, i, x - 7, y - 70 + i * 15)

if (choice != -1) {
	var ty = y - 70 + choice * 15 - 2
	draw_sprite(sprSnapCornersButtons, choice, x - 7, ty)
	draw_sprite(sprSnapCornersButtonHover, 0, x - 7, ty)
}