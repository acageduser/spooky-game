/// @function bird_step
/// @desc Moves the bird from right to left across the screen and resets its position after flying off-screen.
/// @param None
/// @return None

if (alarm[0] <= 0) {
    x -= move_speed;
    
    image_speed = 1;

    if (x < target_x) {
        x = room_width + 100;
        y = random_range(140, 280);
        
        image_xscale = random_range(0.1, 0.3);
        image_yscale = image_xscale;
        
        image_angle = random_range(-3, 6);
        
        alarm[0] = room_speed * irandom_range(3, 6);
    }
}