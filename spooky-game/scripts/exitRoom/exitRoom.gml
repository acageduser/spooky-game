/// @function tryToExitRoom
/// @desc handles the player’s attempt to exit the room, checking if wall phase ability is unlocked
/// @return none

function tryToExitRoom() {
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("You phase through the walls and exit the library.");  //player exits with wall phase ability
        game_end();  //end game logic here
    } else {
        objDialogueBox.setDialogue("The door is blocked. I can't get through.");  //no exit without wall phase
    }
}
