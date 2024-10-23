/// @function interactWithPedestal
/// @desc handles interaction with the pedestal, checking if the player has the cursed book and whether the ritual is complete
/// @param none
/// @return none
function interactWithPedestal() {
    //ensure dialogue box exists
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  //create dialogue box
    }

    //check if pedestal is empty
    if (!global.pedestalOccupied) {
        if (global.HasCursedBook) {
            //player places cursed book on pedestal
            objDialogueBox.setDialogue("you place the cursed book on the pedestal. the ritual is complete. you see the librarian's eyes go wide...");  //complete ritual
            global.pedestalOccupied = true;  //update pedestal state
            removeItemFromInventory();  //remove cursed book from inventory
            global.HasCursedBook = false;  //player no longer has cursed book
            show_debug_message("cursed book removed from inventory.");

            //place the cursed book at given coordinates
            var book = instance_create_layer(256, 197, "cursedbook", objCursedBook);  
            book.depth = 800;  //ensure book drawn in front of objAlter
        } else {
            //pedestal empty but no cursed book
            objDialogueBox.setDialogue("the pedestal is empty.");  //no action without cursed book
        }
    } else {
        //ritual already complete
        objDialogueBox.setDialogue("the ritual is already complete.");  //no further action
    }
}

/// @function removeItemFromInventory
/// @desc removes the cursed book from the player's inventory
/// @param none
/// @return none
function removeItemFromInventory() {
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i] == "Cursed Book") {
            array_delete(global.inventory, i, 1);  //remove cursed book from inventory
            break;
        }
    }
}
