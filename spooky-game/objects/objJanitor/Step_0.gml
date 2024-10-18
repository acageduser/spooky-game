/// @description Insert description here
// You can write your code in this editor
x += move_direction * speed;
move_distance += speed;

// Check if the object has moved 100 pixels in one direction
if (move_distance >= 130 and move_direction=2) {
    // Reverse the direction
    move_direction = -2;
    move_distance = 0; // Reset the distance counter
	speed=1;
	
}
if (move_distance >= 390 and move_direction=-2) {
    // Reverse the direction
    move_direction = 2;
    move_distance = 0; // Reset the distance counter
	speed=1;
}
