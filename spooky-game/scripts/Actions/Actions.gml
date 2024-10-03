/// @function displayActionsMenu
/// @desc displays the main actions menu and resets player state
/// @return none

global.actionOptions = [  
    "Open Door",           //option to open door
    "Inspect Mirror",       //option to inspect mirror
    "Speak to Librarian",   //option to speak to librarian
    "Speak to Janitor",     //option to speak to janitor
    "Interact with Bookshelf",  //option to interact with bookshelf
    "Inspect Pedestal",     //option to inspect pedestal
    "Inspect Lantern",      //option to inspect lantern
    "Exit the Room"         //option to exit room
];

function displayActionsMenu() {
    objPlayer.isTalkingToLibrarian = false;  //reset librarian interaction state
    objPlayer.isTalkingToJanitor = false;  //reset janitor interaction state
    global.currentDialogueState = "actions";  //set dialogue state to actions
    
    objDialogueBox.setDialogue("What would you like to do?", global.actionOptions);  //display options
}

/// @function submitPlayerAction
/// @desc handles user input based on chosen action
/// @param {integer} choice - index of the chosen action
/// @return none

function submitPlayerAction(choice) {
    switch (global.currentDialogueState) {
        case "actions":
            switch (choice) {
                case 0:
                    openDoor();  //call open door script
                    break;
                case 1:
                    inspectMirror();  //call inspect mirror script
                    break;
                case 2:
                    displayLibrarianMenu();  //open librarian dialogue
                    objPlayer.isTalkingToLibrarian = true;
                    global.currentDialogueState = "librarian";  //update dialogue state
                    break;
                case 3:
                    displayJanitorMenu();  //open janitor dialogue
                    objPlayer.isTalkingToJanitor = true;
                    global.currentDialogueState = "janitor";  //update dialogue state
                    break;
                case 4:
                    interactWithBookshelf();  //call bookshelf interaction script
                    global.currentDialogueState = "bookshelf";  //update dialogue state
                    break;
                case 5:
                    interactWithPedestal();  //call pedestal interaction script
                    global.currentDialogueState = "pedestal";  //update dialogue state
                    break;
                case 6:
                    interactWithLantern();  //call lantern interaction script
                    global.currentDialogueState = "lantern";  //update dialogue state
                    break;
                case 7:
                    tryToExitRoom();  //call exit room script
                    global.currentDialogueState = "exitRoom";  //update dialogue state
                    break;
            }
            break;

        case "janitor":
            submitJanitorAction(choice);  //handle janitor actions
            break;

        case "librarian":
            submitLibrarianAction(choice);  //handle librarian actions
            break;

        case "bookshelf":
            interactWithBookshelf();  //handle bookshelf interaction
            break;

        case "pedestal":
            interactWithPedestal();  //handle pedestal interaction
            break;

        case "lantern":
            interactWithLantern();  //handle lantern interaction
            break;

        case "exitRoom":
            tryToExitRoom();  //handle exit room logic
            break;

        case "mirror":
            inspectMirror();  //handle mirror case
            break;
    }
}
