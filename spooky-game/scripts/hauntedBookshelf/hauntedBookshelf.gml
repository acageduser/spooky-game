/// @function interactWithBookshelf
/// @desc handles the interaction with the haunted bookshelf and checks if the cursed book can be revealed
/// @return none

function interactWithBookshelf() {
    if (global.unlockBookshelf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book.");  //arrange books to reveal cursed book
        global.hasCursedBook = true;  //player now has the cursed book
    } else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");  //no special interaction yet
    }
}
