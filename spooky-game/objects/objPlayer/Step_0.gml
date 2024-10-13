/// @function Step
/// @desc Handles player movement, animations, diagonal movement with reduced speed, and increases speed if shift is held down.
/// @param None
/// @return None

move_speed = 2;  // Base movement speed
animation_multiplier = 1;  // Base animation multiplier

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

if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    key_count++;
}
if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    key_count++;
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    key_count++;
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    key_count++;
}

// If 3 or more keys are pressed, stop movement and show index 0 (idle down)
if (key_count >= 3) {
    hsp = 0;
    vsp = 0;
    image_index = 0;  // Show idle down frame when too many keys are pressed
} else {
    // Handle input for movement and animations if less than 3 keys are pressed
    var diagonal_movement = false;

    if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
        hsp = move_speed;  // move right
        global.last_direction = 24;  // Track last direction (right)
    }
    if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
        hsp = -move_speed;  // move left
        global.last_direction = 8;  // Track last direction (left)
    }
    if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
        vsp = move_speed;  // move down
        global.last_direction = 0;  // Track last direction (down)
    }
    if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
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
}

// If no keys are pressed or too many keys are pressed, reset to idle frame
if (hsp == 0 && vsp == 0) {
    image_speed = 0;  // stop animation when idle
    image_index = global.last_direction;  // stay on the first frame of the last direction
}
