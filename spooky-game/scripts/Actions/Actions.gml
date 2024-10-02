// Actions.gml

global.actionOptions = ["Open Door", "Inspect Mirror", "Speak to Librarian", "Speak to Janitor"];

function displayActionsMenu() {
    // Resetting the player's state to avoid interaction bleed
    objPlayer.isTalkingToLibrarian = false;
    objPlayer.isTalkingToJanitor = false;
    global.currentDialogueState = "actions";  // Track current state
    
    objDialogueBox.setDialogue("What would you like to do?", global.actionOptions);
}

function submitPlayerAction(choice) {
    switch (global.currentDialogueState) {
        case "actions":
            switch (choice) {
                case 0:
                    openDoor();  // Call the openDoor script
                    break;
                case 1:
                    inspectMirror();  // Call the inspectMirror script
                    break;
                case 2:
                    displayLibrarianMenu();  // Move to librarian dialogue
                    objPlayer.isTalkingToLibrarian = true;
                    global.currentDialogueState = "librarian";
                    break;
                case 3:
                    displayJanitorMenu();  // Move to janitor dialogue
                    objPlayer.isTalkingToJanitor = true;
                    global.currentDialogueState = "janitor";
                    break;
            }
            break;

        case "janitor":
            submitJanitorAction(choice);
            break;

        case "librarian":
            submitLibrarianAction(choice);
            break;

        case "bookshelf":
            interactWithBookshelf();
            break;

        case "pedestal":
            interactWithPedestal();
            break;

        case "lantern":
            interactWithLantern();
            break;

        case "exitRoom":
            tryToExitRoom();
            break;

        case "mirror":
            inspectMirror();
            break;
    }
}
