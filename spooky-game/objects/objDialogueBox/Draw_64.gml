/// @function Draw GUI
/// @desc delegates drawing of the dialogue box and text to the DialogueBox struct
/// @return none

//call draw method of dialogueBoxInstance (text/box rendering)
if (global.dialogueBoxInstance != undefined) {
    global.dialogueBoxInstance.draw();  //render dialogue box, text, and options
}
