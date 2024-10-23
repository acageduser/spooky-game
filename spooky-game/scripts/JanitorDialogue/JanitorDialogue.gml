/// @function JanitorDialogue
/// @desc Handles dialogue interactions with the janitor NPC
/// @param {object} _player - The player interacting with the janitor
/// @return none

function JanitorDialogue(_player) constructor {
    // Ensure dialogueBoxInstance exists before creating dialogue
    if (!global.dialogueBoxInstance) {
        global.dialogueBoxInstance = new DialogueBox();  // Create new dialogue box instance
    }

    // Call the parent Dialogue constructor directly
    var parent = Dialogue(_player, global.dialogueBoxInstance);

    // Copy parent methods and properties to this struct
    dialogueBox = parent.dialogueBox;  // Inherit dialogue box reference
    player = parent.player;  // Inherit player reference

    // Additional properties specific to JanitorDialogue
    dialogueBranch = 0;  // Track janitor dialogue progression
    disabled = false;  // Flag to disable janitor dialogue after completion

    // Override displayMenu method
    displayMenu = function() {
        if (disabled) {
            dialogueBox.initializeDialogue("The janitor has moved on and can no longer be spoken to.", ["Quit"]);  // Final dialogue after janitor is freed
            return;  // Exit early after displaying dialogue
        }

        if (dialogueBranch == 0) {
            // Initial dialogue branch for first interaction
            dialogueBox.initializeDialogue("Oh, you startled me! I'm the janitor here. I've been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"]);
        } else if (dialogueBranch == 1) {
            var options = ["What's with the bookshelf?", "Quit"];  // Default options
            if (global.lanternLit) {
                array_push(options, "Are you free?");  // Add extra option if lantern is lit
            }
            dialogueBox.initializeDialogue("What would you like to ask?", options);
        } else if (dialogueBranch == 2) {
            dialogueBox.initializeDialogue("What should I do now?", ["Goodbye"]);  // Final goodbye dialogue
        }
    };

    // Override submitAction method
    submitAction = function(choice) {
        if (dialogueBranch == 0) {
            switch (choice) {
                case 0:
                    dialogueBox.initializeDialogue("A mishap with the lantern... I'm cursed to sweep these floors for all eternity.");
                    dialogueBranch = 1;  // Advance dialogue branch
                    player.isTalkingToJanitor = false;  // End interaction
                    break;
                case 1:
                    player.isTalkingToJanitor = false;  // End interaction
                    global.currentDialogue = undefined;  // Clear current dialogue
                    global.dialogueBoxInstance = undefined;  // Clear dialogue box instance
                    break;
            }
        } else if (dialogueBranch == 1) {
            switch (choice) {
                case 0:
                    dialogueBox.initializeDialogue("That bookshelf hides a powerful book. The Yellow book must come last and the Green book comes after Blue.");
                    global.unlockHauntedBookshelfJanitorHalf = true;  // Unlock janitor's part of the bookshelf puzzle
                    show_debug_message("Haunted bookshelf - 2 books have been unlocked.");
                    break;
                case 1:
                    player.isTalkingToJanitor = false;  // End interaction
                    global.currentDialogue = undefined;  // Clear current dialogue
                    global.dialogueBoxInstance = undefined;  // Clear dialogue box instance
                    break;
                case 2:
                    if (global.lanternLit) {
                        dialogueBox.initializeDialogue("Yes, at last I can finally move on from this place. Thank you. Please speak with the Librarian now.");
                        dialogueBranch = 2;  // Advance to final dialogue branch
                        disabled = true;  // Disable janitor interaction
                        global.janitorDisabled = true;  // Set global flag
                    }
                    break;
            }
        } else if (dialogueBranch == 2) {
            if (choice == 0) {
                dialogueBox.initializeDialogue("Goodbye.");
                player.isTalkingToJanitor = false;  // End interaction
                global.currentDialogue = undefined;  // Clear current dialogue
                global.dialogueBoxInstance = undefined;  // Clear dialogue box instance
            }
        }
    };
}
