/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(vk_up)) {
    y -= 4;
    image_index = 16 + (image_index + 1) mod 4; //frames 16 to 19
}
