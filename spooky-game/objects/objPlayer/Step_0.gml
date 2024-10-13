/// @function Step
/// @desc Handles player movement, animations, diagonal movement with reduced speed, movement logic for shift key, opposite key press handling, collisions with objects, and idle logic.
/// @param None
/// @return None

move_speed = 2;  // Base movement speed
animation_multiplier = 1;  // Base animation multiplier

// Tile size (adjust this based on your actual tile size)
var tile_size = 32;

// Track last direction for idle frame
if (!variable_global_exists("last_direction")) {
    global.last_direction = 0;  // Default to down-facing (row 0)
}

// Check if shift is held to increase speed and animation rate
if (keyboard_check(vk_shift)) {
    move_speed *= 1.5;  // Increase movement speed by 1.5x
    animation_multiplier = 1.5;  // Speed up animation by 1.5x
}

// Reset horizontal and vertical speeds
hsp = 0;
vsp = 0;

// Reset animation frames
var frame_offset = 0;
animation_timer += animation_multiplier;  // Adjust animation timer by multiplier

// Count how many directional keys are pressed
var key_count = 0;

// Track whether opposite directions are pressed
var opposite_directions_pressed = false;

var right_pressed = keyboard_check(vk_right) || keyboard_check(ord("D"));
var left_pressed = keyboard_check(vk_left) || keyboard_check(ord("A"));
var down_pressed = keyboard_check(vk_down) || keyboard_check(ord("S"));
var up_pressed = keyboard_check(vk_up) || keyboard_check(ord("W"));

// Detect if opposite keys are pressed
if (right_pressed && left_pressed) {
    opposite_directions_pressed = true;
}
if (up_pressed && down_pressed) {
    opposite_directions_pressed = true;
}

// Count the number of direction keys pressed
if (right_pressed) key_count++;
if (left_pressed) key_count++;
if (down_pressed) key_count++;
if (up_pressed) key_count++;

// If 3 or more keys or opposite keys are pressed, stop movement and show index 0 (idle down)
if (key_count >= 3 || opposite_directions_pressed) {
    hsp = 0;
    vsp = 0;
    image_index = 0;  // Show idle down frame when too many or opposite keys are pressed
} else {
    // Handle input for movement and animations if less than 3 keys are pressed and no opposite keys
    var diagonal_movement = false;

    if (right_pressed) {
        hsp = move_speed;  // move right
        global.last_direction = 24;  // Track last direction (right)
    }
    if (left_pressed) {
        hsp = -move_speed;  // move left
        global.last_direction = 8;  // Track last direction (left)
    }
    if (down_pressed) {
        vsp = move_speed;  // move down
        global.last_direction = 0;  // Track last direction (down)
    }
    if (up_pressed) {
        vsp = -move_speed;  // move up
        global.last_direction = 16;  // Track last direction (up)
    }

    // Apply diagonal speed reduction if moving both horizontally and vertically
    if (hsp != 0 && vsp != 0) {
        hsp *= 0.8;  // reduce horizontal speed for diagonal movement
        vsp *= 0.8;  // reduce vertical speed for diagonal movement
        diagonal_movement = true;

        // Handle diagonal movement by checking both horizontal and vertical inputs
        if (hsp > 0 && vsp > 0) {
            frame_offset = 28;  // down-right
            global.last_direction = 28;  // Track down-right
        } else if (hsp > 0 && vsp < 0) {
            frame_offset = 20;  // up-right
            global.last_direction = 20;  // Track up-right
        } else if (hsp < 0 && vsp > 0) {
            frame_offset = 4;  // down-left
            global.last_direction = 4;  // Track down-left
        } else if (hsp < 0 && vsp < 0) {
            frame_offset = 12;  // up-left
            global.last_direction = 12;  // Track up-left
        }
    } else if (hsp > 0) {
        frame_offset = 24;  // right
    } else if (hsp < 0) {
        frame_offset = 8;  // left
    } else if (vsp > 0) {
        frame_offset = 0;  // down
    } else if (vsp < 0) {
        frame_offset = 16;  // up
    }

    // Update animation frame
    if (animation_timer >= animation_speed / animation_multiplier) {  // Speed up animation based on shift multiplier
        image_index = frame_offset + (image_index + 1) mod 4;  // loop through 4 frames per row
        animation_timer = 0;  // reset timer
    }

    // Apply movement
    x += hsp;
    y += vsp;

    // ***Collision Check with Objects*** 
    // If there's a collision with a solid object, revert movement
    if (place_meeting(x + hsp, y + vsp, objSolid)) {  // Adjust objSolid to match your game's collision object
        x -= hsp;  // undo horizontal movement if there's a collision
        y -= vsp;  // undo vertical movement if there's a collision
    }
}

// If no keys are pressed or too many/opposite keys are pressed, reset to idle frame
if (hsp == 0 && vsp == 0) {
    image_speed = 0;  // stop animation when idle
    image_index = global.last_direction;  // stay on the first frame of the last direction
}

// *** Tilemap Collision Handling ***

// Get the tilemap of the collision layer
var tilemap = layer_tilemap_get_id(layer_get_id("CollisionLayer"));

var player_width = 42;  // Player sprite width
var player_height = 48;  // Player sprite height
var buffer = 16;  // Allow player to get 16 pixels closer to walls

// If a tilemap exists in the CollisionLayer, check for collision at the player's new position
if (tilemap != -1) {
    // Check collision for all four corners of the player sprite, but allow 16 pixels buffer
    var collision_top_left = tilemap_get_at_pixel(tilemap, x + buffer, y + buffer);  // top-left corner with buffer
    var collision_top_right = tilemap_get_at_pixel(tilemap, x + player_width - buffer, y + buffer);  // top-right corner with buffer
    var collision_bottom_left = tilemap_get_at_pixel(tilemap, x + buffer, y + player_height - buffer);  // bottom-left corner with buffer
    var collision_bottom_right = tilemap_get_at_pixel(tilemap, x + player_width - buffer, y + player_height - buffer);  // bottom-right corner with buffer

    // Debug: Check what tile is being detected at each of the player's corners
    show_debug_message("Top Left: " + string(collision_top_left) + " | Top Right: " + string(collision_top_right));
    show_debug_message("Bottom Left: " + string(collision_bottom_left) + " | Bottom Right: " + string(collision_bottom_right));

    // If any of the corners are colliding with a wall (non-zero tile), stop the movement
    if (collision_top_left != 0 || collision_top_right != 0 || collision_bottom_left != 0 || collision_bottom_right != 0) {
        // Revert player movement if a collision is detected
        x -= hsp;
        y -= vsp;
    }
}
