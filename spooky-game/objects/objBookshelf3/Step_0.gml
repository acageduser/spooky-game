/// @function Step
/// @desc handles interaction with bookshelf 3
/// @param none

var bookshelf_distance = distance_to_object(objPlayer);  //get distance from player

//check if player close enough and presses 'F'
if (bookshelf_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    global.currentDialogueContext = "bookshelf";  //set dialogue context

    //ensure dialogue box is created
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  //create dialogue box
    }

    //check if both book flags are unlocked
    if (global.unlockHauntedBookshelfLibrarianHalf == true && global.unlockHauntedBookshelfJanitorHalf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and the bookshelf collapses!");  //bookshelf destruction message
        instance_destroy();  //destroy current instance of bookshelf
        //needs to destroy the dialogue box here
    } else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");  //no action taken
    }
}
