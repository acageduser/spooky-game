/// @description Insert description here
// You can write your code in this editor
global.HasCursedBook = true;

// Set the player's animation to the pickup animation
sprite_index = sprPickUp; // Change to your pickup animation sprite
image_index = 0; // Start at the first frame of the pickup animation
image_speed = 1; // Set animation speed to play

// Destroy the book object
with (other) { // 'other' refers to the instance of objCursedBook
    instance_destroy();
}