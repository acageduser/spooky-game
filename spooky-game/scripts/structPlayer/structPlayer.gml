/// @function myPlayer
/// @desc constructs player object with movement and interaction functionality
/// @param {object} inst - player instance
/// @return none

function myPlayer(inst) constructor {
    owner = inst; //store instance reference

    //initialize player attributes
    move_speed = 4; //movement speed
    animation_speed = room_speed / 6; //animation frame speed
    animation_timer = 0; //timer for animations
    hsp = 0; //horizontal speed
    vsp = 0; //vertical speed
    animation_multiplier = 1; //controls animation speed
    frame_offset = 0; //adjusts animation frame
    key_count = 0; //tracks number of keys pressed
    opposite_directions_pressed = false; //flag for opposite key presses

    //interaction flags stored on owner instance
    with (owner) {
        isTalkingToJanitor = false;
        isTalkingToLibrarian = false;
        isInteracting = false; //flag for other interactions
        hasCursedBook = false;
        hasWallPhase = false;
        image_speed = 0; //stop animation when idle
    }

    //initialize global variables if not yet set
    if (!variable_global_exists("last_direction")) {
        global.last_direction = 0; //default direction (down)
    }

    if (!variable_global_exists("currentDialogueContext")) {
        global.currentDialogueContext = ""; //track dialogue context
    }

    /// @function control
    /// @desc handles player movement, input, and animation updates
    /// @param none
    control = function() {
        //disable player movement if dialogue box is active
        if (!instance_exists(objDialogueBox)) {

            //reset movement speeds and variables
            move_speed = 2; //base speed
            animation_multiplier = 1; //base animation speed
            hsp = 0;
            vsp = 0;
            frame_offset = 0;
            key_count = 0;
            opposite_directions_pressed = false;

            //check if sprinting
            if (keyboard_check(vk_shift)) {
                move_speed *= 1.5; //increase speed while sprinting
                animation_multiplier = 1.5; //increase animation speed
            }

            //increment animation timer
            animation_timer += animation_multiplier;

            //check directional input
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

            //count keys pressed
            if (right_pressed) key_count++;
            if (left_pressed) key_count++;
            if (down_pressed) key_count++;
            if (up_pressed) key_count++;

            //stop movement if 3+ keys pressed
            if (key_count >= 3 || opposite_directions_pressed) {
                hsp = 0;
                vsp = 0;
                owner.image_index = 0; //idle frame
            } else {
                var diagonal_movement = false;

                //handle movement and track direction
                if (right_pressed) {
                    hsp = move_speed; //move right
                    global.last_direction = 24; //track right direction
                }
                if (left_pressed) {
                    hsp = -move_speed; //move left
                    global.last_direction = 8; //track left direction
                }
                if (down_pressed) {
                    vsp = move_speed; //move down
                    global.last_direction = 0; //track down direction
                }
                if (up_pressed) {
                    vsp = -move_speed; //move up
                    global.last_direction = 16; //track up direction
                }

                //reduce speed for diagonal movement
                if (hsp != 0 && vsp != 0) {
                    hsp *= 0.8; //reduce horizontal speed
                    vsp *= 0.8; //reduce vertical speed
                    diagonal_movement = true;

                    //handle diagonal direction for animations
                    if (hsp > 0 && vsp > 0) {
                        frame_offset = 28; //down-right
                        global.last_direction = 28; //track down-right
                    } else if (hsp > 0 && vsp < 0) {
                        frame_offset = 20; //up-right
                        global.last_direction = 20; //track up-right
                    } else if (hsp < 0 && vsp > 0) {
                        frame_offset = 4; //down-left
                        global.last_direction = 4; //track down-left
                    } else if (hsp < 0 && vsp < 0) {
                        frame_offset = 12; //up-left
                        global.last_direction = 12; //track up-left
                    }
                } else if (hsp > 0) {
                    frame_offset = 24; //right
                } else if (hsp < 0) {
                    frame_offset = 8; //left
                } else if (vsp > 0) {
                    frame_offset = 0; //down
                } else if (vsp < 0) {
                    frame_offset = 16; //up
                }

                //update animation frame
                if (animation_timer >= animation_speed / animation_multiplier) {
                    owner.image_index = frame_offset + ((owner.image_index + 1) % 4); //cycle frames
                    animation_timer = 0; //reset timer
                }

                //apply movement and handle collisions
                owner.x += hsp;
                owner.y += vsp;

                //handle collisions
                with (owner) {
                    if (global.wallPhase == true) {
                        //allow phasing through objBookshelf1
                        if (place_meeting(x, y, objSolid) && !place_meeting(x, y, objBookshelf1)) {
                            x -= hsp; //undo horizontal movement
                            y -= vsp; //undo vertical movement
                        }
                    } else {
                        //normal collision behavior
                        if (place_meeting(x, y, objSolid)) {
                            x -= hsp; //undo horizontal movement
                            y -= vsp; //undo vertical movement
                        }
                    }
                }
            }

            //handle idle frame
            if (hsp == 0 && vsp == 0) {
                owner.image_speed = 0; //stop animation
                owner.image_index = global.last_direction; //stay on last direction
            }

            //set depth for precise sorting
            owner.depth = -owner.bbox_bottom;
        }
    };

    /// @function handleInteractions
    /// @desc handles interactions with NPCs and objects in the room
    /// @param none
    handleInteractions = function() {
        with (owner) {
            if (!global.isDialogueActive) {
                var dialogueBoxInstance = global.dialogueBoxInstance;

                //librarian interaction
                var lib_distance = distance_to_object(objLibrarian);
                if (!global.librarianDisabled && lib_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                    global.isDialogueActive = true;
                    global.currentDialogueContext = "librarian";
                    isTalkingToLibrarian = true;
                    dialogueBoxInstance.initializeDialogue("Librarian: Can I help you?", ["Ask about books", "Walk away"]);
                }

                //janitor interaction
                var jan_distance = distance_to_object(objJanitor);
                if (!global.janitorDisabled && jan_distance <= 15 && keyboard_check_pressed(ord("F"))) {
                    global.isDialogueActive = true;
                    global.currentDialogueContext = "janitor";
                    isTalkingToJanitor = true;
                    dialogueBoxInstance.initializeDialogue("Janitor: Been cleaning forever...", ["What happened?", "Leave"]);
                }

                //mirror interaction
                var mirror = instance_nearest(x, y, objMirror1);
                if (mirror != noone && point_distance(x, y, mirror.x, mirror.y) <= 15 && keyboard_check_pressed(ord("F"))) {
                    isInteracting = true;
                    if (owner != undefined && dialogueBoxInstance != undefined) {
                        currentDialogue = new MirrorDialogue(player, dialogueBoxInstance);
                    } else {
                        show_debug_message("Owner or dialogueBoxInstance is undefined");
                    }
                    currentDialogue.displayMenu(); //show mirror dialogue
                }

                //bookshelf interaction
                var bookshelf = instance_nearest(x, y, objBookshelf1);
                if (bookshelf != noone && point_distance(x, y, bookshelf.x, bookshelf.y) <= 15 && keyboard_check_pressed(ord("F"))) {
                    isInteracting = true;
                    currentDialogue = new BookshelfDialogue(owner, dialogueBoxInstance);
                    currentDialogue.displayMenu();
                }

                //lantern interaction
                var lantern = instance_nearest(x, y, objLantern);
                if (lantern != noone && point_distance(x, y, lantern.x, lantern.y) <= 15 && keyboard_check_pressed(ord("F"))) {
                    if (!global.lanternLit && (global.hasCursedBook || global.pedestalOccupied)) {
                        global.lanternLit = true;
                        global.janitorDisabled = true;
                        instance_create_layer(lantern.x, lantern.y, layer_get_name(lantern.layer), objLanternLit);
                        with (lantern) instance_destroy();
                    }
                }

                //pedestal interaction
                var pedestal = instance_nearest(x, y, objAlter);
                if (pedestal != noone && point_distance(x, y, pedestal.x, pedestal.y) <= 15 && keyboard_check_pressed(ord("F")) && !global.pedestalOccupied) {
                    if (global.hasCursedBook) {
                        global.pedestalOccupied = true;
                        removeItemFromInventory("Cursed Book");
                        global.hasCursedBook = false;
                    }
                }

                //door interaction
                var door = instance_nearest(x, y, objDoor);
                if (door != noone && point_distance(x, y, door.x, door.y) <= 15 && keyboard_check_pressed(ord("F"))) {
                    if (global.wallPhase == true) {
                        room_goto(winScreen); //move to win screen
                    } else {
                        show_message("I can't get through...");
                    }
                }
            }
        }
    };

    /// @function drawInventory
    /// @desc draws the player's inventory at the top-left corner of the screen
    /// @param none
    drawInventory = function() {
        with (owner) {
            var inventoryText = "Inventory:\n";
            for (var i = 0; i < array_length(global.inventory); i++) {
                inventoryText += "- " + global.inventory[i] + "\n"; //list items in inventory
            }
            draw_set_color(c_white); //set text color
            draw_set_font(-1); //use default font
            draw_text(10, 10, inventoryText); //draw inventory text
        }
    };
}
