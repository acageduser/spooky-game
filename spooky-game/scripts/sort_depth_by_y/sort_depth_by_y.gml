/// @desc Automatically sorts objects by their Y-coordinate for 2.5D depth sorting
//sort_depth_by_y.gml

// Loop through all instances of objSolid and objPlayer to sort by their Y-coordinates
with (objSolid) {
    if (y != undefined) {  // Ensure the object's y-coordinate is defined
        depth = -y;  // The higher the Y value, the lower the depth (appears on top)
    }
}

with (objPlayer) {
    if (y != undefined) {  //make sure the player's y-coordinate is defined
        depth = -y;  // The higher the Y value, the lower the depth (appears on top)
    }
}
