/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(vk_down)) {
    y += 4;
    
	animation_timer++; //handling the timer here (also in my Create tab too)

    if (animation_timer >= animation_speed) {
        image_index = (image_index + 1) mod 4; //frames 0 to 3
        animation_timer = 0; //reset timer
    }
}
