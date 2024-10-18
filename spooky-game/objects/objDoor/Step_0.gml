/// @function Step
/// @desc Allows the player to interact with the door
/// @param None

var player_distance = distance_to_object(objPlayer);

// Check if the player is close enough to interact and presses the 'F' key
if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    interactWithDoor();  // Call the door interaction function
}
