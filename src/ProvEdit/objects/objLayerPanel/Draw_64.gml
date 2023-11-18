
draw_sprite(sprLayerWindow, 0, x, y)
draw_sprite_ext(sprLayerWindow, 1, x, y + 15, 1, (height - 30) / 15, 0, c_white, 1)
draw_sprite(sprLayerWindow, 2, x, y + height - 15)

draw_set_colour(c_white)
draw_set_font(fntMedium)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_text(x + 10, y + 14, title)