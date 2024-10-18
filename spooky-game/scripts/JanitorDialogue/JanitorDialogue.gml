/// @function displayJanitorMenu
/// @desc displays the janitor dialogue options based on the current state and flags
/// @return none
function displayJanitorMenu() {
	if(instance_exists(objDialogueBox)){
	    if (global.janitorDisabled) {
	        objDialogueBox.setDialogue("The janitor has moved on and can no longer be spoken to.", ["Quit"]);  //handle janitor disabled case
	        return;  //exit the function early
	    }

	    if (global.janitorDialogueBranch == 0) {
	        objDialogueBox.setDialogue("Oh, you startled me! I'm the janitor here. I've been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"]);  //initial dialogue options
	    } else if (global.janitorDialogueBranch == 1) {
	        var options = ["What's with the bookshelf?", "Quit"];  //options for branch 1
	        if (global.lanternLit) {
	            array_push(options, "Are you free?");  //add freedom option if lantern is lit
	        }
	        objDialogueBox.setDialogue("What would you like to ask?", options);  //display updated options
	    } else if (global.janitorDialogueBranch == 2) {
	        objDialogueBox.setDialogue("What should I do now?", ["Goodbye"]);  //final dialogue options
	    }
	}
}

/// @function submitJanitorAction
/// @desc processes the player's selected janitor dialogue option
/// @param {integer} choice - index of the selected option
/// @return none

function submitJanitorAction(choice) {
    if (global.janitorDialogueBranch == 0) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("A mishap with the lantern... I'm cursed to sweep these floors for all eternity.");  //janitor explains his curse
                global.janitorDialogueBranch = 1;  //move to next dialogue branch
				global.isTalkingToJanitor = false;  //exit talking state
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;  //end interaction if "Quit" is chosen
                instance_destroy();  //correct function name
                break;
        }
    } else if (global.janitorDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("That bookshelf hides a powerful book. The Yellow book must come last and the Green book comes after Blue.");  //explanation of bookshelf puzzle
                global.unlockHauntedBookshelfJanitorHalf = true;  //unlock the haunted bookshelf
                show_debug_message("Haunted bookshelf - 2 books have been unlocked.");
                break;
            case 1:
                objPlayer.isTalkingToJanitor = false;  //end interaction if "Quit" is chosen
                instance_destroy();  //correct function name
                break;
            case 2:
                if (global.lanternLit) {
                    objDialogueBox.setDialogue("Yes, at last I can finally move on from this place. Thank you. Please speak with the Librarian now.");  //janitor freed dialogue
                    global.janitorDialogueBranch = 2;  //advance to final branch
                    global.janitorDisabled = true;  //disable further janitor interaction
                }
                break;
        }
    } else if (global.janitorDialogueBranch == 2) {
        if (choice == 0) {
            objDialogueBox.setDialogue("Goodbye.");  //janitor final goodbye
            objPlayer.isTalkingToJanitor = false;  //end interaction
            instance_destroy();  //correct function name
        }
    }
}
