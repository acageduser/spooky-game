/// @function interactWithPedestal
/// @desc handles interaction with the pedestal, checking if the player has the cursed book and whether the ritual is complete
/// @return none
function interactWithPedestal() {
    // Ensure that the dialogue box exists
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  // Create dialogue box on the correct layer
    }

    // Check if the pedestal is empty
    if (!global.pedestalOccupied) {
        if (global.HasCursedBook) {
            // Player has the Cursed Book and places it on the pedestal
            objDialogueBox.setDialogue("You place the Cursed Book on the pedestal. The ritual is complete. You see the Librarian's eyes go wide...");  // Ritual completes
            global.pedestalOccupied = true;  // Update pedestal state
            removeItemFromInventory();  // Remove the Cursed Book from inventory
            global.HasCursedBook = false;  // The player no longer has the Cursed Book
            show_debug_message("Cursed Book removed from inventory.");
            
            // Place the book at the coordinates (256, 177)
            var book = instance_create_layer(256, 197, "cursedbook", objCursedBook);  
            // Force the book depth to a value less than objAlter's depth (800)
            book.depth = 800;  // Ensure it's drawn in front of objAlter
        } else {
            // Pedestal is empty but player lacks the Cursed Book
            objDialogueBox.setDialogue("The pedestal is empty.");  // No action without Cursed Book
        }
    } else {
        // Pedestal already occupied, ritual completed
        objDialogueBox.setDialogue("The ritual is already complete.");  // No further action
    }
}





/// @function removeItemFromInventory
/// @desc Removes the Cursed Book from the player's inventory
/// @return none
function removeItemFromInventory() {
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == "Cursed Book") {
            array_delete(global.inventory, i, 1);  // Corrected: remove 1 element at index i
            break;
        }
    }
}
