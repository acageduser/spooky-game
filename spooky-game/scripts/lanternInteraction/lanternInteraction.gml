/// @function interactWithLantern
/// @desc handles the player's interaction with the lantern and checks conditions for lighting it
/// @return none

function interactWithLantern() {
    if (global.hasCursedBook == true && global.lanternLit == false) {
        objDialogueBox.setDialogue("You light the lantern using the curse from the book.");  //light lantern using cursed book
        global.lanternLit = true;  //lantern is now lit
        global.janitorDisabled = true;  //janitor is freed
    } else if (global.lanternLit == true) {
        objDialogueBox.setDialogue("The lantern is already lit.");  //lantern already lit, no action needed
    } else {
        objDialogueBox.setDialogue("I need to learn the curse from the Cursed Book to light the lantern.");  //can't light lantern without cursed book
    }
}
