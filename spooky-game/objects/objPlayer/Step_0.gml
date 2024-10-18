/// @function Step
/// @desc Handles player movement, animations, collisions, and depth handling
/// @param None
/// @return None

// *** Player Movement Section *** 
// Disable player movement if dialogue box is active
if (!instance_exists(objDialogueBox)) {


	move_speed = 2;  //base player speed
	animation_multiplier = 1;  //base animation speed

	//set default direction to down-facing if not set
	if (!variable_global_exists("last_direction")) {
	    global.last_direction = 0;  //default to down
	}

	//check if shift is held for sprint
	if (keyboard_check(vk_shift)) {
	    move_speed *= 1.5;  //1.5x movement speed
	    animation_multiplier = 1.5;  //1.5x animation speed
	}

	//reset speeds
	hsp = 0;
	vsp = 0;

	//reset animation frame
	var frame_offset = 0;
	animation_timer += animation_multiplier;  //adjust by multiplier

	//count how many directional keys pressed
	var key_count = 0;

	//track if opposite directions are pressed
	var opposite_directions_pressed = false;

	var right_pressed = keyboard_check(vk_right) || keyboard_check(ord("D"));
	var left_pressed = keyboard_check(vk_left) || keyboard_check(ord("A"));
	var down_pressed = keyboard_check(vk_down) || keyboard_check(ord("S"));
	var up_pressed = keyboard_check(vk_up) || keyboard_check(ord("W"));

	//check for opposite key presses
	if (right_pressed && left_pressed) {
	    opposite_directions_pressed = true;
	}
	if (up_pressed && down_pressed) {
	    opposite_directions_pressed = true;
	}

	//count direction keys pressed
	if (right_pressed) key_count++;
	if (left_pressed) key_count++;
	if (down_pressed) key_count++;
	if (up_pressed) key_count++;

	//stop if 3+ keys or opposite keys pressed
	if (key_count >= 3 || opposite_directions_pressed) {
	    hsp = 0;
	    vsp = 0;
	    image_index = 0;  //idle frame when no move
	} else {
	    //handle movement if valid key input
	    var diagonal_movement = false;

	    if (right_pressed) {
	        hsp = move_speed;  //move right
	        global.last_direction = 24;  //track last direction
	    }
	    if (left_pressed) {
	        hsp = -move_speed;  //move left
	        global.last_direction = 8;  //track left
	    }
	    if (down_pressed) {
	        vsp = move_speed;  //move down
	        global.last_direction = 0;  //track down
	    }
	    if (up_pressed) {
	        vsp = -move_speed;  //move up
	        global.last_direction = 16;  //track up
	    }

	    //reduce speed for diagonal movement
	    if (hsp != 0 && vsp != 0) {
	        hsp *= 0.8;  //reduce horizontal speed
	        vsp *= 0.8;  //reduce vertical speed
	        diagonal_movement = true;

	        //check which diagonal direction for animations
	        if (hsp > 0 && vsp > 0) {
	            frame_offset = 28;  //down-right
	            global.last_direction = 28;  //track down-right
	        } else if (hsp > 0 && vsp < 0) {
	            frame_offset = 20;  //up-right
	            global.last_direction = 20;  //track up-right
	        } else if (hsp < 0 && vsp > 0) {
	            frame_offset = 4;  //down-left
	            global.last_direction = 4;  //track down-left
	        } else if (hsp < 0 && vsp < 0) {
	            frame_offset = 12;  //up-left
	            global.last_direction = 12;  //track up-left
	        }
	    } else if (hsp > 0) {
	        frame_offset = 24;  //right
	    } else if (hsp < 0) {
	        frame_offset = 8;  //left
	    } else if (vsp > 0) {
	        frame_offset = 0;  //down
	    } else if (vsp < 0) {
	        frame_offset = 16;  //up
	    }

	    //update animation frame
	    if (animation_timer >= animation_speed / animation_multiplier) {
	        image_index = frame_offset + (image_index + 1) mod 4;  //cycle frames
	        animation_timer = 0;  //reset timer
	    }

	    //apply movement
	    x += hsp;
	    y += vsp;

	    // ***Collision Check with Objects*** 
	    //stop player on collision
	    if (place_meeting(x, y, objSolid)) {
	        x -= hsp;  //undo horizontal movement
	        y -= vsp;  //undo vertical movement
	    }
	}
}

