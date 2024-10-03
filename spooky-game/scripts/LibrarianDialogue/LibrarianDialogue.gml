// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.LibrarianDialogueBranch = 0;
global.librarianDisabled = false;

function displayLibrarianMenu() {
    // Check if the librarian is disabled and show final message
    if (global.librarianDisabled) {
        objDialogueBox.setDialogue("Thank you for setting me free."); // Automatically show thank you message
        return; // Exit to prevent any further options
    }

    var options = ["Who are you?", "Walk away"];
    
    if (global.LibrarianDialogueBranch == 0) {
        objDialogueBox.setDialogue("Hello there! How may I help you?", options);
    } else if (global.LibrarianDialogueBranch == 1) {
        options[0] = "What happens if I light the lantern?";
        options[1] = "What do you know about the bookshelf?";
        
        objDialogueBox.setDialogue("I cannot help myself…however there is another spirit here, cursed to endlessly toil. To free him, you must light the lantern that he cannot. But be warned, the flame required is not of this world.", options);
    } else if (global.LibrarianDialogueBranch == 2) {
        options[0] = "What happens if I light the lantern?";
        objDialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.", options);
    }

    // Check if the pedestal is occupied to disable options
    if (global.pedestalOccupied && !global.librarianDisabled) {
        // Disable further dialogue options
        objDialogueBox.setDialogue("Thank you for setting me free."); // Thank you message for freeing
        global.librarianDisabled = true; // Disable further librarian dialogue
    }
}

function submitLibrarianAction(choice) {
    // Check if the librarian is disabled, stop interaction if true
    if (global.librarianDisabled) {
        // Automatically say thank you and exit
        objDialogueBox.setDialogue("Thank you for setting me free.");
        return; // No further actions
    }

    // Handle dialogue based on current branch
    if (global.LibrarianDialogueBranch == 0) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("I am the keeper of this place, bound to it for eternity...unless someone helps me find peace.");
                global.LibrarianDialogueBranch = 1; // Move to the next branch
                break;
            case 1:
                displayActionsMenu(); // Quit option: return to action menu
                global.isTalkingToLibrarian = false; // Exit talking state
                break;
        }
    } else if (global.LibrarianDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.");
                break;
            case 1:
                objDialogueBox.setDialogue("All I know is that the Blue book comes after the Red book.");
                break;
        }
    }

    // After processing the action, check if the pedestal is occupied
    if (global.pedestalOccupied && !global.librarianDisabled) {
        global.librarianDisabled = true; // Disable further librarian dialogue
        objDialogueBox.setDialogue("Thank you for setting me free."); // Automatically show thank you message
    }
}