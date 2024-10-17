/// @function Step
/// @desc Handles player movement, animations, diagonal movement with reduced speed, movement logic for shift key, opposite key press handling, collisions with objects, and depth handling.
/// @param None
/// @return None

// *** Player Movement Section *** 

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
    if (place_meeting(x, y, objSolid)) {  // Adjust objSolid to match your game's collision object
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

    // If any of the corners are colliding with a wall (non-zero tile), stop the movement
    if (collision_top_left != 0 || collision_top_right != 0 || collision_bottom_left != 0 || collision_bottom_right != 0) {
        // Revert player movement if a collision is detected
        x -= hsp;
        y -= vsp;
    }
}

// *** 2.5D Depth Handling with Buffer and Expanded Checking ***

var depth_buffer = 2;  // Small buffer to prevent flipping when close to object edges
var expansion_buffer = 8;  // Additional pixels to check for objects that are "near"

// Expand the area to check by the buffer value
var expanded_x1 = bbox_left - expansion_buffer;
var expanded_x2 = bbox_right + expansion_buffer;
var expanded_y1 = bbox_top - expansion_buffer;
var expanded_y2 = bbox_bottom + expansion_buffer;

// Check if the player is touching or near an object from objSolid, with expanded boundaries
var touched_object = instance_position((expanded_x1 + expanded_x2) / 2, (expanded_y1 + expanded_y2) / 2, objSolid);

if (touched_object != noone) {
    // Get the bottom of the player and the object being touched
    var player_bottom = bbox_bottom;  // Use player's bounding box bottom
    var object_bottom = touched_object.bbox_bottom;  // Use touched object's bounding box bottom

    // Adjust depth based on whether the player is in front of or behind the object
    if (player_bottom > object_bottom + depth_buffer) {
        // Player is in front of the object
        depth = -object_bottom;
    } else if (player_bottom < object_bottom - depth_buffer) {
        // Player is behind the object
        depth = object_bottom;
    }
} else {
    // If no object is touched, default to the player's own depth
    depth = -bbox_bottom;
}


// Apply depth sorting globally to ensure proper layering
sort_depth_by_y();

//Librarian Interaction
var lib_distance = distance_to_object(objLibrarian);

if (!global.librarianDisabled && lib_distance <= 15 && keyboard_check_pressed(ord("F"))){
	show_debug_message("Player can interact with Librarian");
	isTalkingToLibrarian = true;	
	self.alarm[0] = 1;
}

//Janitor Interaction
var jan_distance = distance_to_object(objJanitor);

if (!global.janitorDisabled && jan_distance <= 15 && keyboard_check_pressed(ord("F"))){
	show_debug_message("Player can interact with Janitor");
	isTalkingToJanitor = true;
	self.alarm[0] = 1;
}
	
//Haunted Bookshelf Interaction
var hbs = inst_38BBC3DF;

var hbs_distance = distance_to_object(hbs)

if(hbs_distance <= 15 && keyboard_check_pressed(ord("F"))){
	self.alarm[0] = 1;
	if (global.unlockHauntedBookshelfJanitorHalf == true && global.unlockHauntedBookshelfLibrarianHalf == true) {
        objDialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book. You open it up and learn to chant a curse to light a lantern...");  //reveal cursed book
        hasCursedBook = true;  //give player cursed book
        array_push(global.inventory, "Cursed Book");  //add cursed book to inventory
        show_debug_message("Cursed Book added to inventory.");  //log inventory addition
        show_debug_message("Inventory after adding Cursed Book: " + string(global.inventory));  //log updated inventory
    } 
    //check if only one part of the bookshelf is unlocked
    else if ((global.unlockHauntedBookshelfLibrarianHalf == true && global.unlockHauntedBookshelfJanitorHalf == false) || (global.unlockHauntedBookshelfLibrarianHalf == false && global.unlockHauntedBookshelfJanitorHalf == true)) {
        objDialogueBox.setDialogue("You learned the order of two books... But the other two colors remain a mystery!");  //hint at remaining books
    } 
    //default if neither part of the bookshelf is unlocked
    else {
        objDialogueBox.setDialogue("The bookshelf looks ordinary.");  //no action taken
    }
}
	
//Lantern Interaction
var lan_distance = distance_to_object(objLantern)