//handle idle frame
if (hsp == 0 && vsp == 0) {
    image_speed = 0;  //stop animation when idle
    image_index = global.last_direction;  //stay on last direction
}

// *** Tilemap Collision Handling ***

//get tilemap from collision layer
var tilemap = layer_tilemap_get_id(layer_get_id("CollisionLayer"));

var player_width = 42;  //player sprite width
var player_height = 48;  //player sprite height
var buffer = 16;  //distance to walls

//check if tilemap exists
if (tilemap != -1) {
    //check each corner for collisions
    var collision_top_left = tilemap_get_at_pixel(tilemap, x + buffer, y + buffer);
    var collision_top_right = tilemap_get_at_pixel(tilemap, x + player_width - buffer, y + buffer);
    var collision_bottom_left = tilemap_get_at_pixel(tilemap, x + buffer, y + player_height - buffer);
    var collision_bottom_right = tilemap_get_at_pixel(tilemap, x + player_width - buffer, y + player_height - buffer);

    //stop movement if colliding with tile
    if (collision_top_left != 0 || collision_top_right != 0 || collision_bottom_left != 0 || collision_bottom_right != 0) {
        x -= hsp;  //undo horizontal movement
        y -= vsp;  //undo vertical movement
    }
}

// *** 2.5D Depth Handling with Buffer and Expanded Checking ***

var depth_buffer = 2;  //buffer for depth flipping, avoids flickering
var expansion_buffer = 8;  //expand area to check

//expand area to check
var expanded_x1 = bbox_left - expansion_buffer;
var expanded_x2 = bbox_right + expansion_buffer;
var expanded_y1 = bbox_top - expansion_buffer;
var expanded_y2 = bbox_bottom + expansion_buffer;

//check if touching objSolid
var touched_object = instance_position((expanded_x1 + expanded_x2) / 2, (expanded_y1 + expanded_y2) / 2, objSolid);

if (touched_object != noone) {
    //get player and object bottom values
    var player_bottom = bbox_bottom;
    var object_bottom = touched_object.bbox_bottom;

    //adjust depth based on position
    if (player_bottom > object_bottom + depth_buffer) {
        depth = -object_bottom;  //player in front of object
    } else if (player_bottom < object_bottom - depth_buffer) {
        depth = object_bottom;  //player behind object
    }
} else {
    depth = -bbox_bottom;  //default player depth
}

//sort objects by depth
sort_depth_by_y();



//Librarian Interaction
var lib_distance = distance_to_object(objLibrarian);

if (!global.librarianDisabled && lib_distance <= 15 && keyboard_check_pressed(ord("F"))){
	show_debug_message("Player can interact with Librarian");
    global.currentDialogueContext = "librarian";  // Set context to librarian
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
var hbs = inst_72352DA4;
var hiddenDoor =inst_38BBC3DF

var hbs_distance = distance_to_object(hbs)
var hidden_distance = distance_to_object(hiddenDoor)

if(hbs_distance <= 5 && keyboard_check_pressed(ord("F"))){
	isInteractingWithBookshelf = true
	isTalkingToLibrarian = false
	isTalkingToJanitor = false
	self.alarm[0] = 1;
	if (global.unlockHauntedBookshelfJanitorHalf == true && global.unlockHauntedBookshelfLibrarianHalf == true) {
//        objDialogueBox.setDialogue("You arrange the books in the correct order and reveal the Cursed Book. You open it up and learn to chant a curse to light a lantern...");  //reveal cursed book
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

if (ped_distance <=5 && keyboard_check_pressed(ord("F"))) {
	  isInteractingWithBookshelf = false
	  isTalkingToJanitor = false
	  isTalkingToLibrarian = false
      isInteractingWithPedestal= true
	  
		self.alarm[0] = 1
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

if (distance_to_book < 1 && global.puzzleComplete = true && keyboard_check(vk_space)) { // Adjust the distance threshold as needed
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


if (distance_to_phase < 1 && global.janitorDisabled && global.librarianDisabled && keyboard_check(vk_space)) { // Adjust the distance threshold as needed
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
if(hbs_distance <= 5 && keyboard_check_pressed(ord("F"))&& hasWallPhase = true){
	 isInteractingWithBookshelf = false
	  isTalkingToJanitor = false
	  isTalkingToLibrarian = false
      isInteractingWithPedestal= false
}


