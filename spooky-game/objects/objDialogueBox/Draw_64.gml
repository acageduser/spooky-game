/// @description Handles drawing the Dialogue Box object to the GUI Layer

// NOTE: Draw GUI event draws to the GUI layer, as opposed to the regular Draw event, which draws to the room
// The Draw GUI event uses GUI coordinates (mapped to the window) instead of room coordinates (mapped to the room itself).

// Draw the background box for the dialogue
draw_sprite_stretched(sprText_Box, 0, left, top, width, height);

// Draw the dialogue text
var currentText = string_copy(text, 1, textProgress);
draw_set_font(fnt_dialogue);
draw_set_color(c_white);

var textX = left + padding;
var textY = top + padding;

draw_text_ext(textX, textY, currentText, -1, 475); // Line spacing

// Increase textProgress based on speed
if (textProgress < textLength) {
    textProgress += textSpeed;
} else {
    // Text fully displayed, allow spacebar to continue
    if (keyboard_check_pressed(vk_space)) {
        // Handle text progression or selection here
    }
}

// Handle dialogue choices
if (choice) {
    var totalOptionsHeight = array_length(options) * 24;
    var optionY = (bottom + padding) - totalOptionsHeight / 0.5; // Center vertically

    for (var i = 0; i < array_length(options); i++) {
        var optionTextWidth = string_width(options[i]);
        var optionX = (screenW / 2) - (optionTextWidth / 2); // Center horizontally

        // Check if the mouse is hovering over the option
        var mouseOver = (mouse_x >= optionX && mouse_x <= optionX + optionTextWidth 
                        && mouse_y >= optionY && mouse_y <= optionY + 24);

        if (mouseOver) {
            draw_set_color(c_yellow); // Highlight the hovered option
            selected = i;             // Update the selected index
        } else if (i == selected) {
            draw_set_color(c_yellow); // Highlight the selected option
        } else {
            draw_set_color(c_white);  // Normal color
        }

        draw_text(optionX, optionY, options[i]);
        optionY += 24; // Move down for the next option
    }

    // Detect mouse click on the selected option
    if (mouse_check_button_pressed(mb_left) && selected >= 0) {
        if (global.isTalkingToJanitor) {
            submitJanitorAction(selected); // Call Janitor action if in Janitor dialogue
        } else {
            submitPlayerAction(selected);  // Otherwise, handle general player actions
        }
    }

    // Handle keyboard navigation
    if (keyboard_check_pressed(vk_up)) {
        selected -= 1;
        if (selected < 0) selected = array_length(options) - 1; // Wrap around to the last option
    }

    if (keyboard_check_pressed(vk_down)) {
        selected += 1;
        if (selected >= array_length(options)) selected = 0; // Wrap around to the first option
    }

    // Confirm action with space or enter
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        if (selected >= 0) {
            if (global.isTalkingToJanitor) {
                submitJanitorAction(selected); // Call Janitor action if in Janitor dialogue
            } else {
                submitPlayerAction(selected);  // Otherwise, handle general player actions
            }
        }
    }
}
