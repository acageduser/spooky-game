/// @function Step
/// @desc Checks for player proximity and interaction with the pedestal
/// @param None

var player_distance = distance_to_object(objPlayer);

// Check if the player is close enough to the pedestal and presses the 'F' key
if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    // Call the function to handle the interaction
    interactWithPedestal();
}
