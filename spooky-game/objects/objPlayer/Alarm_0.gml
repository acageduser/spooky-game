/// @description Insert description here
// You can write your code in this editor

//Destroy any existing instances of objDialogueBox
if( instance_exists(objDialogueBox) ) {
	instance_destroy(objDialogueBox);
}//end if

instance_create_layer(0, 0, "DialogueBox", objDialogueBox);

//Display appropriate dialogue in objDialogueBox
if(isTalkingToJanitor) {
	displayJanitorMenu();
} else if (isTalkingToLibrarian) {
	displayLibrarianMenu();
}//end if