if (lan_distance <= 15 && keyboard_check_pressed(ord("F"))) {
		if ((global.lanternLit == false) && (hasCursedBook == true || global.pedestalOccupied == true)) {
	        show_debug_message("You light the lantern using the curse from the book. The janitor's eyes go wide...You've freed him. Only the Librarian remains...");  //light lantern using cursed book
	        global.lanternLit = true;  //lantern is now lit
	        global.janitorDisabled = true;  //janitor is freed
		} else if (global.lanternLit == true) {
	    show_debug_message("The lantern is already lit.");  //lantern already lit, no action needed
		} else {
	    show_debug_message("The lantern is cold and dark...");  //can't light lantern without cursed book
		}
}
	
//Pedestal Interaction
var ped_distance = distance_to_object(objAlter)

if (ped_distance <=15 && keyboard_check_pressed(ord("F")) && !global.pedestalOccupied) {
        if (hasCursedBook) {
            // Player has the Cursed Book and places it on the pedestal
            show_debug_message("You place the Cursed Book on the pedestal. The ritual is complete. You see the Librarian's eyes go wide...");  // Ritual completes
            global.pedestalOccupied = true;  // Update pedestal state
            removeItemFromInventory();  // Remove the Cursed Book from inventory
			global.inventory = [];
            hasCursedBook = false;  // The player no longer has the Cursed Book
            show_debug_message("Cursed Book removed from inventory.");
        } else {
            // Pedestal is empty but player lacks the Cursed Book
            show_debug_message("The pedestal is empty.");  // No action without Cursed Book
        }
}

//Mirror Interaction
var mirror_distance = distance_to_object(objMirror1)

if (mirror_distance <= 15 && keyboard_check_pressed(ord("F"))){
	if (global.librarianDisabled == true && global.janitorDisabled == true) {
        show_debug_message("You look into the mirror and realize there is no reflection... Just as the Librarian and Janitor, you too are but a lost spirit. As the truth settles and you accept your fate, a strange power awakens within you... You can now phase through walls.");  //no reflection triggers wallPhase
        global.wallPhase = true;  //unlock wallPhase ability
        array_push(global.inventory, "Wall Phase Ability");  // Add Wall Phase ability to inventory
        show_debug_message("Wall Phase ability added to inventory.");
    } else {
        show_debug_message("It's just a dusty mirror...");  //no ability unlocked, normal reflection
    }
}
	
//Door Interaction
var door_distance = distance_to_object(objDoor);

if(door_distance <= 15 && keyboard_check_pressed(ord("F"))){
	if (global.wallPhase == true) {
        show_debug_message("You phase through the bookshelf are standing at the door to leave the library.");  //player phases through bookshelf if wallPhase is active
    } else {
        show_debug_message("I can't get through... Peering through the cracks in the bookshelf you can see a door.");  //player is blocked by the bookshelf
    }
}

var distance_to_book = distance_to_object(objCursedBook);
var distance_to_phase = distance_to_object(objPhase)

if (distance_to_book < 1 && global.puzzleComplete = true) { // Adjust the distance threshold as needed
    // Add the cursed book to the player's inventory
    global.HasCursedBook = true;
sprite_index = sprPickUp; // Change to your pickup animation sprite
    image_index = 0; // Reset the animation to the first frame
    image_speed = 0.01; // Set animation speed; adjust as needed
    // Destroy the book object
    with (objCursedBook) {
        instance_destroy();
		alarm[1] = room_speed; // Set the alarm to trigger after 1 second (adjust as needed)
    }
}
if (distance_to_phase < 1 && keyboard_check(vk_space)) { // Adjust the distance threshold as needed
    // Add the cursed book to the player's inventory
    global.wallPhase = true;
sprite_index = sprPickUp; // Change to your pickup animation sprite
    image_index = 0; // Reset the animation to the first frame
    image_speed = 0.1; // Set animation speed; adjust as needed
    // Destroy the book object
    with (objPhase) {
        instance_destroy();
		alarm[1] = room_speed; // Set the alarm to trigger after 1 second (adjust as needed)
    }
}
if (sprite_index == sprPickUp) {
    // Check if the animation is done (depends on your sprite frame count)
    if (image_index >= sprite_get_number(sprPickUp) - 1) {
        // Reset to the idle sprite after the pickup animation
        sprite_index = sprMainCharacter; // Change this to your idle sprite
        image_index = 0; // Reset animation frame
        image_speed = 0; // Stop the animation
    }
}

