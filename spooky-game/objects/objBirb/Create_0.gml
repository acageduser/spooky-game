/// @function bird_create
/// @desc Initializes the bird object, positions it off-screen to the right, and randomizes rotation, scale, and speed.
/// @param None
/// @return None

randomize();  // Ensures each bird instance gets unique random values

x = room_width + 100;
y = random_range(50, 180);

start_x = x;
target_x = -100;

flight_time = room_speed * 5;
time_passed = 0;

alarm[0] = room_speed * random_range(1, 6);

image_xscale = random_range(0.1, 0.3);
image_yscale = image_xscale;

image_angle = random_range(30, 34);

move_speed = random_range(1, 3);