/// @description Insert description here
// You can write your code in this editor
draw_self();

//set font to default
draw_set_font(-1);

//define text content
var _button_text = "QUIT";

//define text position variables
var _text_x;
var _text_y;

//calculate and assign text to center
_text_x = x + (sprite_width / 2) - (string_width(_button_text) / 2);
_text_y = y + (sprite_height / 2) - (string_height(_button_text) / 2);

//set draw color to black
draw_set_color(c_black);

//draw the text
draw_text(_text_x, _text_y, _button_text);