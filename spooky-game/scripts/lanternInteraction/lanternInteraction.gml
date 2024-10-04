/// @function interactWithLantern
/// @desc handles the player's interaction with the lantern and checks conditions for lighting it
/// @return none

function interactWithLantern() {
    if (global.hasCursedBook == true || global.pedestalOccupied == true) {
		if (global.lanternLit == false) {
	        objDialogueBox.setDialogue("You light the lantern using the curse from the book. The janitor's eyes go wide...You've freed him. Only the Librarian remains...");  //light lantern using cursed book
	        global.lanternLit = true;  //lantern is now lit
	        global.janitorDisabled = true;  //janitor is freed
		}
	} else if (global.lanternLit == true) {
	    objDialogueBox.setDialogue("The lantern is already lit.");  //lantern already lit, no action needed
	} else {
	    objDialogueBox.setDialogue("The lantern is cold and dark...");  //can't light lantern without cursed book
	}
}