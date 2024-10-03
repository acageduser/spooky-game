global.janitorDialogueBranch = 0;
global.janitorDisabled = false;
global.unlockBookshelf = false;
global.unlockGreenBook = false;
global.unlockYellowBook = false;
global.lanternLit = false;

// Displays the janitor dialogue options based on the current state and unlocked flags
function displayJanitorMenu() {
    if (global.janitorDisabled) {
        objDialogueBox.setDialogue("The janitor has moved on and can no longer be spoken to.", ["Quit"]);
        return;
    }

    if (global.janitorDialogueBranch == 0) {
        objDialogueBox.setDialogue("Oh, you startled me! I'm the janitor here. I've been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"]);
    } else if (global.janitorDialogueBranch == 1) {
        var options = ["What's with the bookshelf?", "Quit"];
        if (global.unlockYellowBook) {
            array_push(options, "Tell me about the Yellow book");
        }
        if (global.lanternLit) {
            array_push(options, "Are you free?");
        }
        objDialogueBox.setDialogue("What would you like to ask?", options);
    } else if (global.janitorDialogueBranch == 2) {
        objDialogueBox.setDialogue("What should I do now?", ["Goodbye"]);
    }
}

function submitJanitorAction(choice) {
    if (global.janitorDisabled) {
        objPlayer.isTalkingToJanitor = false;
        displayActionsMenu();
        return;
    }

    if (global.janitorDialogueBranch == 0) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("A mishap with the lantern... I'm cursed to sweep these floors for all eternity.");
                global.janitorDialogueBranch = 1;
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;
                displayActionsMenu();
                break;
        }
    } else if (global.janitorDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("That bookshelf hides a powerful book. The Red book must come first and The Green book comes after Blue.");
                global.unlockBookshelf = true;
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;
                displayActionsMenu();
                break;
            case 2:
                if (global.lanternLit) {
                    objDialogueBox.setDialogue("Yes, at last I can finally move on from this place. Thank you.");
                    global.janitorDialogueBranch = 2;
                    global.janitorDisabled = true;  // Disable further janitor dialogue
                }
                break;
        }
    } else if (global.janitorDialogueBranch == 2) {
        if (choice == 0) {
            objDialogueBox.setDialogue("Goodbye.");
            objPlayer.isTalkingToJanitor = false;
            displayActionsMenu();
        }
    }
}