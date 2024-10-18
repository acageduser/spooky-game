/// @function Step
/// @desc updates text speed and handles spacebar logic
/// @return none

// Disable player movement when dialogue box is active
if (instance_exists(objDialogueBox)) {
    objPlayer.hsp = 0;
    objPlayer.vsp = 0;
}

mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_x_to_gui(0);

// Check if text is still rendering
if (textProgress < textLength) {
    // Handle fast-forwarding the text if spacebar is pressed
    if (keyboard_check(vk_space)) {
        textProgress += textSpeed * 8;  // Speed up text rendering by 8x
    } else {
        textProgress += textSpeed;  // Normal text rendering speed
    }
} else {
    // If text is fully displayed, allow spacebar to progress
    if (!global.textFullyDisplayed) {
        global.textFullyDisplayed = true;
        global.canProceed = true;  // Player can now proceed with spacebar
    }

    // Check if player presses spacebar to continue and there are no choices
    if (global.canProceed && !choice && global.showSpacebarPrompt && keyboard_check_pressed(vk_space)) {
        
        // Check dialogue context before taking action
        if (global.currentDialogueContext == "bookshelf") {
            // If the current context is 'bookshelf', destroy the dialogue box and reset the context
            global.currentDialogueContext = "";
            instance_destroy();  // Destroy dialogue box after bookshelf dialogue
        } 
        else if (global.currentDialogueContext == "librarian") {
            // Only proceed with the librarian dialogue if that is the current context
            submitLibrarianAction(selected);  // Continue librarian dialogue
        } 
        else {
            // If no specific context, just destroy the dialogue box
            instance_destroy();
        }
    }
}
