/// @function Lightining
/// @desc starts the lightning sequence and sets the delay for room transition
/// @return none

function Lightining() {
    var layer_id = layer_get_id("Object_Layer");  //get object layer id
    sequence_id = layer_sequence_create(layer_id, x, y, Sequence3);  //create lightning sequence

    //set alarm for room change
    alarm[0] = room_speed * 1;  //1-second delay before room transition
}

//call the Lightining function to start sequence
Lightining();  //start the lightning sequence

//hide the play button but keep instance active
objButtonPlay.visible = false;  //hide the play button
objButtonAbout.visible = false; //hide the about button
objButtonQuit.visible = false; //hide the quit button