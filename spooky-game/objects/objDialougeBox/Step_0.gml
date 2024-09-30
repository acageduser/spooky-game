/// @description Insert description here
// You can write your code in this editor
mouseX = device_mouse_x_to_gui(0);
mouseY = device_mouse_y_to_gui(0);

//Update textProgress attribute if less than the length of the text
if (textProgress <= textLength) {
	textProgress += textSpeed;
}//end if

//If space key is pressed, determine appropriate action for text
if (keyboard_check_pressed(vk_space) ) {
	
	if (textProgress < textLength) {
		textProgress = textLength;  //Fast forward typewriting to display full message
	} else  {
		 alarm[0] = room_speed * 0.2;//Display Actions Menu
	}//end if
	
}