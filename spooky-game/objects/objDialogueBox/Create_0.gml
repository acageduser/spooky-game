/// @function Create
/// @desc sets up dialogue text and options for the dialogue box and initializes dialogue state variables.
/// @param dialogueText - the dialogue to display
/// @param [choices] - optional, an array of player choices (if any)
/// @return none

// Set up global dialogue-related variables
global.JanitorDisabled = false;
global.librarianDisabled = false;
global.textFullyDisplayed = false;
global.canProceed = false;
global.hasCursedBook = false;
global.showSpacebarPrompt = false;  // Track when spacebar prompt is shown

// New flag to differentiate between intro and NPC dialogues
global.isIntroDialogue = true;  // Start in intro dialogue mode

/*** Positioning Variables ***/
// Get GUI dimensions
screenW = display_get_gui_width();
screenH = display_get_gui_height();

// Set margins and padding for the dialogue box
margin = 0.7;
padding = 20;

// Set the dialogue box dimensions (adjusted for 80% of screen height)
width = screenW - (margin * 2);
height = (screenH * 0.8) - (margin * 2);  // 80% height adjustment

// Position the dialogue box at the top of the screen
top = margin;                // Top margin
bottom = screenH - margin;    // Bottom margin
left = margin;                // Left stays at margin
right = screenW - margin;     // Right stays at margin

/*** Text Variables ***/
// Initial text for the introduction
text = "You awaken in a dimly lit, spooky library. The air is thick with dust and the faint scent of old books.\n" +
       "\nWhat the hell happened, Where am I... \n\n...you mutter. The room is silent except for occasional winds and chilling whispers. " +
       "Shadows flicker on the walls as if they have a life of their own." +
       "\n\nIn the center of the room, there's a large, dusty mirror, and two figures...a librarian and a janitor who seem to be the only other inhabitants." + 
       "\n\nPress spacebar to continue...";

// Track text progress and speed
textSpeed = 0.5;
textProgress = 0;
textLength = string_length(text);  // Length of the full text

/*** Selection and Options Variables ***/
// Set up variables for options and selection
choice = false;
selected = -1;
options = [];  // Empty by default
mouseX = 0;
mouseY = 0;

/*** Initialize global dialogue flags ***/
global.isTalkingToJanitor = false;
global.isTalkingToLibrarian = false;
global.showSpacebarPrompt = false;  // Reset flag to false

/// @function setDialogue
/// @desc sets new dialogue text and choices for when interacting with NPCs or objects.
/// @param dialogueText - the dialogue to display
/// @param [choices] - optional, array of player choices
/// @return none
function setDialogue(dialogueText, choices = []) {
    draw_set_color(c_white);  // Reset color to white
    text = dialogueText;       // Set the new dialogue text
    selected = -1;             // Reset selection
    textProgress = 0;          // Reset progress of text display

    // Handle player choices if present
    if (array_length(choices) == 0) {
        text += "\n\nPress spacebar to continue...";  // Add spacebar prompt if no choices
        choice = false;  // No choices available
        options = [];    // Clear previous options
        global.showSpacebarPrompt = true;  // Indicate spacebar prompt is active
    } else {
        choice = true;   // Choices are available
        options = [];    // Clear previous options
        array_copy(options, 0, choices, 0, array_length(choices));  // Copy player options
        global.showSpacebarPrompt = false;  // No spacebar prompt when choices are present
    }
    
    textLength = string_length(text);  // Update the length of the new text
}

// After pressing spacebar, the intro dialogue ends and we reset the intro dialogue flag
if (keyboard_check_pressed(vk_space) && global.isIntroDialogue) {
    global.isIntroDialogue = false;  // End the intro phase
    instance_deactivate_object(objDialogueBox);  // Hide the dialogue box until next interaction
}
