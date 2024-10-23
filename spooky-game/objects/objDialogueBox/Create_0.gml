/// @function Create
/// @desc initializes the dialogue box and checks for the global struct
/// @return none

//check if DialogueManager created dialogueBoxInstance
if (!variable_global_exists("dialogueBoxInstance") || global.dialogueBoxInstance == undefined) {
    show_debug_message("DialogueBoxInstance not initialized. Waiting for DialogueManager.");  //debug missing instance
    instance_destroy();  //prevent crashes by destroying obj
    exit;  //stop execution to avoid errors
} else {
    show_debug_message("DialogueBoxInstance found. Proceeding with dialogue setup.");  //debug found instance
}

//reset global flags for dialogue interaction
global.textFullyDisplayed = false;  //reset text display flag
global.canProceed = false;  //disable proceeding until text fully shown
global.showSpacebarPrompt = false;  //hide spacebar prompt initially
