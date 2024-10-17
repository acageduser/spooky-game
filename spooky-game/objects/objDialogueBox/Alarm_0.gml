/// @function Alarm 0
/// @desc manages spacebar input and ensures the correct game flow when advancing the game
/// @return none

// check if text is fully displayed and the player can proceed
if (global.textFullyDisplayed && global.canProceed) {
    if (choice) {
        // handle option selection based on NPC context
        if (objPlayer.isTalkingToLibrarian) {
            submitLibrarianAction(selected);  // process librarian actions
        } else if (objPlayer.isTalkingToJanitor) {
            submitJanitorAction(selected);  // process janitor actions
        } else {
            submitPlayerAction(selected);  // process general player actions
        }
    } else {
        // only show the actions menu if we're not in the intro phase
        if (!global.isIntroDialogue) {
            displayActionsMenu();  // go back to the main actions menu
        }
    }

    // deactivate the dialogue box after progressing
    instance_deactivate_object(objDialogueBox);  // hide dialogue box
    global.textFullyDisplayed = false;  // reset flag for next dialogue
    global.canProceed = false;  // reset proceed state
}
