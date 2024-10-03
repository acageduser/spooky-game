// pedestalInteraction.gml

function interactWithPedestal() {
    // Check if the pedestal is occupied
    if (!global.pedestalOccupied) {
        if (global.hasCursedBook) {
            // If the player has the cursed book and the pedestal is empty
            objDialogueBox.setDialogue("You place the Cursed Book on the pedestal. The ritual is complete.");
            
            // Update the game state to reflect that the pedestal is now occupied
            global.pedestalOccupied = true;
        } else {
            // If the pedestal is empty but the player does not have the cursed book
            objDialogueBox.setDialogue("The pedestal is empty.");
        }
    } else {
        // If the pedestal is already occupied
        objDialogueBox.setDialogue("The ritual is already complete.");
    }
}