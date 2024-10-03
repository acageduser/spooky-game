/// @description Updates text speed and handles spacebar logic
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_y_to_gui(0);

// Check if text is still rendering
if (textProgress < textLength) {
    // Handle fast-forwarding the text if spacebar is pressed
    if (keyboard_check(vk_space)) {
        textProgress += textSpeed * 4;  // Speed up text rendering by 4x
    } else {
        textProgress += textSpeed;  // Normal text rendering speed
    }
} else {
    // If text is fully displayed, handle spacebar press for progressing to the next event
    if (!global.textFullyDisplayed) {
        global.textFullyDisplayed = true;
        global.canProceed = true;  // Now allow player to advance with spacebar
    }
}
