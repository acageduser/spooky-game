//// @description Handles defining the attributes for the Dialogue Box object

/*** Positioning Variables ***/

//GUI Dimensions
/*** Positioning Variables ***/

//GUI Dimensions
screenW = display_get_gui_width();
screenH = display_get_gui_height();

//Box and text margins
margin = .7;
padding = 20;

//Box Dimensions
width = screenW - (margin * 2);
height = screenH/2 - (margin * 2);

// Adjust the box to be at the top of the screen
top = margin;             // Set top to margin, placing the box at the top of the screen
bottom = top + (height *1.2);     // Set bottom based on top and height
left = margin;             // Left position remains the same
right = screenW - margin;  // Right position remains the same

/*** Text Variables ***/
text = "You awaken in a dimly lit, spooky library. The air is thick with dust and the faint scent of old books.\n" +
       "\"What the hell happened, Where am I?\" you mutter.The room is silent except for occasional winds and chilling whispers.\n" +
	   "Shadows flicker on the walls as if they have a life of their own. In the center of the room, theres a large, dusty mirror, and two figures a librarian and a janitor who to be the only other inhabitants. \n" + 
	   "\n\nPress spacebar to continue...";
	   
//Text Progress
textSpeed = 0.5;
textProgress = 0;
textLength = string_length(text);

/*** Selection and Options Variables ***/
choice = false;
selected = -1;
options = [];
mouseX = 0;
mouseY = 0;

/// @function setDialogue(dialogueText, choices)
/// @desc Applies new dialogue text and possible user choices to DialogueBox and configures them for display.
/// @param {string} dialogueText Text for the DialogueBox (Always Narrator or NPC lines in my example, but can be used for player lines as well)
/// @param {array} [choices] Array of strings indicating the user's possible choices/responses. Empty (or non-included) argument will proceed with spacebar press.
/// @return {undefined}
function setDialogue(dialogueText, choices = []) {
	draw_set_color(c_white);
	text = dialogueText; //Set text to new prompt
	selected = -1;       //Clear any previous user selections
	textProgress = 0;    //Reset textProgress
	
	//Setup Dialogue Box based on whether or not user is presented with a choice
	if (array_length(choices) == 0) { //No choices case
		text += "\n\nPress spacebar to continue..."; //Append user instructions
		choice = false;                              //Indicate no choice
		options = [];	                             //Clear previous user options
	} else { //Choices case
		choice = true;                                              //Indicate choice present
		options = [];												//Clear options array
		array_copy(options, 0, choices, 0, array_length(choices) ); //Populate new user choices
	}//end if
	
	textLength = string_length(text); //Update length of text prompt
	
}//end setDialogue
