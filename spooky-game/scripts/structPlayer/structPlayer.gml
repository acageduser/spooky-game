// structPlayer.gml

function myPlayer(inst) constructor {
    owner = inst; // Store instance reference

    // Player attributes
    move_speed = 4;
    animation_speed = room_speed / 6;  // Set frame speed based on room speed
    animation_timer = 0;
    hsp = 0;  // Horizontal speed
    vsp = 0;  // Vertical speed

    // Initialize interaction flags on the instance
    with (owner) {
        isTalkingToLibrarian = false;
        isTalkingToJanitor = false;
    }


    if (!variable_global_exists("last_direction")) {
        global.last_direction = 0;  // Default down-facing direction
    }

    // Wall phase ability and other flags
    global.currentDialogueContext = "";  // Tracks dialogue context

    // Control method (Handles movement, input, collisions, and interactions)
    control = function() {
        with (owner) {
            // Player movement and input logic
            move_speed = 2;
            var animation_multiplier = 1;

            // Check for sprinting
            if (keyboard_check(vk_shift)) {
                move_speed *= 1.5;
                animation_multiplier = 1.5;
            }

            // Handle player movement and key press logic
            var right_pressed = keyboard_check(vk_right) || keyboard_check(ord("D"));
            var left_pressed = keyboard_check(vk_left) || keyboard_check(ord("A"));
            var down_pressed = keyboard_check(vk_down) || keyboard_check(ord("S"));
            var up_pressed = keyboard_check(vk_up) || keyboard_check(ord("W"));

            // Set movement direction
            hsp = (right_pressed - left_pressed) * move_speed;
            vsp = (down_pressed - up_pressed) * move_speed;

            // Collision logic, including wall phase
            if (global.wallPhase == true) {
                // Check for wall-phase ability with bookshelf objects
                if (place_meeting(x + hsp, y + vsp, objSolid) &&
                    !place_meeting(x + hsp, y + vsp, objBookshelf1)) {
                    hsp = 0;
                    vsp = 0;
                }
            } else {
                // Normal collision behavior
                if (place_meeting(x + hsp, y + vsp, objSolid)) {
                    hsp = 0;
                    vsp = 0;
                }
            }

            // Move the player
            x += hsp;
            y += vsp;

            // Depth handling
            depth = -y;
        }
    };

    // Display inventory
    drawInventory = function() {
        // Since drawing functions operate in the instance scope, use 'with'
        with (owner) {
            var inventoryText = "Inventory:\n";

            // Iterate over player's inventory
            for (var i = 0; i < array_length(global.inventory); i++) {
                inventoryText += "- " + global.inventory[i] + "\n";
            }

            // Set the font and draw inventory at the top-left corner
            draw_set_color(c_white);
            draw_set_font(-1);  // Use default system font
            draw_text(10, 10, inventoryText);
        }
    };

    // Method to handle all interactions (Librarian, Janitor, Bookshelf, etc.)
    handleInteractions = function() {
        with (owner) {
            // Handle Librarian Interaction
            if (distance_to_object(objLibrarian) <= 15 && keyboard_check_pressed(ord("F"))) {
                global.currentDialogueContext = "librarian";
                isTalkingToLibrarian = true;
            }

            // Librarian Interaction
            var lib_distance = distance_to_object(objLibrarian);
            if (!global.librarianDisabled && lib_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                global.currentDialogueContext = "librarian";  // Set context to librarian
                isTalkingToLibrarian = true;
                alarm[0] = 1;
            }

            // Janitor Interaction
            var jan_distance = distance_to_object(objJanitor);
            if (!global.janitorDisabled && jan_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                isTalkingToJanitor = true;
                alarm[0] = 1;
            }

            // Haunted Bookshelf Interaction
            var hbs_distance = distance_to_object(objBookshelf1);
            if (hbs_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                alarm[0] = 1;
                if (global.unlockHauntedBookshelfJanitorHalf == true && global.unlockHauntedBookshelfLibrarianHalf == true) {
                    global.hasCursedBook = true;  // Give player cursed book
                    array_push(global.inventory, "Cursed Book");  // Add cursed book to inventory
                } else {
                    objDialogueBox.setDialogue("The bookshelf looks ordinary.");
                }
            }

            // Lantern Interaction
            var lan_distance = distance_to_object(objLantern);
            if (lan_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                if ((global.lanternLit == false) && (global.hasCursedBook == true || global.pedestalOccupied == true)) {
                    global.lanternLit = true;
                    global.janitorDisabled = true;
                    instance_create_layer(x, y, "Lantern", objLanternLit);  // Replace lantern
                    instance_destroy();  // Destroy unlit lantern
                }
            }

            // Pedestal Interaction
            var ped_distance = distance_to_object(objAlter);
            if (ped_distance <= 15 && keyboard_check_pressed(ord("F")) && !global.pedestalOccupied) {
                if (global.hasCursedBook) {
                    global.pedestalOccupied = true;  // Update pedestal state
                    removeItemFromInventory();
                    global.inventory = [];
                    global.hasCursedBook = false;
                }
            }

            // Mirror Interaction
            var mirror_distance = distance_to_object(objMirror1);
            if (mirror_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                if (global.librarianDisabled == true && global.janitorDisabled == true) {
                    global.wallPhase = true;  // Unlock wallPhase ability
                    array_push(global.inventory, "Wall Phase Ability");
                }
            }

            // Door Interaction
            var door_distance = distance_to_object(objDoor);
            if (door_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                if (global.wallPhase == true) {
                    room_goto(winScreen);  // Move to win screen
                } else {
                    objDialogueBox.setDialogue("I can't get through...");
                }
            }
        }
    };
}
