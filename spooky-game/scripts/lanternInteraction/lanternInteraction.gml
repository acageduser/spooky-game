// lanternInteraction.gml

function interactWithLantern() {
    if (global.hasCursedBook == true && global.lanternLit == false) {
        objDialogueBox.setDialogue("You light the lantern using the curse from the book.");
        global.lanternLit = true;  // Lantern is lit
        global.janitorDisabled = true;  // Janitor freed
    } else if (global.lanternLit == true) {
        objDialogueBox.setDialogue("The lantern is already lit.");
    } else {
        objDialogueBox.setDialogue("I need to learn the curse from the Cursed Book to light the lantern.");
    }
}
