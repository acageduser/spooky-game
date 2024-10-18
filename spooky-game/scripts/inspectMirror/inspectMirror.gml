/// @function inspectMirror
/// @desc handles the interaction with the mirror and checks if the player unlocks a new ability
/// @return none

function inspectMirror() {
    if (global.librarianDisabled == true && global.janitorDisabled == true) {
        objDialogueBox.setDialogue("You look into the mirror and realize there is no reflection... Just as the Librarian and Janitor, you too are but a lost spirit. As the truth settles and you accept your fate, a strange power awakens within you... You can now phase through walls.");  //no reflection triggers wallPhase
        global.wallPhase = true;  //unlock wallPhase ability
        array_push(global.inventory, "Wall Phase Ability");  // Add Wall Phase ability to inventory
        show_debug_message("Wall Phase ability added to inventory.");
    } else {
        objDialogueBox.setDialogue("It's just a dusty mirror...");  //no ability unlocked, normal reflection
    }
}
