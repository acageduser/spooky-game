// objGameController Step Event

/// @desc Automatically sorts objects by their Y-coordinate for 2.5D depth sorting

// Loop through all instances of objSolid and objPlayer to sort by their Y-coordinates
with (objSolid) {
    if (y != undefined) {
        depth = -y;
    }
}
