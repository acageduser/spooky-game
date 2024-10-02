// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.actionOptions = ["Open Door", "Inspect Mirror", "Speak to Librarian", "Speak to Janitor"];

function displayActionsMenu() {
	objDialogueBox.setDialogue("What would you like to do?", global.actionOptions);
}

function submitPlayerAction(choice){
	
	switch(choice){
		case 0:
			openDoor();
			break;
		case 1:
			inspectMirror();
			break;
		case 2:
			displayLibrarianMenu();
			objPlayer.isTalkingToLibrarian = true;
			break;
		case 3:
			displayJanitorMenu();
			objPlayer.isTalkingToJanitor = true;
			break;
	}
}

function openDoor(){
	if(objPlayer.hasWallPhase == true){
		//Player leaves Library
	} else {
		//The door is blocked off by that bookshelf
	}
}

function inspectMirror(){
	if((global.LibrarianDisabled == true) & (global.JanitorDisabled == true)){
		//Player obtains wall phase
	} else {
		//"That's a pretty looking mirror"
	}
}