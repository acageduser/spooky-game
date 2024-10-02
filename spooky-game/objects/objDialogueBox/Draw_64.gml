/// @description Handles drawing the Dialogue Box object to the GUI Layer

// NOTE: Draw GUI event draws to the GUI layer, as opposed to the regular Draw event, which draws to the room.
// The Draw GUI event uses GUI coordinates (mapped to the window) instead of room coordinates (mapped to the room itself).

// Set offset to move the box and options up by 55 pixels
var offsetY = 55;

// Draw the background box for the dialogue, adjusted to the bottom of the screen and moved up by 55 pixels
var boxTop = screenH - height - offsetY;
var boxBottom = screenH - offsetY;
draw_sprite_stretched(sprText_Box, 0, left, boxTop, width, height);

// Draw the dialogue text
var currentText = string_copy(text, 1, floor(textProgress));
draw_set_font(fnt_dialogue);
draw_set_color(c_white);

var textX = left + padding;
var textY = boxTop + padding;

draw_text_ext(textX, textY, currentText, -1, width - padding * 2);

// Increase textProgress based on speed
if (textProgress < textLength) {
    textProgress += textSpeed;
} else {
    // Text fully displayed, allow spacebar to continue
    if (keyboard_check_pressed(vk_space)) {
        // Handle text progression here (optional logic)
    }
}

// Handle dialogue choices if available
if (choice) {
    // Always start drawing options from a fixed position at the bottom of the dialogue box, moved up by 55 pixels
    var optionY = boxBottom - padding - 30;  // Start at the bottom of the box minus padding, move up a bit for options
    
    // Draw options from bottom to top
    for (var i = array_length(options) - 1; i >= 0; i--) {
        var optionTextWidth = string_width(options[i]);
        var optionX = (screenW / 2) - (optionTextWidth / 2); // Center options horizontally

        // Check if the mouse is hovering over the option
        var mouseOver = (mouse_x >= optionX && mouse_x <= optionX + optionTextWidth 
                        && mouse_y >= optionY && mouse_y <= optionY + 30);

        if (mouseOver) {
            draw_set_color(c_yellow); // Highlight the hovered option
            selected = i;             // Update the selected index
        } else if (i == selected) {
            draw_set_color(c_yellow); // Highlight the selected option
        } else {
            draw_set_color(c_white);  // Normal color
        }

        // Draw the option text
        draw_text(optionX, optionY, options[i]);

        // Move up for the next option
        optionY -= 30; // Adjust the space between options
    }

    // Handle mouse clicks for selection
    if (mouse_check_button_pressed(mb_left) && selected >= 0) {
        // Depending on context, call the appropriate action handler
        if (global.isTalkingToJanitor) {
            submitJanitorAction(selected); // Call Janitor action if in Janitor dialogue
        } else if (global.isTalkingToLibrarian) {
            submitLibrarianAction(selected); // Call Librarian action if in Librarian dialogue
        } else {
            submitPlayerAction(selected);  // Handle general player actions
        }
    }

    // Handle keyboard navigation for selecting options
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
            // Depending on context, call the appropriate action handler
            if (global.isTalkingToJanitor) {
                submitJanitorAction(selected); // Call Janitor action if in Janitor dialogue
            } else if (global.isTalkingToLibrarian) {
                submitLibrarianAction(selected); // Call Librarian action if in Librarian dialogue
            } else {
                submitPlayerAction(selected);  // Handle general player actions
            }
        }
    }
}
