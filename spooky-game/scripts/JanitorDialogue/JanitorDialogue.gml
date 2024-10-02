// JanitorDialogue.gml

// Initializing branches and flags for janitor dialogue
global.janitorDialogueBranch = 0;
global.janitorDisabled = false;
global.unlockBookshelf = false;  // Unlocks after asking about the bookshelf
global.unlockGreenBook = false;  // Unlocks after speaking to the librarian
global.unlockYellowBook = false; // Unlocks after obtaining Green book hint

// Displays the janitor dialogue options based on the current state and unlocked flags
function displayJanitorMenu() {
    // Initial greeting, only shows first time
    if (global.janitorDialogueBranch == 0) {
        objDialogueBox.setDialogue("Oh, you startled me! I\'m the janitor here. I\'ve been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"])
    }
    // After asking "What happened to you?" (Branch 1)
    else if (global.janitorDialogueBranch == 1) {
        var options = ["What's with the bookshelf?", "Quit"];
        if (global.unlockGreenBook) {
            array_push(options, "Tell me about the Green book");
        }
        if (global.unlockYellowBook) {
            array_push(options, "Tell me about the Yellow book");
        }
        objDialogueBox.setDialogue("What would you like to ask?", options);
    }
    // Final sequence dialogue (after returning the Cursed Book)
    else if (global.janitorDialogueBranch == 2) {
        objDialogueBox.setDialogue("What should I do now?", ["Goodbye"]);
    }
}

// Handles the actions based on the player's choice
function submitJanitorAction(choice) {
    if (global.janitorDialogueBranch == 0) {
        switch (choice) {
            case 0:
<<<<<<< HEAD
<<<<<<< Updated upstream
                objDialogueBox.setDialogue("A mishap with the lantern...I\'m cursed to sweep these floors for all eternity.");
                global.janitorDialogueBranch = 1;  // Unlock next set of dialogue
=======
                objDialogueBox.setDialogue("A mishap with the lantern... I\'m cursed to sweep these floors for all eternity.");
                global.janitorDialogueBranch = 1;
>>>>>>> Stashed changes
=======
                objDialogueBox.setDialogue("A mishap with the lantern...I’m cursed to sweep these floors for all eternity.");
                global.janitorDialogueBranch = 1;  // Move to the next branch of the dialogue
>>>>>>> 7e8e16456d896ed1bf200964b3b81831077cb60b
                break;
            case 1:
                // Quit option: return to action menu, but preserve the current state
                objPlayer.isTalkingToJanitor = false;
                displayActionsMenu();  // Return to the action menu without resetting the branch
                break;
        }
    } 
    else if (global.janitorDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("That bookshelf hides a powerful book. The Red book must come first.");
                global.unlockBookshelf = true;  // Unlock bookshelf interaction
                break;
            case 1:
                // Quit option: return to action menu, but preserve the current state
                objPlayer.isTalkingToJanitor = false;
                displayActionsMenu();  // Return to the action menu without resetting the branch
                break;
            case 2:
                if (global.unlockGreenBook) {
                    objDialogueBox.setDialogue("The Green book comes after the Blue; it serves as the bridge between the first and the last.");
                }
                break;
            case 3:
                if (global.unlockYellowBook) {
                    objDialogueBox.setDialogue("The Yellow book is the final piece. Place it last on the shelf.");
                }
                break;
        }
    } 
    else if (global.janitorDialogueBranch == 2) {
        if (choice == 0) {
            objDialogueBox.setDialogue("Goodbye.");
            objPlayer.isTalkingToJanitor = false;
            displayActionsMenu();  // Return to the action menu without resetting the branch
        }
    }
}
