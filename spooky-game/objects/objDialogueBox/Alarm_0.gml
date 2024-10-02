/// @description Insert description here
// You can write your code in this editor

if (choice) {
	
	if(objPlayer.isTalkingToLibrarian) {
		submitLibrarianAction(selected);
	} else if (objPlayer.isTalkingToJanitor) {
		submitJanitorAction(selected);
	} else {
		
		//Prevent Innkeeper option from being selected while disabled
		//NOTE: Will be deprecated after movmement & collision
		if (global.LibrarianDisabled && selected == 2) {
			selected = -1;
		} else if(global.JanitorDisabled && selected == 3){
			selected = -1
		} else {
			submitPlayerAction(selected);
		}
		
	
		
	}//end if
	
} else { //If no choices presented, display Actions Menu by default
	
	displayActionsMenu();
	
}//end if
