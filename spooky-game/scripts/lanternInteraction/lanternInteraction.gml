/// @function interactWithLantern
/// @desc handles the player's interaction with the lantern and checks conditions for lighting it
/// @return none

function interactWithLantern() {
    // Ensure that the dialogue box exists
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  // Create dialogue box on the correct layer
    }

    // Check if the player has the cursed book or the pedestal is occupied
    if (global.HasCursedBook == true || global.pedestalOccupied == true) {
        if (global.lanternLit == false) {
            // Set dialogue for lighting the lantern
            objDialogueBox.setDialogue("You light the lantern using the curse from the book. The janitor's eyes go wide...You've freed him. Only the Librarian remains...");

            // Mark the lantern as lit
            global.lanternLit = true;
            global.janitorDisabled = true;  // Janitor is now freed

            // Replace the unlit lantern with the lit version
            with (objLantern) {
                instance_create_layer(x, y, "Lantern", objLanternLit);  // Ensure objLanternLit is the correct object
                instance_destroy();  // Destroy the unlit lantern
            }
        }
    } else if (global.lanternLit == true) {
        // If the lantern is already lit, inform the player
        objDialogueBox.setDialogue("The lantern is already lit.");
    } else {
        // If the conditions are not met, ensure dialogue box exists and inform the player
        objDialogueBox.setDialogue("The lantern is cold and dark...");  // No action without cursed book
    }
}
