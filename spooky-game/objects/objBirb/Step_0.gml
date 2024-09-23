/// @function bird_step
/// @desc Moves the bird from right to left across the screen using an easing curve and resets its position after flying off-screen.
/// @param None
/// @return None

if (alarm[0] <= 0) {
    time_passed += 1;
    
    t = time_passed / flight_time;
    t_eased = t * t * (3 - 2 * t);
    
    x = lerp(start_x, target_x, t_eased);
    
    image_speed = 1;

    if (time_passed >= flight_time) {
        x = start_x;
        y = random_range(140, 280);
        
        time_passed = 0;
        flight_time = room_speed * irandom_range(3, 6);
        alarm[0] = room_speed * random_range(1, 6);

        image_xscale = random_range(0.1, 0.4);
        image_yscale = image_xscale;

        image_angle = random_range(30, 34);

        move_speed = random_range(1, 3);
    }
}