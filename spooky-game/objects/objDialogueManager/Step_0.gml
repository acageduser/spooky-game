/// @function Step
/// @desc manages dialogue display and updates dialogue box interactions
/// @return none

//check if dialogue is active
if (global.isDialogueActive) {
    //make sure dialogueBoxInstance even exists before updating
    if (global.dialogueBoxInstance) {
        global.dialogueBoxInstance.update();  //update dialogue box for rendering and input
    }
}
