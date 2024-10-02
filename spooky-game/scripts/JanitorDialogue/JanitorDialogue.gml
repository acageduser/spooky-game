// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// JanitorDialogue.gml

global.janitorDialogueBranch = 0;
global.janitorDisabled = false;

function displayJanitorMenu() {
    if (global.janitorDialogueBranch == 0) {
        objDialogueBox.setDialogue("What happened to you?", ["What's with the bookshelf?", "Tell me about the Green book", "Tell me about the Yellow book"]);
    } else if (global.janitorDialogueBranch == 1) {
        objDialogueBox.setDialogue("The bookshelf holds the Cursed Book. The order of the books is key to freeing the Librarian.", ["What should I do next?", "Goodbye"]);
    }
}

function submitJanitorAction(choice) {
    if (global.janitorDialogueBranch == 0) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("That bookshelf hides a powerful book. The Red book must come first.");
                global.janitorDialogueBranch = 1;
                global.unlockHauntedBookshelf = true;
                break;
            case 1:
                objDialogueBox.setDialogue("The Green book comes after the Blue; it's the bridge between the first and the last.");
                break;
            case 2:
                objDialogueBox.setDialogue("The Yellow book is the final piece. Place it last on the shelf.");
                break;
        }
    } else if (global.janitorDialogueBranch == 1) {
        switch (choice) {
            case 0:
                objDialogueBox.setDialogue("You've freed the librarian. But why are you still here? Place the Cursed Book onto the pedestal to complete the ritual.");
                global.pedestalOccupied = true;
                break;
            case 1:
                objDialogueBox.setDialogue("Goodbye.");
                objPlayer.isTalkingToJanitor = false;
                global.isTalkingToJanitor = false;  // Reset the flag when finished talking to the Janitor
                break;
        }
    }
}
