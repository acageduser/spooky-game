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
                    openDoor();  // Call the new openDoor script
                    break;
                case 1:
                    inspectMirror();  // Call the new inspectMirror script
                    break;
                case 2:
                    displayLibrarianMenu();
                    objPlayer.isTalkingToLibrarian = true;
                    global.currentDialogueState = "librarian";
                    break;
                case 3:
                    displayJanitorMenu();
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
    }
}
