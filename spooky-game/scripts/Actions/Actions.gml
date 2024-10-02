// Actions.gml

// List of all available routes in the game
global.actionOptions = [
    "Open Door",          // Option to open the door
    "Inspect Mirror",      // Option to inspect the mirror
    "Speak to Librarian",  // Option to talk to the librarian
    "Speak to Janitor",    // Option to talk to the janitor
    "Interact with Bookshelf",  // Option to interact with the haunted bookshelf
    "Inspect Pedestal",    // Option to interact with the pedestal
    "Inspect Lantern",     // Option to interact with the lantern
    "Exit the Room"        // Option to try and exit the room
];

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
                case 4:
                    interactWithBookshelf();  // Call the haunted bookshelf script
                    global.currentDialogueState = "bookshelf";
                    break;
                case 5:
                    interactWithPedestal();  // Call the pedestal interaction script
                    global.currentDialogueState = "pedestal";
                    break;
                case 6:
                    interactWithLantern();  // Call the lantern interaction script
                    global.currentDialogueState = "lantern";
                    break;
                case 7:
                    tryToExitRoom();  // Call the exit room script
                    global.currentDialogueState = "exitRoom";
                    break;
            }
            break;

        case "janitor":
            submitJanitorAction(choice);  // Call janitor's script if player is talking to Janitor
            break;

        case "librarian":
            submitLibrarianAction(choice);  // Call librarian's script if player is talking to Librarian
            break;

        case "bookshelf":
            interactWithBookshelf();  // Call bookshelf interaction script
            break;

        case "pedestal":
            interactWithPedestal();  // Call pedestal interaction script
            break;

        case "lantern":
            interactWithLantern();  // Call lantern interaction script
            break;

        case "exitRoom":
            tryToExitRoom();  // Call the exit room logic script
            break;

        case "mirror":
            inspectMirror();  // Handle the mirror script case again, if needed
            break;
    }
}
