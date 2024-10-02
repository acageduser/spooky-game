/// @description Insert description here

// Update the mouse coordinates
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_x_to_gui(0);

// Update textProgress if less than the length of the text
if (textProgress < textLength) {
    textProgress += textSpeed;
}

// If space key is pressed, handle skipping or continuing to the next step
if (keyboard_check_pressed(vk_space)) {
    // If the text is not fully displayed, pressing space speeds up the text
    if (textProgress < textLength) {
        textProgress = textLength;  // Fast forward typewriting to display the full message
    } else {
        // Only move forward if the text is fully displayed
        alarm[0] = room_speed * 0.2; // Move to the next screen or action
    }
}
