/// @function interactWithLantern
/// @desc handles the player's interaction with the lantern and checks conditions for lighting it
/// @param none
/// @return none

function interactWithLantern() {
    //ensure dialogue box exists
    if (!instance_exists(objDialogueBox)) {
        instance_create_layer(x, y, "DialogueBox", objDialogueBox);  //create dialogue box instance
    }

    //check if player has cursed book or pedestal is occupied
    if (global.HasCursedBook == true || global.pedestalOccupied == true) {
        if (global.lanternLit == false) {
            //set dialogue for lighting lantern
            objDialogueBox.setDialogue("you light the lantern using the curse from the book. the janitor's eyes go wide...you've freed him. only the librarian remains...");

            //mark lantern as lit
            global.lanternLit = true;
            global.janitorDisabled = true;  //disable janitor dialogue

            //replace unlit lantern with lit version
            with (objLantern) {
                instance_create_layer(x, y, "Lantern", objLanternLit);  //create lit lantern
                instance_destroy();  //destroy unlit lantern
            }
        }
    } else if (global.lanternLit == true) {
        //inform player lantern already lit
        objDialogueBox.setDialogue("the lantern is already lit.");
    } else {
        //inform player no cursed book
        objDialogueBox.setDialogue("the lantern is cold and dark...");  //no action possible
    }
}
