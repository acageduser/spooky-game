/// @description Insert description here
// You can write your code in this editor
is_expanded = false; // Initial state, inventory is collapsed
box_width_collapsed = 50; // Width when the inventory is collapsed
box_height_collapsed = 50; // Height when collapsed
box_width_expanded = 300; // Width when expanded
box_height_expanded = 200; // Height when expanded
start_x = display_get_width() - box_width_collapsed - 10; // Position in the bottom-right corner
start_y = display_get_height() - box_height_collapsed - 10;// Position in the bottom-right cor
show_inventory=true