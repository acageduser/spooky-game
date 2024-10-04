/// @function openDoor
/// @desc handles the interaction with the door and checks if the player can phase through
/// @return none

function openDoor() {
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("You phase through the bookshelf are standing at the door to leave the library.");  //player phases through bookshelf if wallPhase is active
        //end game sequence logic should go here
    } else {
        objDialogueBox.setDialogue("I can't get through... Peering through the cracks in the bookshelf you can see a door.");  //player is blocked by the bookshelf
    }
}
