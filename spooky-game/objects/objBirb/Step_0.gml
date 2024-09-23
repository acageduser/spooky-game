/// @function bird_step
/// @desc Moves the bird across the screen based on the move speed until it flies off-screen.
/// @param None
/// @return None

if (alarm[0] <= 0) {
    x += move_speed;

    if (x > target_x) {
        instance_destroy();
    }
}