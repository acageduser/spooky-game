/// @function Draw GUI
/// @desc draws the dialogue box, text, and handles input for speeding up text and menu options
/// @return none

//set offset to move the box up 55 pixels
var offsetY = 55;
var boxTop = screenH - height - offsetY;
var boxBottom = screenH - offsetY;

//draw the background box for the dialogue
draw_sprite_stretched(sprText_Box, 0, left, boxTop, width, height);

//draw the dialogue text
var currentText = string_copy(text, 1, floor(textProgress));
draw_set_font(fnt_dialogue);
draw_set_color(c_white);

var textX = left + padding;
var textY = boxTop + padding;

draw_text_ext(textX, textY, currentText, -1, width - padding * 2);  //draw the text

//speed up text rendering when spacebar is held
if (textProgress < textLength) {
    if (keyboard_check(vk_space)) {
        textProgress += textSpeed * 4;  //fast-forward text
    } else {
        textProgress += textSpeed;  //normal speed
    }
} else {
    global.textFullyDisplayed = true;  //mark text as fully displayed

    //only show spacebar prompt if it's included in text
    if (string_pos("Press spacebar to continue...", currentText) > 0) {
        global.showSpacebarPrompt = true;  //show spacebar prompt
    }

    //allow spacebar to advance only if prompt is shown
    if (keyboard_check_pressed(vk_space) && global.showSpacebarPrompt) {
        global.showSpacebarPrompt = false;  //reset the prompt

        //handle menu transitions based on NPC context
        if (objPlayer.isTalkingToJanitor) {
            displayJanitorMenu();  //return to janitor menu
        } else if (objPlayer.isTalkingToLibrarian) {
            displayLibrarianMenu();  //return to librarian menu
        } else {
            self.alarm[2] = 1;  //default back to main action menu
        }
    }
}

//handle dialogue choices if fully displayed
if (choice && global.textFullyDisplayed) {
    var optionY = boxBottom - padding - 30;  //start at bottom minus padding
    
    //draw options from bottom to top
    for (var i = array_length(options) - 1; i >= 0; i--) {
        var optionTextWidth = string_width(options[i]);
        var optionX = (screenW / 2) - (optionTextWidth / 2);  //center options horizontally

        //check if mouse is hovering over option
        var mouseOver = (mouse_x >= optionX && mouse_x <= optionX + optionTextWidth 
                        && mouse_y >= optionY && mouse_y <= optionY + 30);

        if (mouseOver) {
            draw_set_color(c_yellow);  //highlight hovered option
            selected = i;  //update selected index
        } else if (i == selected) {
            draw_set_color(c_yellow);  //highlight selected option
        } else {
            draw_set_color(c_white);  //default color
        }

        //draw the option text
        draw_text(optionX, optionY, options[i]);

        optionY -= 30;  //move up for next option
    }

    //handle mouse clicks for selection
    if (mouse_check_button_pressed(mb_left) && selected >= 0) {
		show_debug_message("Option selected: " + string(selected)); // Debug message
        if (objPlayer.isTalkingToJanitor) {
            submitJanitorAction(selected);  //handle janitor dialogue
        } else if (objPlayer.isTalkingToLibrarian) {
            submitLibrarianAction(selected);  //handle librarian dialogue
        } else {
            submitPlayerAction(selected);  //handle general actions
        }
    }
}
