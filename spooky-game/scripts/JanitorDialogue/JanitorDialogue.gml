// JanitorDialogue.gml

global.janitorDialogueBranch = 0;
global.janitorDisabled = false;

// Unlock flags for dialogue options
global.unlockBookshelf = false;
global.unlockGreenBook = false;
global.unlockYellowBook = false;

function displayJanitorMenu() {
    if (global.janitorDialogueBranch == 0) {
<<<<<<< Updated upstream
        objDialogueBox.setDialogue("Oh, you startled me! I am the janitor here. I have been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"]);
=======
        objDialogueBox.setDialogue("Oh, you startled me! I\'m the janitor here. I\'ve been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"]);
>>>>>>> Stashed changes
    } else if (global.janitorDialogueBranch == 1) {
        var options = ["What's with the bookshelf?", "Quit"];
        if (global.unlockGreenBook) {
            array_push(options, "Tell me about the Green book");
        }
        if (global.unlockYellowBook) {
            array_push(options, "Tell me about the Yellow book");
        }
        objDialogueBox.setDialogue("What would you like to ask?", options);
    } else if (global.janitorDialogueBranch == 2) {
        objDialogueBox.setDialogue("What should I do now?", ["Goodbye"]);
    }
}

function submitJanitorAction(choice) {
    if (global.janitorDialogueBranch == 0) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("A mishap with the lantern... I’m cursed to sweep these floors for all eternity.");
                global.janitorDialogueBranch = 1;
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;
                displayActionsMenu();  // Reset to actions menu
                break;
        }
    } else if (global.janitorDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("That bookshelf hides a powerful book. The Red book must come first.");
                global.unlockBookshelf = true;
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;
                displayActionsMenu();  // Reset to actions menu
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
    } else if (global.janitorDialogueBranch == 2) {
        if (choice == 0) {
            objDialogueBox.setDialogue("Goodbye.");
            objPlayer.isTalkingToJanitor = false;
            displayActionsMenu();  // Reset to actions menu
        }
    }
}
