/// @description Insert description here
// You can write your code in this editor
draw_self();

//define text content
var button_text = "QUIT";

//define text position variables
var text_x;
var text_y;

//calculate and assign text to center
text_x = x + (sprite_width / 2) - (string_width(button_text) / 2);
text_y = y + (sprite_height / 2) - (string_height(button_text) / 2);

//set draw color to black
draw_set_color(c_black);

//draw the text
draw_text(text_x, text_y, button_text);