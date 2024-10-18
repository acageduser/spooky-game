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

//check if text is still rendering
if (textProgress < textLength) {
    //handle fast-forwarding the text if spacebar is pressed
    if (keyboard_check(vk_space)) {
        textProgress += textSpeed * 4;  //speed up text rendering by 4x
    } else {
        textProgress += textSpeed;  //normal text rendering speed
    }
} else {
    //if text is fully displayed, allow spacebar to progress
    if (!global.textFullyDisplayed) {
        global.textFullyDisplayed = true;
        global.canProceed = true;  //player can now proceed with spacebar
    }

    //check if player presses spacebar to continue and there are no choices
    if (global.canProceed && !choice && global.showSpacebarPrompt && keyboard_check_pressed(vk_space)) {
        instance_destroy();  //destroy dialogue box
    }
}
