/// @function interactWithDoor
/// @desc handles the player's interaction with the door, switching to the win screen
/// @param none
/// @return none

function interactWithDoor() {
    //ensure dialogue box is created before using it
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  //create dialogue box
    }

    //check if player has wall phase ability
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("you phase through the bookshelf and stand at the door to leave the library.");
        room_goto(winScreen);  //move player to win screen
    } else {
        objDialogueBox.setDialogue("i can't get through... peering through the cracks in the bookshelf you can see a door.");  //message if ability not unlocked
    }
}
