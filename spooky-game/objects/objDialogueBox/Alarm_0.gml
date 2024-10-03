/// @description Handles the transition between text and the next action

if (!is_undefined(global.JanitorDisabled) && choice) {
    if (objPlayer.isTalkingToLibrarian) {
        submitLibrarianAction(selected);
    } else if (objPlayer.isTalkingToJanitor) {
        submitJanitorAction(selected);
    } else {
        if (global.librarianDisabled && selected == 2) {
            selected = -1;
        } else if (global.JanitorDisabled && selected == 3) {
            selected = -1;
        } else {
            submitPlayerAction(selected);
        }
    }
} else { 
    // If no choices presented, display Actions Menu by default
    displayActionsMenu();
}
