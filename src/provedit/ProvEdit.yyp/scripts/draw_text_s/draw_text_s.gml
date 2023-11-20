/// @description draw_text_s(x, y, string, halign, valign, font)
/// @argument x
/// @argument y
/// @argument string
/// @argument halign
/// @argument valign
/// @argument font
function draw_text_s(argument0, argument1, argument2, argument3, argument4, argument5) {

	draw_set_halign(argument3);
	draw_set_valign(argument4);
	draw_set_font(argument5);
	draw_text(argument0, argument1, argument2);


}
