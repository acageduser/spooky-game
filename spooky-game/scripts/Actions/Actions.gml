/// @function displayActionsMenu
/// @desc displays the main actions menu and resets player state
/// @return none

global.actionOptions = [  
    "Check the broken bookshelves",           //option to open door
    "Inspect Mirror",       //option to inspect mirror
    "Speak to Librarian",   //option to speak to librarian
    "Speak to Janitor",     //option to speak to janitor
    "Interact with Bookshelf",  //option to interact with bookshelf
    "Inspect Pedestal",     //option to inspect pedestal
    "Inspect Lantern",      //option to inspect lantern
    "Exit the Room"         //option to exit room
];

/// @function removeItemFromInventory
/// @desc Removes the first item from the player's inventory
/// @return none
function removeItemFromInventory() {
    if (array_length(global.inventory) > 0) {  // Ensure inventory is not empty
        show_debug_message("Inventory before attempting to remove: " + string(global.inventory));
        show_debug_message("Inventory is of type: " + typeof(global.inventory));
        
        global.inventory = array_delete(global.inventory, 0, 1);  // Remove the first item (Cursed Book)
        show_debug_message("First item removed from inventory.");
        show_debug_message("Inventory after removal: " + string(global.inventory));  // Show updated inventory
    } else {
        show_debug_message("Inventory is empty.");
    }
}







// Function to display the current inventory in plain text
function getInventoryText() {
    if (array_length(global.inventory) == 0) {
        return "Your inventory is empty.";  // Display this message if the player has no items
    } else {
        var inventoryText = "Inventory: ";
        for (var i = 0; i < array_length(global.inventory); i++) {
            inventoryText += global.inventory[i];  // Add each item to the inventory list
            if (i < array_length(global.inventory) - 1) {
                inventoryText += ", ";  // Add a comma between items, but not after the last item
            }
        }
        return inventoryText;
    }
}

function displayActionsMenu() {
    objPlayer.isTalkingToLibrarian = false;  //reset librarian interaction state
    objPlayer.isTalkingToJanitor = false;  //reset janitor interaction state
    global.currentDialogueState = "actions";  //set dialogue state to actions
    
    var inventoryText = "Inventory: ";
    
    if (array_length(global.inventory) > 0) {
        for (var i = 0; i < array_length(global.inventory); i++) {
            inventoryText += global.inventory[i] + ", ";  // Add each item to the inventory text
        }
        inventoryText = string_delete(inventoryText, string_length(inventoryText) - 1, 1);  // Remove last comma
    } else {
        inventoryText += "Empty";  // If no items in inventory
    }

    // Combine the inventory and action options into the dialogue text
    var dialogueText = "What would you like to do?\n(HINT: Use the mouse to left click on any option. Holding space bar will speed up the text generation speed)\n" + getInventoryText() + "\n";
    
    objDialogueBox.setDialogue(dialogueText, global.actionOptions);  //display options
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
