/// @function interactWithPedestal
/// @desc handles interaction with the pedestal, checking if the player has the cursed book and whether the ritual is complete
/// @return none
function interactWithPedestal() {
    // Check if the pedestal is empty
    if (!global.pedestalOccupied) {
        if (global.hasCursedBook) {
            // Player has the Cursed Book and places it on the pedestal
            objDialogueBox.setDialogue("You place the Cursed Book on the pedestal. The ritual is complete. You see the Librarian's eyes go wide...");  // Ritual completes
            global.pedestalOccupied = true;  // Update pedestal state
            removeItemFromInventory();  // Remove the Cursed Book from inventory
			global.inventory = [];
            global.hasCursedBook = false;  // The player no longer has the Cursed Book
            show_debug_message("Cursed Book removed from inventory.");
        } else {
            // Pedestal is empty but player lacks the Cursed Book
            objDialogueBox.setDialogue("The pedestal is empty.");  // No action without Cursed Book
        }
    } else {
        // Pedestal already occupied, ritual completed
        objDialogueBox.setDialogue("The ritual is already complete.");  // No further action
    }
}
