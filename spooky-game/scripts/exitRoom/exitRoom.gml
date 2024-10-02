// exitRoom.gml

function tryToExitRoom() {
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("You phase through the walls and exit the library.");
        // Add end game logic here
    } else {
        objDialogueBox.setDialogue("The door is blocked. I can't get through.");
    }
}
