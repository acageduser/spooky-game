/// @function bird_create
/// @desc Initializes the bird object, positions it off-screen to the right, and sets an alarm for a 3-second delay.
/// @param None
/// @return None


x = room_width + 100; 
y = random_range(50, 180);

alarm[0] = 90;

move_speed = 2; //brib speed across the screen