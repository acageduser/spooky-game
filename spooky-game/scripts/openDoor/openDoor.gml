// openDoor.gml
function openDoor() {
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("You phase through the bookshelf and leave the library.");
        // End game sequence
    } else {
        objDialogueBox.setDialogue("The door is blocked by the bookshelf. I can't get through.");
    }
}
