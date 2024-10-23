/// @function Step
/// @desc calls the update method from the DialogueBox struct to handle dialogue text progression and input
/// @return none

//call update method of dialogueBoxInstance (basically just for text/input handling)
if (global.dialogueBoxInstance != undefined) {
    global.dialogueBoxInstance.update();  //process text and handle input
}
