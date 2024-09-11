/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(vk_down)) {
    y += 4;
    image_index = (image_index + 1) mod 4; //frames 0 to 3
}
