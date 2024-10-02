/// @description Handles updating text and spacebar actions
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_y_to_gui(0);

// Update textProgress if less than the length of the text
if (textProgress < textLength) {
    textProgress += textSpeed;
} else {
    // When text is fully displayed, start the delay if it hasn't started
    if (!global.textFullyDisplayed) {
        global.textFullyDisplayed = true;
        global.canProceed = false;  // Set the flag to prevent advancing
        alarm[1] = room_speed * 1;  // Set a 1-second alarm
    }
}

// Handle space key press (but only if the 1-second delay has passed)
if (keyboard_check_pressed(vk_space) && global.textFullyDisplayed && global.canProceed) {
    alarm[0] = room_speed * 0.2;  // Proceed to the next action or display menu
}
