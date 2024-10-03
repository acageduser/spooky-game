/// @function interactWithPedestal
/// @desc handles interaction with the pedestal, checking if the player has the cursed book and whether the ritual is complete
/// @return none

function interactWithPedestal() {
    //check if the pedestal is empty
    if (!global.pedestalOccupied) {
        if (global.hasCursedBook) {
            //player has the cursed book and places it on the pedestal
            objDialogueBox.setDialogue("You place the Cursed Book on the pedestal. The ritual is complete.");  //ritual completes
            global.pedestalOccupied = true;  //update pedestal state
        } else {
            //pedestal is empty but player lacks the cursed book
            objDialogueBox.setDialogue("The pedestal is empty.");  //no action without cursed book
        }
    } else {
        //pedestal already occupied, ritual completed
        objDialogueBox.setDialogue("The ritual is already complete.");  //no further action
    }
}
