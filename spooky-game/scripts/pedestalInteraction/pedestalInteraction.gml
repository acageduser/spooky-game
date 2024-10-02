// pedestalInteraction.gml

function interactWithPedestal() {
    if (global.pedestalOccupied == false && global.hasCursedBook == true) {
        objDialogueBox.setDialogue("You place the Cursed Book on the pedestal. The ritual is complete.");
        global.pedestalOccupied = true;
        global.librarianDisabled = true;  // Librarian freed
    } else if (global.pedestalOccupied == true) {
        objDialogueBox.setDialogue("The ritual is already complete.");
    } else {
        objDialogueBox.setDialogue("The pedestal is empty. I need the Cursed Book.");
    }
}
