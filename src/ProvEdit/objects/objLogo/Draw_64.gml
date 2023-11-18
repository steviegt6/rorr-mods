var alpha = min(fade, 1);

draw_sprite_ext(sprLogo, 0, ui_hmid, round(ui_bottom_raw / 2), 2, 2, 0, c_white, alpha);

// Version string
draw_set_alpha(alpha / 2);
draw_set_colour(c_gray)
draw_text_s(ui_hmid + 18, round(ui_bottom_raw / 2) - 2, "V. " + editor_version, fa_left, fa_top, fntTiny2X);
draw_set_alpha(1);