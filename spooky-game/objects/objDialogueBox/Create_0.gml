/// @function Create
/// @desc sets up dialogue text and options for the dialogue box
/// @param dialogueText - the dialogue to display
/// @param [choices] - optional, an array of player choices (if any)
/// @return none

global.JanitorDisabled = false;
global.librarianDisabled = false;
global.textFullyDisplayed = false;
global.canProceed = false;
global.hasCursedBook = false;
global.showSpacebarPrompt = false;  //track when spacebar prompt is shown



/*** Positioning Variables ***/

//gui dimensions
screenW = display_get_gui_width();
screenH = display_get_gui_height();

//box and text margins
margin = .7;
padding = 20;

//box dimensions
width = screenW - (margin * 2);
height = (screenH * 0.8) - (margin * 2);  //adjusted for 80% screen height

//adjust the box to be at the top of the screen
top = margin;               //top position
bottom = screenH - margin;   //bottom position
left = margin;               //left position stays same
right = screenW - margin;    //right position stays same

/*** Text Variables ***/
text = "You awaken in a dimly lit, spooky library. The air is thick with dust and the faint scent of old books.\n" +
       "\nWhat the hell happened, Where am I... \n\n...you mutter. The room is silent except for occasional winds and chilling whispers. " +
       "Shadows flicker on the walls as if they have a life of their own." +
	   "\n\nIn the center of the room, there's a large, dusty mirror, and two figures...a librarian and a janitor who seem to be the only other inhabitants." + 
	   "\n\nPress spacebar to continue...";

//text progress
textSpeed = 0.5;
textProgress = 0;
textLength = string_length(text);

/*** Selection and Options Variables ***/
choice = false;
selected = -1;
options = [];
mouseX = 0;
mouseY = 0;

/*** Initialize global dialogue flags ***/
global.isTalkingToJanitor = false;
global.isTalkingToLibrarian = false;
global.showSpacebarPrompt = false;  //reset flag

/// @function setDialogue
/// @desc sets new dialogue text and choices
/// @param dialogueText - the dialogue to display
/// @param [choices] - optional, array of player choices
/// @return none
function setDialogue(dialogueText, choices = []) {
    draw_set_color(c_white);  //reset color to white
    text = dialogueText;       //set new dialogue text
    selected = -1;             //clear previous selection
    textProgress = 0;          //reset text progress

    //handle options if present
    if (array_length(choices) == 0) {
        text += "\n\nPress spacebar to continue...";  //add spacebar prompt
        choice = false;  //no choices
        options = [];  //clear previous options
        global.showSpacebarPrompt = true;  //show spacebar prompt
    } else {
        choice = true;  //choices available
        options = [];  //clear previous options
        array_copy(options, 0, choices, 0, array_length(choices));  //copy player options
        global.showSpacebarPrompt = false;  //no spacebar prompt when there are choices
    }
    
    textLength = string_length(text);  //update text length
}

/*** Draw Event ***/
draw_self();  //draw the dialogue box background

//draw the dialogue text
draw_text_ext(left + padding, top + padding, string_copy(text, 1, floor(textProgress)), -1, width - (padding * 2));  //extended width for text

//draw options if available
if (choice) {
    var optionY = bottom - (array_length(options) * 30) - padding;  //start drawing options above the bottom
    for (var i = 0; i < array_length(options); i++) {
        //highlight option if mouse is hovering
        if (mouse_x > left && mouse_x < right && mouse_y > optionY && mouse_y < optionY + 30) {
            draw_set_color(c_yellow);  //highlight hovered option
        } else {
            draw_set_color(c_white);  //normal color
        }

        //draw the option
        draw_text(left + padding, optionY, options[i]);

        optionY += 40;  //space between options
    }

    draw_set_color(c_white);  //reset color
}

/*** Mouse Left Pressed Event ***/
if (choice) {
    var optionY = bottom - (array_length(options) * 30) - padding;  //start at the same Y position as draw event
    for (var i = 0; i < array_length(options); i++) {
        //detect if the mouse clicks on an option
        if (mouse_x > left && mouse_x < right && mouse_y > optionY && mouse_y < optionY + 30) {
            submitPlayerAction(i);  //trigger the corresponding action
            break;
        }

        optionY += 40;  //adjust space for next option
    }
}
