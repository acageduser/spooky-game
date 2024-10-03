/// @function openDoor
/// @desc handles the interaction with the door and checks if the player can phase through
/// @return none

function openDoor() {
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("You phase through the bookshelf and leave the library.");  //player phases through bookshelf if wallPhase is active
        //end game sequence logic should go here
    } else {
        objDialogueBox.setDialogue("The door is blocked by the bookshelf. I can't get through.");  //player is blocked by the bookshelf
    }
}
