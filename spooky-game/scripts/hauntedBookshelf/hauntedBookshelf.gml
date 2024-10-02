// hauntedBookshelf.gml

function interactWithBookshelf() {
    if (global.unlockBookshelf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book.");
        global.hasCursedBook = true;  // The player obtains the Cursed Book
    } else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");
    }
}
