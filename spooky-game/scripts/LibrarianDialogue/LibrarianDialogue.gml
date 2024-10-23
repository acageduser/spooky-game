/// @function LibrarianDialogue
/// @desc Handles dialogue interactions with the librarian NPC
/// @param {object} _player - The player interacting with the librarian
/// @return none

function LibrarianDialogue(_player) constructor { 
    var parent = Dialogue(_player, global.dialogueBoxInstance);  //initialize parent dialogue struct

    // Copy parent methods and properties to this struct
    dialogueBox = parent.dialogueBox;  //inherit dialogue box
    player = parent.player;  //inherit player reference

    // Additional properties specific to LibrarianDialogue
    dialogueBranch = 0;  //track dialogue progress
    disabled = false;  //flag to disable dialogue after completion

    // Override displayMenu method
    displayMenu = function() {
        if (disabled) {
            //show final dialogue once player completes librarian tasks
            dialogueBox.initializeDialogue("You have done all that you can for us...but you are still here, aren't you? Look into the mirror, and you will see your true self. Only then can you escape.", ["Quit"]);
            global.librarianDisabled = true;  //disable further interactions
            return;  //exit method after showing dialogue
        }

        if (dialogueBranch == 0) {
            //initial dialogue branch for first interaction
            dialogueBox.initializeDialogue("Hello there! How may I help you?", ["Who are you?", "Walk away"]);
        } else if (dialogueBranch == 1) {
            //show second dialogue branch with more options
            var options = ["What happens if I light the lantern?", "What do you know about the bookshelf?", "Quit"];
            dialogueBox.initializeDialogue("There is another spirit here, cursed to endlessly toil. To free him, you must light the lantern that he cannot. But be warned, the flame required is not of this world.", options);
        }
    };

    // Override submitAction method
    submitAction = function(choice) {
        if (dialogueBranch == 0) {
            //process choices for the first dialogue branch
            switch (choice) {
                case 0:
                    dialogueBox.initializeDialogue("I am the keeper of this place, bound to it for eternity...unless someone helps me find peace.");
                    dialogueBranch = 1;  //advance dialogue branch
                    player.isTalkingToLibrarian = false;  //end interaction
                    break;
                case 1:
                    player.isTalkingToLibrarian = false;  //end interaction
                    global.currentDialogue = undefined;  //close dialogue
                    global.dialogueBoxInstance = undefined;  //clear dialogue box
                    break;
            }
        } else if (dialogueBranch == 1) {
            //process choices for the second dialogue branch
            switch (choice) {
                case 0:
                    dialogueBox.initializeDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.");
                    break;
                case 1:
                    dialogueBox.initializeDialogue("All I know is that the Blue book comes after the Red book.");
                    global.unlockHauntedBookshelfLibrarianHalf = true;  //unlock librarian's part of the bookshelf puzzle
                    break;
                case 2:
                    player.isTalkingToLibrarian = false;  //end interaction
                    global.currentDialogue = undefined;  //close dialogue
                    global.dialogueBoxInstance = undefined;  //clear dialogue box
                    break;
            }
        }
    };
}
