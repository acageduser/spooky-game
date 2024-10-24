/// @function Dialogue
/// @desc base struct for player and dialogue box interactions
/// @param {object} _player - player instance
/// @param {object} _dialogueBox - dialogue box instance
/// @return none
function Dialogue(_player, _dialogueBox) constructor {
    player = _player; //reference player instance
    dialogueBox = _dialogueBox; //reference dialogue box instance

    //methods for child structs to override
    displayMenu = function() {};
    submitAction = function(choice) {};
}

/// @function DialogueBox
/// @desc handles rendering and managing dialogue text and options
/// @return none
function DialogueBox() constructor {
    //positioning variables
    screenW = display_get_gui_width(); //gui width
    screenH = display_get_gui_height(); //gui height
    margin = 0.7; //margin around box
    padding = 20; //padding inside box
    width = screenW - (margin * 2); //box width
    height = (screenH * 0.8) - (margin * 2); //box height
    top = margin; //top margin
    bottom = screenH - margin; //bottom margin
    left = margin; //left margin
    right = screenW - margin; //right margin

    //text variables
    text = ""; //dialogue text content
    textSpeed = 0.5; //speed for text display
    textProgress = 0; //tracks current text progress
    textLength = 0; //total length of text

    //selection and options variables
    choice = false; //flag for choices
    selected = -1; //tracks selected option
    options = []; //array of choices
    mouseX = 0; //x position of mouse
    mouseY = 0; //y position of mouse

    //global flags
    global.textFullyDisplayed = false; //flag when text is fully displayed
    global.canProceed = false; //flag to allow spacebar to proceed
    global.showSpacebarPrompt = false; //flag for spacebar prompt

    /// @function initializeDialogue
    /// @desc sets the dialogue text and choices
    /// @param {string} _text - dialogue text
    /// @param {array} _choices - array of player choices
    function initializeDialogue (_text, _choices = []) {
        text = _text; //set the dialogue text
	    show_debug_message("Text set to: " + text);  //see what the current text should be
        textProgress = 0; //reset text progress
        textLength = string_length(text); //get text length
        selected = -1; //reset selected option
        choice = (array_length(_choices) > 0); //check if choices exist
        options = _choices; //store choices

        if (choice) {
            global.showSpacebarPrompt = false; //no spacebar prompt for choices
        } else {
            text += "\n\nPress spacebar to continue..."; //prompt for spacebar
            global.showSpacebarPrompt = true; //enable spacebar prompt
        }
    };

    /// @function update
    /// @desc handles dialogue text rendering and input
    /// @return none
    function update () {
        //handle text rendering
        if (textProgress < textLength) {
            if (keyboard_check(vk_space)) {
                textProgress += textSpeed * 8; //speed up text display
            } else {
                textProgress += textSpeed; //normal text display speed
            }
        } else {
            if (!global.textFullyDisplayed) {
                global.textFullyDisplayed = true; //mark text as fully displayed
                global.canProceed = true; //allow player to proceed
            }

            //proceed without choices if spacebar pressed
            if (global.canProceed && !choice && global.showSpacebarPrompt && keyboard_check_pressed(vk_space)) {
                if (global.currentDialogue != undefined) {
                    global.currentDialogue.submitAction(-1); //submit action without choice
                } else {
                    global.isDialogueActive = false; //close dialogue if no actions
                }
            }
        }

        //handle options if choices are available
        if (choice && global.textFullyDisplayed) {
            mouseX = device_mouse_x_to_gui(0); //get mouse x position
            mouseY = device_mouse_y_to_gui(0); //get mouse y position

            var optionY = bottom - padding - 30; //y position for options

            //loop through available options
            for (var i = array_length(options) - 1; i >= 0; i--) {
                var optionTextWidth = string_width(options[i]); //get width of option text
                var optionX = (screenW / 2) - (optionTextWidth / 2); //center option text

                //check if mouse is over option
                var mouseOver = (mouseX >= optionX && mouseX <= optionX + optionTextWidth &&
                                 mouseY >= optionY && mouseY <= optionY + 30);

                if (mouseOver) {
                    selected = i; //update selected option
                }

                optionY -= 30; //move y position up for next option
            }

            //submit action on mouse click
            if (mouse_check_button_pressed(mb_left) && selected >= 0) {
                if (global.currentDialogue != undefined) {
                    global.currentDialogue.submitAction(selected); //submit selected action
                }
            }
        }
    };

    /// @function draw
    /// @desc handles rendering the dialogue box and options
    /// @return none
    function draw () {
        var offsetY = 55; //offset for box position
        var boxTop = screenH - height - offsetY; //top of dialogue box
        var boxBottom = screenH - offsetY; //bottom of dialogue box

        //draw dialogue box background
        draw_sprite_stretched(sprText_Box, 0, left, boxTop, width, height);

        //draw dialogue text
        var currentText = string_copy(text, 1, floor(textProgress)); //get current text to display
        draw_set_font(fnt_dialogue); //set dialogue font
        draw_set_color(c_white); //set text color
        draw_text_ext(left + padding, boxTop + padding, currentText, -1, width - padding * 2); //draw the text

        //draw options if available
        if (choice && global.textFullyDisplayed) {
            var optionY = boxBottom - padding - 30; //y position for options
            for (var i = array_length(options) - 1; i >= 0; i--) {
                var optionTextWidth = string_width(options[i]); //get width of option
                var optionX = (screenW / 2) - (optionTextWidth / 2); //center option text
                var mouseOver = (mouseX >= optionX && mouseX <= optionX + optionTextWidth && mouseY >= optionY && mouseY <= optionY + 30);
                draw_set_color(mouseOver || i == selected ? c_yellow : c_white); //highlight option if hovered
                draw_text(optionX, optionY, options[i]); //draw option text
                optionY -= 30; //move y position up for next option
            }
        }
    };

    return self;
}
