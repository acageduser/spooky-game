/// @description Initial Dialogue Struct
function InitialDialogue(_player) constructor {
    // Initialize the Dialogue struct (don't need to assign parent)
    Dialogue(_player, global.dialogueBoxInstance);

    // Assign dialogueBox and player directly from global and argument
    dialogueBox = global.dialogueBoxInstance;
    player = _player;

    // Set the initial dialogue as the current active dialogue
    global.currentDialogue = self;
    global.isDialogueActive = true;

    // display the initial dialogue
    displayMenu = function() {
        show_debug_message("Calling initializeDialogue...");

        dialogueBox.initializeDialogue(

	        "You awaken in a dimly lit, spooky library. The air is thick with dust and the faint scent of old books.\n" +
	        "\n\"What the hell happened, where am I...\"\n\n...you mutter. The room is silent except for occasional winds and chilling whispers. " +
	        "Shadows flicker on the walls as if they have a life of their own." +
	        "\n\nIn the center of the room, there's a large, dusty mirror, and two figures...a librarian and a janitor who seem to be the only other inhabitants." +
	        "\n\nPress spacebar to continue..."
        );
    };
	
    submitAction = function(choice) {
        if (choice == -1) {
            // Continue to the next dialogue or close the current dialogue
            show_debug_message("Submit action called with -1. Proceeding...");

            // Mark the dialogue as complete or move on
            global.isDialogueActive = false;
            global.currentDialogue = undefined; // Clear current dialogue
        }
    };


    // Call the displayMenu function to show the dialogue immediately
    displayMenu();
}
