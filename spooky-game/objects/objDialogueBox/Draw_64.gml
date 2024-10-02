/// @description Handles drawing the Dialogue Box object to the GUI Layer

// Set offset to move the box and options up by 55 pixels
var offsetY = 55;
var textFullyDisplayed = (textProgress >= textLength);  // Track if text is fully rendered

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


// Handle dialogue choices if available and only when text is fully displayed
if (choice && textFullyDisplayed) {
    var optionY = boxBottom - padding - 30;  // Start at the bottom of the box minus padding
    
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
        if (global.isTalkingToJanitor) {
            submitJanitorAction(selected); // Call Janitor action if in Janitor dialogue
        } else if (global.isTalkingToLibrarian) {
            submitLibrarianAction(selected); // Call Librarian action if in Librarian dialogue
        } else {
            submitPlayerAction(selected);  // Handle general player actions
        }
    }
}
