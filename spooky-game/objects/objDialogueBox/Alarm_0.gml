/// @function Alarm 0
/// @desc manages spacebar input and ensures the correct game flow when advancing the game
/// @return none

if (global.textFullyDisplayed && global.canProceed) {
    if (choice) {
        //handle option selection based on NPC context
        if (objPlayer.isTalkingToLibrarian) {
            submitLibrarianAction(selected);  //process librarian actions
        } else if (objPlayer.isTalkingToJanitor) {
            submitJanitorAction(selected);  //process janitor actions
        }
    } else {
        self.alarm[2] = 1;
    }
}
