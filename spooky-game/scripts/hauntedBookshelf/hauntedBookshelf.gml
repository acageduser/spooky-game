/// @function interactWithBookshelf
/// @desc handles interaction with the haunted bookshelf, reveals the cursed book, or gives hints based on game progression
/// @return none

function interactWithBookshelf() {
    //check if both parts of the bookshelf are unlocked
    if (global.unlockHauntedBookshelfJanitorHalf == true && global.unlockHauntedBookshelfLibrarianHalf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book. You open it up and learn to chant a curse to light a lantern...");  //reveal cursed book
        global.hasCursedBook = true;  //give player cursed book
        array_push(global.inventory, "Cursed Book");  //add cursed book to inventory
        show_debug_message("Cursed Book added to inventory.");  //log inventory addition
        show_debug_message("Inventory after adding Cursed Book: " + string(global.inventory));  //log updated inventory
    } 
    //check if only one part of the bookshelf is unlocked
    else if ((global.unlockHauntedBookshelfLibrarianHalf == true && global.unlockHauntedBookshelfJanitorHalf == false) || (global.unlockHauntedBookshelfLibrarianHalf == false && global.unlockHauntedBookshelfJanitorHalf == true)) {
        objDialogueBox.setDialogue("You learned the order of two books... But the other two colors remain a mystery!");  //hint at remaining books
    } 
    //default if neither part of the bookshelf is unlocked
    else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");  //no action taken
    }
}
