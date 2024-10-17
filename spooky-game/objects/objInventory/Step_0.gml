/// @description Insert description her
if (mouse_check_button_pressed(mb_left)) {
    // Toggle a variable to control visibility
    show_inventory = !show_inventory;
}

// If you want to define the variable in the Create Event
if (show_inventory) {
    // In the Draw Event
    var x_position = view_xview[0] + 10; // 10 pixels from the left edge
    var y_position = view_yview[0] + 10; // 10 pixels from the top edge

    // Draw the inventory box sprite
    draw_sprite(sprite_index, image_index, x_position, y_position);
}