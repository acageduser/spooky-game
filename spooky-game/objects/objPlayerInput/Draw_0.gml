/// @description Insert description here
// You can write your code in this editor
// Set the draw color
draw_set_color(c_white);

// Draw prompt text asking for the player's name
draw_text(100, 392, "Directions: Begin typing your name " +
					"\nwithout clicking.");
draw_text(100, 452, "Enter your name:");

// Draw the current player name input
draw_text(250, 452, global.player_name);