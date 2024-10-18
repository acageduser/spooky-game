/// @function Mouse Left Pressed
/// @desc Handles player interaction with menu options when clicked
/// @return none

if (choice && global.textFullyDisplayed) {
    var optionY = bottom - (array_length(options) * 30) - padding;  // Start from the bottom where options are displayed
    
    // Loop through the available options to check for a click
    for (var i = 0; i < array_length(options); i++) {
        var optionTextWidth = string_width(options[i]);
        var optionX = (screenW / 2) - (optionTextWidth / 2);  // Center the options horizontally
        
        // Check if the mouse is clicking within the bounds of this option
        if (mouse_x >= optionX && mouse_x <= optionX + optionTextWidth && mouse_y >= optionY && mouse_y <= optionY + 30) {
            // A valid option has been clicked, handle the corresponding action
            if (global.isTalkingToLibrarian) {
                submitLibrarianAction(i);  // Handle librarian interaction
            } else if (global.isTalkingToJanitor) {
                submitJanitorAction(i);  // Handle janitor interaction
            }
            break;  // Exit the loop once a selection is made
        }

        optionY += 40;  // Move up for the next option
    }
}
