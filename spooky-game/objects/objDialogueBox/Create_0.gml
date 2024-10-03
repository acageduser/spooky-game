//// @description Handles defining the attributes for the Dialogue Box object

global.JanitorDisabled = false;
global.librarianDisabled = false;
global.textFullyDisplayed = false;
global.canProceed = false;
global.hasCursedBook = false;
global.showSpacebarPrompt = false;  // New flag to track when the spacebar prompt is shown

/*** Positioning Variables ***/

// GUI Dimensions
screenW = display_get_gui_width();
screenH = display_get_gui_height();

// Box and text margins
margin = .7;
padding = 20;

// Box Dimensions
width = screenW - (margin * 2);
height = (screenH * 0.8) - (margin * 2);  // Adjusted to make the box take up 80% of the screen's height

// Adjust the box to be at the top of the screen
top = margin;                // Set top to margin, placing the box at the top of the screen
bottom = screenH - margin;    // Extend bottom to be near the bottom of the screen
left = margin;                // Left position remains the same
right = screenW - margin;     // Right position remains the same

/*** Text Variables ***/
text = "You awaken in a dimly lit, spooky library. The air is thick with dust and the faint scent of old books.\n" +
       "\"What the hell happened, Where am I?\" you mutter. The room is silent except for occasional winds and chilling whispers.\n" +
       "Shadows flicker on the walls as if they have a life of their own. In the center of the room, there's a large, dusty mirror, and two figures...a librarian and a janitor who seem to be the only other inhabitants. \n" + 
       "\n\nPress spacebar to continue...";

// Text Progress
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
global.showSpacebarPrompt = false;  // Reset flag

/*** Define function to set dialogue text and options ***/
function setDialogue(dialogueText, choices = []) {
    draw_set_color(c_white);
    text = dialogueText;       // Set new dialogue text
    selected = -1;             // Clear previous selection
    textProgress = 0;          // Reset text progress

    // Setup options based on whether choices are provided
    if (array_length(choices) == 0) {
        text += "\n\nPress spacebar to continue..."; // Append spacebar instructions if no choices
        choice = false;
        options = [];
        global.showSpacebarPrompt = true;  // Only show spacebar prompt in this case
    } else {
        choice = true;
        options = [];
        array_copy(options, 0, choices, 0, array_length(choices)); // Copy options
        global.showSpacebarPrompt = false;  // No spacebar prompt when there are options
    }
    
    textLength = string_length(text); // Update text length
}

/*** Draw Event ***/
draw_self();  // Draw the dialogue box background

// Draw the dialogue text
draw_text_ext(left + padding, top + padding, string_copy(text, 1, floor(textProgress)), -1, width - (padding * 2)); // Adjusted for extended width

// Draw options if available
if (choice) {
    var optionY = bottom - (array_length(options) * 30) - padding;  // Start drawing options above the bottom of the dialogue box
    for (var i = 0; i < array_length(options); i++) {
        // Highlight option if mouse hovers over it
        if (mouse_x > left && mouse_x < right && mouse_y > optionY && mouse_y < optionY + 30) {
            draw_set_color(c_yellow);  // Highlight the hovered option
        } else {
            draw_set_color(c_white);
        }

        // Draw the option
        draw_text(left + padding, optionY, options[i]);

        optionY += 40;  // Space between options
    }

    draw_set_color(c_white);  // Reset color to white
}

/*** Mouse Left Pressed Event ***/
if (choice) {
    var optionY = bottom - (array_length(options) * 30) - padding;  // Same Y coordinate logic as the Draw event
    for (var i = 0; i < array_length(options); i++) {
        // Detect if the mouse is clicking on an option
        if (mouse_x > left && mouse_x < right && mouse_y > optionY && mouse_y < optionY + 30) {
            submitPlayerAction(i);  // Trigger the appropriate action based on the choice
            break;
        }

        optionY += 40;  // Adjust for the next option
    }
}
