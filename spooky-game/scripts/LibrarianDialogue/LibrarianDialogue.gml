// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

global.LibrarianDialogueBranch = 0;
global.LibrarianDisabled = false;

function displayLibrarianMenu(){
	var options = ["Who are you?", "Walk away"];
	if(global.LibrarianDialogueBranch == 0){
		objDialogueBox.setDialogue("Hello there! How may I help you?",options);
	} else if(global.LibrarianDialogueBranch == 1){
		options[0] = "What happens if I light the lantern?";
		objDialogueBox.setDialogue("I cannot help myself…however there is another spirit here, cursed to endlessly toil. To free him, you must light the lantern that he cannot. But be warned, the flame required is not of this world.",options);
	} else if(global.LibrarianDialogueBranch == 2){
		options[0] = "What happens if I light the lantern?";
		objDialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.",options);
	}
}

function submitLibrarianAction(choice){
	if(global.LibrarianDialogueBranch == 0){
		switch(choice){
			case 0:
				objDialogueBox.setDialogue("I am the keeper of this place, bound to it for eternity...unless someone helps me find peace.");
				global.LibrarianDialogueBranch = 1;
				break;
				
			case 1:
				displayActionsMenu();
				global.isTalkingToLibrarian = false;
				break;
			
		}
	} else if(global.LibrarianDialogueBranch == 1){
		switch(choice){
			case 0:
				objDialogueBox.setDialogue("Lighting the lantern will allow the janitor to move on. But to ignite the flame, you will need the Cursed Book, which is hidden behind the bookshelf. I don't know how to get it, but perhaps he does.");
		}
	} 
}