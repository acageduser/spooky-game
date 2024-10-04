/// @function tryToExitRoom
/// @desc handles the player’s attempt to exit the room, checking if wall phase ability is unlocked
/// @return none

function tryToExitRoom() {
    if (global.wallPhase == true) {
		//go to the win screen
		room_goto(winScreen);

		objDialogueBox.setDialogue("You open the door and exit the library. You have beaten the game!");  //player exits with wall phase ability
        alarm[0] = room_speed * 5;  // Set a 5-second delay
    } else {
        objDialogueBox.setDialogue("The door is blocked. I can't get through.");  //no exit without wall phase
    }
}



