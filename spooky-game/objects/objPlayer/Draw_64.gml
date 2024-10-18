/// @function Draw GUI
/// @desc Displays the player's current inventory in the top-left corner
/// @param None

var inventoryText = "Inventory:\n";

// Iterate over the player's inventory and add each item to the text
for (var i = 0; i < array_length(global.inventory); i++) {
    inventoryText += "- " + global.inventory[i] + "\n";
}

// Set the color and font
draw_set_color(c_white);
// draw_set_font(fnt_inventory);  // Remove or replace this line
draw_set_font(-1);  // Use default system font

// Draw the inventory in the top-left corner (starting at 10px from the top and left edges)
draw_text(10, 10, inventoryText);
