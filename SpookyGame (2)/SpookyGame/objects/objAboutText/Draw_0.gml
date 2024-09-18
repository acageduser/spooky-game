/// @description Insert description here
// You can write your code in this editor
// Set the draw color
draw_set_color(c_white);

// Define the text content
var description_text = "You awaken in a dimly lit, eerie library with no memory of how you got there. The air is thick with the scent of old books and the unsettling whispers of unseen spirits. Shadows dance on the walls, and the room is silent except for the occasional creak of the floorboards. As you explore this haunted place, you encounter two trapped souls... a spectral librarian bound to her duties and a ghostly janitor cursed to sweep for eternity. ";
// Draw the text at a specific position (e.g., centered in the room)
var text_x = 33;
var text_y = 61;

// Draw the description text
draw_text_ext(text_x, text_y, description_text,40,450);  // Draw score below the first text