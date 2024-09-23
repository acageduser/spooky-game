/// @function bird_create
/// @desc Initializes the bird object, positions it off-screen to the right, and sets variables for the easing curve.
/// @param None
/// @return None

x = room_width + 100;
y = random_range(50, 180);

start_x = x;
target_x = -100;

flight_time = room_speed * 5;
time_passed = 0;

alarm[0] = 90; //birb delay

move_speed = 2;