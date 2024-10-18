/// @function Step
/// @desc Handles interaction with the cursed book
/// @param None

var player_distance = distance_to_object(objPlayer);

// Check if the player is close enough to interact with the cursed book and presses the 'F' key
if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    // Set flag that the player now has the Cursed Book
    global.HasCursedBook = true;
    array_push(global.inventory, "Cursed Book");  // Add the cursed book to the player's inventory

    // Show a message or feedback (optional)
    show_debug_message("Cursed Book added to inventory!");

    // Destroy the cursed book object from the room
    instance_destroy();
}
