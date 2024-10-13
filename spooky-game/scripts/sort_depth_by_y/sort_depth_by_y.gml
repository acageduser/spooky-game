/// @desc Automatically sorts objects by their Y-coordinate for 2.5D depth sorting

// Loop through all instances of objSolid and objPlayer to sort by their Y-coordinates
with (objSolid) {
    if (y != undefined) {  // Ensure the object's y-coordinate is defined
        depth = -y;  // The higher the Y value, the lower the depth (appears on top)
    }
}

with (objPlayer) {
    if (y != undefined) {  // Ensure the player's y-coordinate is defined
        depth = -y;  // The higher the Y value, the lower the depth (appears on top)
    }
}
