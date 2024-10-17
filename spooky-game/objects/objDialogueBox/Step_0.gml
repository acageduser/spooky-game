/// @function Step
/// @desc updates text speed, handles spacebar logic, and hides the dialogue box after space is pressed
/// @return none

// get mouse coordinates in the gui for interaction
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_x_to_gui(0);

// check if text is still rendering
if (textProgress < textLength) {
    // handle fast-forwarding the text if spacebar is pressed
    if (keyboard_check(vk_space)) {
        textProgress += textSpeed * 4;  // speed up text rendering by 4x
    } else {
        textProgress += textSpeed;  // normal text rendering speed
    }
} else {
    // if text is fully displayed, allow spacebar to progress
    if (!global.textFullyDisplayed) {
        global.textFullyDisplayed = true;  // mark text as fully displayed
        global.canProceed = true;  // player can now proceed with spacebar
    }
}

// *** Additional Logic to Hide Dialogue Box After Spacebar Press ***

// check if the text is fully displayed and ready for progression
if (global.textFullyDisplayed && global.canProceed) {
    // allow spacebar to hide the dialogue box and stop showing it by default
    if (keyboard_check_pressed(vk_space)) {
        global.textFullyDisplayed = false;  // reset flag for next text event
        global.canProceed = false;  // prevent further progression

        // check if we're in the intro or NPC dialogue phase
        if (global.isIntroDialogue) {
            // end the intro dialogue and hide the dialogue box
            global.isIntroDialogue = false;  // intro dialogue is now over
            instance_deactivate_object(objDialogueBox);  // deactivate the dialogue box after intro
        } else {
            // NPC or world interaction phase (keep the dialogue box for NPC interaction)
            instance_deactivate_object(objDialogueBox);  // deactivate the dialogue box until next NPC interaction
        }
    }
}
