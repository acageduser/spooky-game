/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(vk_up)) {
    y -= 4;
    
    animation_timer++;

    if (animation_timer >= animation_speed) {
        image_index = 16 + (image_index + 1) mod 4; //frames 16 to 19
        animation_timer = 0; //reset tmier
    }
}
