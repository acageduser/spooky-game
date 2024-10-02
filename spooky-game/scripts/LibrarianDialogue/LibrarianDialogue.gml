// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.LibrarianBranch = 0;
global.LibrarianDisabled = false;

function displayLibrarianMenu(){
	if(global.LibrarianBranch == 0){
		var LibrarianDialogueOptions = ["Who are you?","How do i get out of here?","Walk away"];
		objDialogueBox.setDialogue("Hello there! How may I help you?",LibrarianDialogueOptions);
	}
}

function submitLibrarianAction(choice){
	if(global.LibrarianBranch == 0){
		switch(choice){
			case 0:
				objDialogueBox.setDialogue("I am the keeper of this place, bound to it for eternity...unless someone helps me find peace.");
				objPlayer.isTalkingToLibrarian = false;
				break;
				
			case 1:
				objDialogueBox.setDialogue("testing 2")
				objPlayer.isTalkingToLibrarian = false;
				break;
				
			case 2:
				objPlayer.isTalkingToLibrarian = false;
				displayActionsMenu();
				break;
			
		}
	}
}