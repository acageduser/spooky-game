/// @description Manages spacebar and ensures correct flow when advancing the game
if (global.textFullyDisplayed && global.canProceed) {
    if (choice) {
        // Handle options selection within a menu
        if (objPlayer.isTalkingToLibrarian) {
            submitLibrarianAction(selected);
        } else if (objPlayer.isTalkingToJanitor) {
            submitJanitorAction(selected);
        } else {
            submitPlayerAction(selected);
        }
    } else {
        // Only show the actions menu if no choices are present
        displayActionsMenu();
    }
}
