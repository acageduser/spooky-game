/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(vk_right)) {
    x += 4;
    
    animation_timer++;

    if (animation_timer >= animation_speed) {
        image_index = 24 + (image_index + 1) mod 4; //frames 24 to 27
        animation_timer = 0; //reset timer
    }
}
