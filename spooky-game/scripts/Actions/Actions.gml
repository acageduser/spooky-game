/// @function displayActionsMenu
/// @desc displays the main actions menu and resets player state
/// @return none

global.actionOptions = [  
    "Check the broken bookshelves",       // option to check bookshelves
    "Inspect Mirror",                     // option to inspect mirror
    "Speak to Librarian",                 // option to speak to librarian
    "Speak to Janitor",                   // option to speak to janitor
    "Interact with Bookshelf",            // option to interact with bookshelf
    "Inspect Pedestal",                   // option to inspect pedestal
    "Inspect Lantern",                    // option to inspect lantern
    "Exit the Room"                       // option to exit room
];

/// @function removeItemFromInventory
/// @desc removes the first item from the player's inventory
/// @return none
function removeItemFromInventory() {
    if (array_length(global.inventory) > 0) {  // check if inventory isn't empty
        show_debug_message("Inventory before attempting to remove: " + string(global.inventory));
        show_debug_message("Inventory is of type: " + typeof(global.inventory));
        
        global.inventory = array_delete(global.inventory, 0, 1);  // remove the first item
        show_debug_message("First item removed from inventory.");
        show_debug_message("Inventory after removal: " + string(global.inventory));  // updated inventory
    } else {
        show_debug_message("Inventory is empty.");
    }
}

/// @function getInventoryText
/// @desc returns a string representation of the player's current inventory
/// @return string - formatted inventory list or empty message
function getInventoryText() {
    if (array_length(global.inventory) == 0) {
        return "Your inventory is empty.";  // message for empty inventory
    } else {
        var inventoryText = "Inventory: ";
        for (var i = 0; i < array_length(global.inventory); i++) {
            inventoryText += global.inventory[i];  // add item to the inventory list
            if (i < array_length(global.inventory) - 1) {
                inventoryText += ", ";  // add comma between items
            }
        }
        return inventoryText;
    }
}

/// @function displayActionsMenu
/// @desc displays the actions menu and handles player inventory display
/// @return none
function displayActionsMenu() {
    objPlayer.isTalkingToLibrarian = false;  // reset librarian state
    objPlayer.isTalkingToJanitor = false;    // reset janitor state
    global.currentDialogueState = "actions";  // set state to actions
    
    var inventoryText = "Inventory: ";
    
    if (array_length(global.inventory) > 0) {
        for (var i = 0; i < array_length(global.inventory); i++) {
            inventoryText += global.inventory[i] + ", ";  // add inventory items
        }
        inventoryText = string_delete(inventoryText, string_length(inventoryText) - 1, 1);  // remove trailing comma
    } else {
        inventoryText += "Empty";  // if inventory is empty
    }

    // Create combined text with inventory and action options
    var dialogueText = "What would you like to do?\n" +
                       "(HINT: Use the mouse to left-click on any option. Holding space bar will speed up the text generation speed)\n" +
                       getInventoryText() + "\n";  // combine inventory and action options

    objDialogueBox.setDialogue(dialogueText, global.actionOptions);  // display dialogue box with options
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
                    openDoor();  // call open door script
                    break;
                case 1:
                    inspectMirror();  // inspect the mirror
                    break;
                case 2:
                    displayLibrarianMenu();  // open librarian dialogue
                    objPlayer.isTalkingToLibrarian = true;
                    global.currentDialogueState = "librarian";  // update state
                    break;
                case 3:
                    displayJanitorMenu();  // open janitor dialogue
                    objPlayer.isTalkingToJanitor = true;
                    global.currentDialogueState = "janitor";  // update state
                    break;
                case 4:
                    interactWithBookshelf();  // interact with bookshelf
                    global.currentDialogueState = "bookshelf";  // update state
                    break;
                case 5:
                    interactWithPedestal();  // interact with pedestal
                    global.currentDialogueState = "pedestal";  // update state
                    break;
                case 6:
                    interactWithLantern();  // interact with lantern
                    global.currentDialogueState = "lantern";  // update state
                    break;
                case 7:
                    tryToExitRoom();  // try to exit room
                    global.currentDialogueState = "exitRoom";  // update state
                    break;
            }
            break;

        case "janitor":
            submitJanitorAction(choice);  // handle janitor actions
            break;

        case "librarian":
            submitLibrarianAction(choice);  // handle librarian actions
            break;

        case "bookshelf":
            interactWithBookshelf();  // handle bookshelf interaction
            break;

        case "pedestal":
            interactWithPedestal();  // handle pedestal interaction
            break;

        case "lantern":
            interactWithLantern();  // handle lantern interaction
            break;

        case "exitRoom":
            tryToExitRoom();  // handle exit room logic
            break;

        case "mirror":
            inspectMirror();  // handle mirror inspection
            break;
    }
}
