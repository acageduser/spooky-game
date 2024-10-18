/// @description Insert description here
// You can write your code in this editor


//set main title ("Banished ... Book") font and color
draw_set_font(fnt_title);
draw_set_color(c_white);

//draw main title ("Banished ... Book") centered
draw_text((room_width-string_width("Banished"))/2, y - 65, "Banished");
draw_text((room_width-string_width("Book"))/2, y + 35, "Book");

//set font for "by the"
draw_set_font(fnt_title_small);

//draw "by the" centered
draw_text((room_width-string_width("by the"))/2, y, "by the");

//set drawing defaults
draw_set_font(-1);
draw_set_color(c_black);

