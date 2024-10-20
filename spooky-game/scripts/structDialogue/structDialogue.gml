// structDialogue.gml

// Parent Dialogue Struct
function Dialogue(_player, _dialogueBox) constructor {
    // Common attributes
    player = _player;              // Reference to the player instance
    dialogueBox = _dialogueBox;    // Reference to the dialogue box instance

    // Common methods (to be overridden by child structs)
    displayMenu = function() {};
    submitAction = function(choice) {};
}

// Janitor Dialogue Struct
function JanitorDialogue(_player, _dialogueBox) : Dialogue(_player, _dialogueBox) constructor {
    // Attributes specific to JanitorDialogue
    dialogueBranch = 0;
    disabled = false;

    // Override displayMenu method
    displayMenu = function() {
        if (disabled) {
            dialogueBox.setDialogue("The janitor has moved on and can no longer be spoken to.", ["Quit"]);
            return;
        }

        if (dialogueBranch == 0) {
            dialogueBox.setDialogue("Oh, you startled me! I'm the janitor here. I've been sweeping these floors for as long as I can remember.", ["What happened to you?", "Quit"]);
        } else if (dialogueBranch == 1) {
            var options = ["What's with the bookshelf?", "Quit"];
            if (global.lanternLit) {
                array_push(options, "Are you free?");
            }
            dialogueBox.setDialogue("What would you like to ask?", options);
        } else if (dialogueBranch == 2) {
            dialogueBox.setDialogue("What should I do now?", ["Goodbye"]);
        }
    };

    // Override submitAction method
    submitAction = function(choice) {
        if (dialogueBranch == 0) {
            switch (choice) {
                case 0:
                    dialogueBox.setDialogue("A mishap with the lantern... I'm cursed to sweep these floors for all eternity.");
                    dialogueBranch = 1;
                    player.isTalkingToJanitor = false;
                    break;
                case 1:
                    player.isTalkingToJanitor = false;
                    break;
            }
        } else if (dialogueBranch == 1) {
            switch (choice) {
                case 0:
                    dialogueBox.setDialogue("That bookshelf hides a powerful book. The Yellow book must come last and the Green book comes after Blue.");
                    global.unlockHauntedBookshelfJanitorHalf = true;
                    break;
                case 1:
                    player.isTalkingToJanitor = false;
                    break;
                case 2:
                    if (global.lanternLit) {
                        dialogueBox.setDialogue("Yes, at last I can finally move on from this place. Thank you. Please speak with the Librarian now.");
                        dialogueBranch = 2;
                        disabled = true;
                        global.janitorDisabled = true;
                    }
                    break;
            }
        } else if (dialogueBranch == 2) {
            if (choice == 0) {
                dialogueBox.setDialogue("Goodbye.");
                player.isTalkingToJanitor = false;
            }
        }
    };
}

// Librarian Dialogue Struct
function LibrarianDialogue(_player, _dialogueBox) : Dialogue(_player, _dialogueBox) constructor {
    // Attributes specific to LibrarianDialogue
    dialogueBranch = 0;
    disabled = false;

    // Override displayMenu method
    displayMenu = function() {
        if (disabled) {
            dialogueBox.setDialogue("You have done all that you can for us...but you are still here, aren't you? Look into the mirror, and you will see your true self. Only then can you escape. Thank you for setting me free... It is time to set yourself free...", ["Quit"]);
            global.librarianDisabled = true;
            return;
        }

        if (dialogueBranch == 0) {
            dialogueBox.setDialogue("Hello there! How may I help you?", ["Who are you?", "Walk away"]);
        } else if (dialogueBranch == 1) {
            dialogueBox.setDialogue("I cannot help myself... However, there is another spirit here, cursed to endlessly toil. To free him, you must light the lantern that he cannot. But be warned, the flame required is not of this world.", ["What happens if I light the lantern?", "What do you know about the bookshelf?", "Quit"]);
        } else if (dialogueBranch == 2) {
            dialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.", ["What happens if I light the lantern?", "Quit"]);
        }
    };

    // Override submitAction method
    submitAction = function(choice) {
        if (dialogueBranch == 0) {
            switch (choice) {
                case 0:
                    dialogueBox.setDialogue("I am the keeper of this place, bound to it for eternity...unless someone helps me find peace.");
                    dialogueBranch = 1;
                    player.isTalkingToLibrarian = false;
                    break;
                case 1:
                    player.isTalkingToLibrarian = false;
                    break;
            }
        } else if (dialogueBranch == 1) {
            switch (choice) {
                case 0:
                    dialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.");
                    break;
                case 1:
                    dialogueBox.setDialogue("All I know is that the Blue book comes after the Red book.");
                    global.unlockHauntedBookshelfLibrarianHalf = true;
                    break;
                case 2:
                    player.isTalkingToLibrarian = false;
                    break;
            }
        }
    };
}

// Mirror Dialogue Struct
function MirrorDialogue(_player, _dialogueBox) : Dialogue(_player, _dialogueBox) constructor {
    // Override displayMenu method
    displayMenu = function() {
        if (global.librarianDisabled && global.janitorDisabled) {
            dialogueBox.setDialogue("You look into the mirror and realize there is no reflection... Just as the Librarian and Janitor, you too are but a lost spirit. As the truth settles and you accept your fate, a strange power awakens within you... You can now phase through walls.", ["Continue"]);
            global.wallPhase = true;
            array_push(global.inventory, "Wall Phase Ability");
        } else {
            dialogueBox.setDialogue("It's just a dusty mirror...", ["Continue"]);
        }
    };

    // Override submitAction method
    submitAction = function(choice) {
        player.isInteracting = false;
    };
}

// Bookshelf Dialogue Struct
function BookshelfDialogue(_player, _dialogueBox) : Dialogue(_player, _dialogueBox) constructor {
    // Override displayMenu method
    displayMenu = function() {
        if (global.unlockHauntedBookshelfJanitorHalf && global.unlockHauntedBookshelfLibrarianHalf) {
            dialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book. You open it up and learn to chant a curse to light a lantern...", ["Take the Cursed Book"]);
        } else if (global.unlockHauntedBookshelfJanitorHalf || global.unlockHauntedBookshelfLibrarianHalf) {
            dialogueBox.setDialogue("You learned the order of two books... But the other two colors remain a mystery!", ["Continue"]);
        } else {
            dialogueBox.setDialogue("The bookshelf looks ordinary.", ["Continue"]);
        }
    };

    // Override submitAction method
    submitAction = function(choice) {
        if (global.unlockHauntedBookshelfJanitorHalf && global.unlockHauntedBookshelfLibrarianHalf) {
            if (choice == 0) { // "Take the Cursed Book"
                global.hasCursedBook = true;
                array_push(global.inventory, "Cursed Book");
                show_debug_message("Cursed Book added to inventory.");
            }
        }
        player.isInteracting = false;
    };
}
