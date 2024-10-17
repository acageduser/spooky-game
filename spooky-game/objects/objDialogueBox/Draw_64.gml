/// @function Draw GUI
/// @desc draws the dialogue box, text, and handles input for speeding up text and menu options
/// @return none

// set offset to move the box up 55 pixels
var offsetY = 55;
var boxTop = screenH - height - offsetY;
var boxBottom = screenH - offsetY;

// draw the background box for the dialogue
draw_sprite_stretched(sprText_Box, 0, left, boxTop, width, height);

// draw the dialogue text
var currentText = string_copy(text, 1, floor(textProgress));  // copy the text up to the current progress
draw_set_font(fnt_dialogue);
draw_set_color(c_white);  // set text color to white

var textX = left + padding;
var textY = boxTop + padding;

// draw the text with extended formatting
draw_text_ext(textX, textY, currentText, -1, width - padding * 2);

// *** Text Rendering Speed Handling ***
if (textProgress < textLength) {
    // speed up text rendering if spacebar is held
    if (keyboard_check(vk_space)) {
        textProgress += textSpeed * 4;  // fast-forward the text rendering
    } else {
        textProgress += textSpeed;  // normal text rendering speed
    }
} else {
    // mark text as fully displayed
    global.textFullyDisplayed = true;

    // check if the spacebar prompt is visible in the text
    if (string_pos("Press spacebar to continue...", currentText) > 0) {
        global.showSpacebarPrompt = true;  // show spacebar prompt
    }

    // handle spacebar input for advancing the dialogue
    if (keyboard_check_pressed(vk_space) && global.showSpacebarPrompt) {
        global.showSpacebarPrompt = false;  // reset spacebar prompt

        // handle transitions based on NPC context
        if (global.isTalkingToJanitor) {
            displayJanitorMenu();  // go to janitor menu
        } else if (global.isTalkingToLibrarian) {
            displayLibrarianMenu();  // go to librarian menu
        } else {
            displayActionsMenu();  // default back to main action menu
        }
    }
}

// *** Dialogue Choices Drawing ***
if (choice && global.textFullyDisplayed) {
    var optionY = boxBottom - padding - 30;  // position options starting from the bottom
    
    // loop through options from bottom to top
    for (var i = array_length(options) - 1; i >= 0; i--) {
        var optionTextWidth = string_width(options[i]);
        var optionX = (screenW / 2) - (optionTextWidth / 2);  // center the options horizontally

        // check if the mouse is hovering over an option
        var mouseOver = (mouse_x >= optionX && mouse_x <= optionX + optionTextWidth 
                        && mouse_y >= optionY && mouse_y <= optionY + 30);

        // highlight the option if hovered or selected
        if (mouseOver) {
            draw_set_color(c_yellow);  // highlight hovered option
            selected = i;  // set the selected index
        } else if (i == selected) {
            draw_set_color(c_yellow);  // highlight selected option
        } else {
            draw_set_color(c_white);  // set color to white for non-selected
        }

        // draw the option text
        draw_text(optionX, optionY, options[i]);

        // move up for the next option
        optionY -= 30;
    }

    // handle mouse click selection for options
    if (mouse_check_button_pressed(mb_left) && selected >= 0) {
        if (global.isTalkingToJanitor) {
            submitJanitorAction(selected);  // process janitor dialogue option
        } else if (global.isTalkingToLibrarian) {
            submitLibrarianAction(selected);  // process librarian dialogue option
        } else {
            submitPlayerAction(selected);  // process general player action
        }
    }
}
