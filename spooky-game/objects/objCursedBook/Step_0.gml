var player_distance = distance_to_object(objPlayer);

// You can debug the distance to see if the check is correct
show_debug_message("Player distance to book: " + string(player_distance));

if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    global.HasCursedBook = true;  // Set the flag
    array_push(global.inventory, "Cursed Book");  // Add book to inventory
    show_debug_message("Cursed Book added to inventory!");  // Feedback
    instance_destroy();  // Remove the book from the room
}
if (keyboard_check_pressed(ord("F"))) {
    show_debug_message("F key pressed!");  // Add this to confirm F key press
	show_debug_message("Inventory: " + string(global.inventory));
}
