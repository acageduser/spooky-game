/// @function interactWithDoor
/// @desc handles the player's interaction with the door, switching to the win screen
/// @return none

function interactWithDoor() {
    // Ensure the dialogue box is created before using it
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  // Create dialogue box on the correct layer
    }

    if (global.wallPhase == true) {  // If the player has unlocked the wallPhase ability
        objDialogueBox.setDialogue("You phase through the bookshelf and stand at the door to leave the library.");
        room_goto(winScreen);  // Move the player to the winScreen room
    } else {
        objDialogueBox.setDialogue("I can't get through... Peering through the cracks in the bookshelf you can see a door.");  // Message if the player hasn't unlocked the ability
    }
}
