/// @description Handles drawing the Dialogue Box object to the GUI Layer

//NOTE: Draw GUI event draws to the GUI layer, as opposed to regular Draw event, which draws to the room
//      The Draw event uses room coordinates to place items, 
//			ie If I move around my room, the objects will move in/out of camera view
//		The Draw event uses GUI coordinates to place items, coordinates are mapped to the window (much like Processing)
//			ie If I move around my room, the objects will stay in place (like a minimap or a HUD)
//      Also, make sure that if you are using a viewport for one room, you enable them for ALL rooms, (including
//      your intro sequence room) and set the viewports to the same size (verying Camera size doesn't matter). If you run into
//      issues where GameMaker ignores your Font size, check that is configured properly

draw_sprite_stretched(sprText_Box, 0, left, top, width, height);
var currentText = string_copy(text, 1, textProgress);

// Draw the background box

// Draw the text
draw_set_color(c_white);
draw_set_font(fnt_dialouge); // Make sure to have a proper font set

var textX = left + padding;
var textY = top + padding;

draw_text_ext(textX, textY, currentText, -1, 475); // Adjust line spacing as needed

// Increase textProgress based on speed
if (textProgress < textLength) {
    textProgress += textSpeed;
} else {
    // Text fully displayed, allow spacebar to continue
    if (keyboard_check_pressed(vk_space)) {
        // Handle text progression or selection here
    }
}
