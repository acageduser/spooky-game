/// @function Step
/// @desc Handles interaction with bookshelf 3
/// @param None

var bookshelf_distance = distance_to_object(objPlayer);

// Check if the player is close enough to interact with the bookshelf and presses the 'F' key
if (bookshelf_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    // Set the dialogue context to 'bookshelf'
    global.currentDialogueContext = "bookshelf";

    // Ensure the dialogue box is created
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  // Create dialogue box on the correct layer
    }

    // Check if both book flags have been unlocked
    if (global.unlockHauntedBookshelfLibrarianHalf == true && global.unlockHauntedBookshelfJanitorHalf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and the bookshelf collapses!");  //bookshelf destruction message
        // Destroy the current instance of objBookshelf3
        instance_destroy();  // Destroy this bookshelf (current instance)
		// needs to destroy the dialogue box here
		
    } else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");  //no action taken
    }
}
