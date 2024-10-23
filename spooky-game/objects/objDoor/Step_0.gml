/// @function Step
/// @desc allows the player to interact with the door
/// @param none

//check distance between player and door
var player_distance = distance_to_object(objPlayer);

//check if player is close enough and presses 'F'
if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    interactWithDoor();  //trigger door interaction
}
