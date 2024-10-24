/// @function Create
/// @desc initializes dialogue manager, creates the dialogue box instance and sets global flags
/// @return none

//initialize global variables for dialogue safely!!!
if (!variable_global_exists("dialogueBoxInstance")) {
    global.dialogueBoxInstance = undefined;
}

if (!variable_global_exists("isDialogueActive")) {
    global.isDialogueActive = false; //dialogue activity flag
}

if (!variable_global_exists("currentDialogueContext")) {
    global.currentDialogueContext = "";  //dialogue context tracking
}

if (!variable_global_exists("textFullyDisplayed")) {
    global.textFullyDisplayed = false;  //flag for fully rendered text
}

if (!variable_global_exists("canProceed")) {
    global.canProceed = false;  //flag for allowing spacebar to proceed
}

if (!variable_global_exists("showSpacebarPrompt")) {
    global.showSpacebarPrompt = false;  //flag for showing spacebar prompt in the first place
}

//create dialogueBoxInstance once, ensure it's not overwritten
if (global.dialogueBoxInstance == undefined) {
    show_debug_message("Initializing DialogueBox in DialogueManager...");
    global.dialogueBoxInstance = new DialogueBox();
} else {
    show_debug_message("DialogueBox already initialized.");  //does it already exist??
}

//create objDialogueBox in DialogueBox layer
instance_create_layer(0, 0, "DialogueBox", objDialogueBox);

var playerInstance = instance_find(objPlayer, 0);  //find player instance

//initialize initial dialogue
global.currentDialogue = new InitialDialogue(playerInstance);

//set isDialogueActive to true to start interaction
global.isDialogueActive = false;
