/// @function interactWithBookshelf
/// @desc handles the interaction with the haunted bookshelf and checks if the cursed book can be revealed
/// @return none

function interactWithBookshelf() {
    if (global.unlockHauntedBookshelfJanitorHalf == true && global.unlockHauntedBookshelfLibrarianHalf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book. You open it up and learn to chant a curse to light a lantern...");  //arrange books to reveal cursed book
        global.hasCursedBook = true;  //player now has the cursed book
        array_push(global.inventory, "Cursed Book");  // Add Cursed Book to the player's inventory
        show_debug_message("Cursed Book added to inventory.");
		show_debug_message("Inventory after adding Cursed Book: " + string(global.inventory));
    } else if ((global.unlockHauntedBookshelfLibrarianHalf == true && global.unlockHauntedBookshelfJanitorHalf == false) ||(global.unlockHauntedBookshelfLibrarianHalf == false && global.unlockHauntedBookshelfJanitorHalf == true)) {
		objDialogueBox.setDialogue("You learned the order of two books... But the other two colors remain a mystery!");
	}
	else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");  //no special interaction yet
    }
}
