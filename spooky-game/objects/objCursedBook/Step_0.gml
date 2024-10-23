var player_distance = distance_to_object(objPlayer);  //get distance to player

//debug distance to verify check
//show_debug_message("Player distance to book: " + string(player_distance));

//check if player close enough and presses 'F'
if (player_distance <= 15 && keyboard_check_pressed(ord("F"))) {
    global.HasCursedBook = true;  //set flag for cursed book
    array_push(global.inventory, "Cursed Book");  //add book to inventory
    show_debug_message("Cursed Book added to inventory!");  //feedback message
    instance_destroy();  //remove book from room
}

if (keyboard_check_pressed(ord("F"))) {
    show_debug_message("F key pressed!");  //confirm key press
    show_debug_message("Inventory: " + string(global.inventory));  //display inventory
}
