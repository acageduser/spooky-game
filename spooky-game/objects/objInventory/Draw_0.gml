/// @description Insert description here
// You can write your code in this editor
// In the Draw Event of objInventory


// Ensure you are using the correct camera index (usually 0 for the first camera)


var x_position = view_xview[0] + 10; // 10 pixels from the left edge
var y_position = view_yview[0] + 10; // 10 pixels from the top edge

// Draw the inventory box sprite
draw_sprite(sprite_index, image_index, x_position, y_position);