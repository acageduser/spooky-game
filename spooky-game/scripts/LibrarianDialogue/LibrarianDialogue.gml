global.LibrarianDialogueBranch = 0;
global.librarianDisabled = false;

/// @function displayLibrarianMenu
/// @desc displays the librarian's dialogue options based on the current dialogue branch and game state
/// @return none
function displayLibrarianMenu() {
    ////check if librarian is disabled
    //if (global.librarianDisabled) {
    //    objDialogueBox.setDialogue("You’ve done all that you can for her... Look into the mirror...");  //final message if librarian is free
    //    return;  //exit to prevent further options
    //}

    var options = ["Who are you?", "Walk away"];  //initial dialogue options

    //branch 0: initial dialogue
    if (global.LibrarianDialogueBranch == 0) {
        objDialogueBox.setDialogue("Hello there! How may I help you?", options);
    } 
    //branch 1: further dialogue options
    else if (global.LibrarianDialogueBranch == 1) {
        options[0] = "What happens if I light the lantern?";
        options[1] = "What do you know about the bookshelf?";
        objDialogueBox.setDialogue("I cannot help myself... However, there is another spirit here, cursed to endlessly toil. To free him, you must light the lantern that he cannot. But be warned, the flame required is not of this world.", options);
    } 
    //branch 2: additional explanation
    else if (global.LibrarianDialogueBranch == 2) {
        options[0] = "What happens if I light the lantern?";
        objDialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.", options);
    }

    //check if the pedestal is occupied
    if (global.pedestalOccupied && !global.librarianDisabled) {
        objDialogueBox.setDialogue("You have done all that you can for us...but you are still here, aren\'t you? Look into the mirror, and you will see your true self. Only then can you escape. Thank you for setting me free... It is time to set yourself free...");  //final message when pedestal is occupied
        global.librarianDisabled = true;  //disable further dialogue
		//mirror interaction here
		
    }
}

/// @function submitLibrarianAction
/// @desc handles the player's selection during the librarian's dialogue
/// @param choice - player's chosen dialogue option
/// @return none
function submitLibrarianAction(choice) {
    ////check if librarian is disabled
    //if (global.librarianDisabled) {
    //    objDialogueBox.setDialogue("You have done all that you can for us...but you are still here, aren\’t you? Look into the mirror, and you will see your true self. Only then can you escape. Thank you for setting me free... It is time to set yourself free...");  //final message
    //    return;  //exit
    //}

    //branch 0: handle initial interaction
    if (global.LibrarianDialogueBranch == 0) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("I am the keeper of this place, bound to it for eternity...unless someone helps me find peace.");  //introduce self
                global.LibrarianDialogueBranch = 1;  //advance dialogue branch
                break;
            case 1:
                displayActionsMenu();  //quit: return to actions menu
                global.isTalkingToLibrarian = false;  //exit talking state
                break;
        }
    }
    //branch 1: further interaction
    else if (global.LibrarianDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.");  //lantern info
                break;
            case 1:
                objDialogueBox.setDialogue("All I know is that the Blue book comes after the Red book.");  //bookshelf hint
                global.unlockHauntedBookshelfLibrarianHalf = true;  // Unlock the haunted bookshelf
                show_debug_message("Haunted bookshelf - 2 books have been unlocked.");
                break;
        }
    }

//    //check if the pedestal is occupied after interaction
//    if (global.pedestalOccupied && !global.librarianDisabled) {
//        global.librarianDisabled = true;  //disable further dialogue
//        objDialogueBox.setDialogue("You’ve done all that you can for us...but you’re still here, aren’t you? Look into the mirror, and you will see your true self. Only then can you escape. Thank you for setting me free... It is time to set yourself free...");  //final message
//    }
}
