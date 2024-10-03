/// @function inspectMirror
/// @desc handles the interaction with the mirror and checks if the player unlocks a new ability
/// @return none

function inspectMirror() {
    if (global.librarianDisabled == true && global.janitorDisabled == true) {
        objDialogueBox.setDialogue("You look into the mirror and realize there is no reflection... A strange power awakens within you.");  //no reflection triggers wallPhase
        global.wallPhase = true;  //unlock wallPhase ability
    } else {
        objDialogueBox.setDialogue("It's just a dusty mirror...");  //no ability unlocked, normal reflection
    }
}
