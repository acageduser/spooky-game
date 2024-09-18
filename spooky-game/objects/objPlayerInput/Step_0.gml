/// @description Insert description here
// You can write your code in this editor
if (!variable_global_exists("player_name")) {
    global.player_name = "";  // Initialize the name as an empty string
}

// Max characters for the name
var max_characters = 12;

// Handle keyboard input for text
var input = keyboard_string;  // GameMaker stores the typed characters in keyboard_string

// Limit the number of characters
if (string_length(input) > max_characters) {
    input = string_copy(input, 1, max_characters);  // Limit input to the max_characters
    keyboard_string = input;
}

// Store the input in the global player_name variable
global.player_name = input;

// Detect the Enter key to finish input
if (keyboard_check_pressed(vk_enter)) {
    // Transition to the next room or continue the game after input
    room_goto(roomGame);  // Replace `rm_next` with the actual room to go to after input
}