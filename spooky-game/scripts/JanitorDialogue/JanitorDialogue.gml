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
                objDialogueBox.setDialogue("A mishap with the lantern...I\'m cursed to sweep these floors for all eternity.");
                global.janitorDialogueBranch = 1;  // Unlock next set of dialogue
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;  // Quit option
                break;
        }
    } 
    else if (global.janitorDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("That bookshelf hides a powerful book, but the order of the books must be precise to reveal it. I can\'t free it myself, but I can tell you how. The Red book must come first.");
                global.unlockBookshelf = true;  // Unlock the ability to interact with the bookshelf
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;  // Quit option
                break;
            case 2:
                if (global.unlockGreenBook) {
                    objDialogueBox.setDialogue("The Green book comes after the Blue; it serves as the bridge between the first and the last.");
                    global.unlockYellowBook = true;  // Unlocks the Yellow Book hint
                }
                break;
            case 3:
                if (global.unlockYellowBook) {
                    objDialogueBox.setDialogue("The Yellow book is the final piece. Place it last on the shelf, and the ritual will be complete.");
                }
                break;
        }
    } 
    else if (global.janitorDialogueBranch == 2) {
        if (choice == 0) {
            objDialogueBox.setDialogue("Goodbye.");
            objPlayer.isTalkingToJanitor = false;  // Ending conversation
        }
    }
}
