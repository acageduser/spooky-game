/// @function Step
/// @desc checks player proximity and interaction with pedestal
/// @param none
var player_distance = distance_to_object(objPlayer);  //get player distance

//check player close enough and 'F' pressed
if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    interactWithPedestal();  //call interaction function
}
