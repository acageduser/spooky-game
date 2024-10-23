/// @description Insert description here
// You can write your code in this editor

//destroy any existing instances of objDialogueBox
if( instance_exists(objDialogueBox) ) {
	instance_destroy(objDialogueBox);
}//end if

//instance_create_layer(0, 0, "DialogueBox", objDialogueBox);

//Display right dialogue in objDialogueBox. These guys are the only ones with options in the dialogue
if(isTalkingToJanitor) {
	displayJanitorMenu();
} else if (isTalkingToLibrarian) {
	displayLibrarianMenu();
}//end if