///// @function playerMovement
///// @desc handles player movement in 4 cardinal directions, stopping when the key is released, and adding omni-directional movement (if needed)
///// @param None
///// @return None

//function playerMovement() {
//    var hsp = 0;  // horizontal speed
//    var vsp = 0;  // vertical speed

//    // move right
//    if (keyboard_check(vk_right)) {
//        hsp = 4;  // moving right
//    }
//    // move left
//    if (keyboard_check(vk_left)) {
//        hsp = -4;  // moving left
//    }
//    // move up
//    if (keyboard_check(vk_up)) {
//        vsp = -4;  // moving up
//    }
//    // move down
//    if (keyboard_check(vk_down)) {
//        vsp = 4;  // moving down
//    }

//    // omni-directional movement (diagonal)
//    if (keyboard_check(vk_right) && keyboard_check(vk_down)) {
//        hsp = 4;  // right and down
//        vsp = 4;
//    } else if (keyboard_check(vk_left) && keyboard_check(vk_up)) {
//        hsp = -4;  // left and up
//        vsp = -4;
//    }

//    // Apply movement
//    x += hsp;  // update horizontal position
//    y += vsp;  // update vertical position
//}
