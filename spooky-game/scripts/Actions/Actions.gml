// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Actions.gml

global.actionOptions = ["Open Door", "Inspect Mirror", "Speak to Librarian", "Speak to Janitor"];

function displayActionsMenu() {
    objDialogueBox.setDialogue("What would you like to do?", global.actionOptions);
}

function submitPlayerAction(choice) {
    switch (choice) {
        case 0:
            openDoor();
            break;
        case 1:
            inspectMirror();
            break;
        case 2:
            displayLibrarianMenu();
            objPlayer.isTalkingToLibrarian = true;
            break;
        case 3:
            displayJanitorMenu();
            objPlayer.isTalkingToJanitor = true;
            break;
    }
}

function openDoor() {
    if (global.wallPhase == true) {
        objDialogueBox.setDialogue("You phase through the bookshelf and leave the library.");
        // End game sequence
    } else {
        objDialogueBox.setDialogue("The door is blocked by the bookshelf. I can't get through.");
    }
}

function inspectMirror() {
    if (global.librarianDisabled == true && global.janitorDisabled == true) {
        objDialogueBox.setDialogue("You look into the mirror and realize there is no reflection... A strange power awakens within you.");
        global.wallPhase = true;  // Unlock Wall Phase ability
    } else {
        objDialogueBox.setDialogue("It's just a dusty mirror...");
    }
}
