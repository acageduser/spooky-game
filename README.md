# spooky-game
CSC 240-020 Coursework

/******************************************************************/
/* Author: Jalen Lewis, Ryan Livinghouse, Angel Cruz              */
/* Major: Information Technology/Game Development                 */
/* Creation Date: September 10, 2024                              */
/* Due Date: September 25, 2024                                   */
/* Course: CSC240 020                                             */
/* Professor Name: Griffin Nye                                    */
/* Assignment: Assignment 4 - Animation Fall 2024                 */
/* Filename: README.txt                                           */
/* Purpose: This file contains the needed sources that distinguish*/
/* our assets from assets we pulled off the internet. It also     */
/* includes our revision proof per student.                       */
/******************************************************************/

This project was created using our own assets as well as assets from the internet.

Assets created BY US using GameMaker:
- sprJanitor
- sprLibrarian

Assets created BY US using Aseprite
- sprWallPhase1
- sprWallPhase2
- sprCursed_Book
- sprLantern_lit
- sprLantern_Unlit

Assets created BY US using Ryan's self developed AI checkpoint model + Lora model in Krita using Stable Diffusion on Automatic1111:
- sprBookshelf1
- sprBookshelf2
- sprBookshelf3
- sprDesk_Clean
- sprDesk_Cluttered
- sprMirror1
- sprMirror2
- sprAlter
- sprDoor
- sprMainScreen
- sprButton


Assets NOT created by us. These assets were taken from the internet with permission from the original artists as needed:
- sprWallSet (Source: https://opengameart.org/content/16x16-wall-set)
- sprWallSet_Floor (Source: https://opengameart.org/content/16x16-wall-set)
- sprMainCharacter (Source: https://gibbongl.itch.io/8-directional-gameboy-character-template)
- sprWASD (https://www.vhv.rs/viewpic/hbRhhhh_wasd-keys-png-download-fire-pixel-art-png/)
- sprAboutScreen (https://www.reddit.com/r/PixelArt/comments/ha2qch/undead_purgatory/)
- sprBirb (https://www.shutterstock.com/image-illustration/flying-bird-animation-pixel-art-600nw-646008130.jpg)
- sprlighting (https://purepng.com/public/uploads/medium/purepng.com-lightninglightningsudden-electrostatic-dischargeintra-cloud-lightningcc-lightning-1411527065801n2r18.png)
- sprCloud(https://i.pinimg.com/originals/60/a8/2c/60a82c6cf7fda046b291e6b2c78ea531.png)
- sprWinScreen (https://www.vecteezy.com/vector-art/11234047-you-win-video-game)

Assignment 6 Revision Proofs

######################################################################################

RYAN LIVINGHOUSE:
Changelog:

Added:
- scrPlayerMovement: Handles all player movement logic.
- objPlayer Step: Now responsible for controlling player movement.
- Omni-directional movement with 8 different directions! (UP, DOWN, LEFT, RIGHT, and all 4 DIAGONALS).
- Sprint feature: Hold shift to boost your speed by 1.5x! Run like the wind!
- objSolid: Introduced as the parent for all solid objects.
- All objects now have custom collision boxes for that sweet 2.5D effect.
- scrTileCollide: Moved into objPlayer’s Step event to manage tile collisions.
- Player can no longer break through the edges of the world. You’re locked in now!
- No more running through objects. Collisions are officially a thing.
- sort_depth_by_y: Added to manage the 2.5D depth effect.
- 2.5D is fully in place: Player now appears behind or in front of objects based on position.
- Viewport is live! Camera zooms in slightly and follows the player around.

Changed:
- objPlayer Create: Now initializes all movement variables.
- All player movement is now handled in the Step event (no more 8 separate key events).
- Reorganized objects into their own instances for better management.

UPDATED CHANGES:

- Intro text is now displayed. Following the intro text, the dialogue box is destroyed in the DialogueBox instance, preventing the old actions menu to come up
- The menu now appears on screen when talking to the NPCs
- Each NPC interaction has their own menu with their own options you can select.
- submitPlayerAction is taken out since it references the old Actions.gml script. Actions.gml is deprecated.
- displayActionsMenu is taken out since it references the old Actions.gml script. Actions.gml is deprecated.
- The actions menu is now completely killed. It no longer has any references or code that is running at all. Everything is handled within the librarian/janitor dialogue scrips
- Pressing the 'quit' now instance_destory()'s the dialogue box and lets you walk around again.
- Fix player moving while in dialogue box. The player now sits still when the dialogue box is open.
- Redesigned the level to include the new objCursedBook and new bookshelves within a new bookshelvesDestroy layer. The new level design will make the game concept more clear.
- Added bookshelf destruction! After rearranging the books in the correct order, the bookshelves now disappear, enabling the player to get past them.
- The inventory is now displayed on the screen at all times.
- The inventory can now be populated with the correct items the player has picked up.
- The cursed book can now be obtained
- When placing the cursed book on the pedestal, it now displays on top of the pedestal. It's rough, but hey it works.
- The lantern now functions correctly. It also switches to the 'objLanternLit' object once it's lit
- The player can now interact with the door and leave the room, prompting them to view the win screen.
- The player can interact with the mirror and get the wall phase ability.
- Player is now able to phase through solid bookshelves to reach the door.


######################################################################################
--------------------------------------------------------------------------------------
######################################################################################

JALEN LEWIS:


######################################################################################
--------------------------------------------------------------------------------------
######################################################################################

ANGEL CRUZ:

Each NPC and object interaction has its own block of code in the players step event.
The way the collision was done did not allow for collision mask overlap so I could not
do collision events.

There is an issue with the dialogue box where the options are not highlighted when
being hovered over with the mouse and are not able to be selected. All interactions
have debug messages in place of the dialogue box while I work on a fix.

######################################################################################


























Assignment 5 Revision Proofs

######################################################################################

RYAN LIVINGHOUSE:

Creation of the following scripts:
- Actions.gml
- DialogueBox.gml
- exitRoom.gml
- hauntedBookshelf.gml
- inspectMirror.gml
- JanitorDialogue.gml
- lanternInteraction.gml
- openDoor.gml
-pedistalInteraction.gml

Space bar functionality:
- Space bar speedup: Holding space speeds up how fast the text generates by 4x the 
normal speed.
- Prevent menu skipping: You can’t just press space to go back to the main menu 
whenever you want anymore. Now, you can only go back to the main menu when the game 
prompts you to (like after dialogue finishes).
- Disable space bar on highlighted options: The space bar no longer “clicks” 
highlighted options. It used to act like a left-click when you hovered over options 
with the mouse and hit space. That’s fixed now.

objDialogueBox:
	- Text rendering and progression: Handles how text shows up and speeds up when holding 
	space. Also controls when the player can move on based on if the text is fully 
	generated or not.
	- Menu interaction fixes: Menu options are now consistently drawn from the bottom up 
	and stay aligned. Mouse clicks work for selecting options, and space bar is only 
	allowed for moving on when the game prompts it.
	- GUI Layer tweaks: The dialogue options are drawn 55 pixels up from the bottom of 
	the screen. Hovering over options highlights them, and mouse clicks are correctly 
	handled for making selections.

	Step:
		- Mouse and keyboard checks: Makes sure text speeds up while holding space and stops 
		the game from jumping to the main menu if you press space before the text finishes 
		generating.
		- Text progression: Updates how fast text shows up on screen based on `textSpeed`, 
		and speeds things up when space is held.

	Alarm 0:
		- Transition management: Handles moving between different menus and dialogue choices, 
		making sure the right actions are trigggered whether you're talking to an NPC or in 
		the general action menu.

	Alarm 1:
		- No more forced delay: Got rid of any forced wait time between text finishing and 
		the ability to move on. As soon as the text finishes displaying, you can immediately 
		continue without waiting.

Create Flowchart:
	- Dialogue flow overview: Shows all the dialogue paths with the Janitor, Librarian, 
	and interactive elements like the Haunted Bookshelf, Lantern, and Pedestal. The 
	flowchart tracks everything from initial interactions to how the game changes based 
	on your choices and unlocked items.
	- Menu navigation: Outlines how you move between menus, dialogue screens, and events. 
	Each choice and action updates the game state, and the flowchart explains how 
	everything links up.
	- Text and interaction sequence: Includes how text appears, how dialogue works 
	with NPCs, and how fast-forwarding or advancing through the game changes based on 
	what’s happening.

Create in-line documentation:
	- Every function now has comments that match the required format:
		- @function: Lists the name of the function.
		- @desc: A brief description of what the function does.
		- @param: Details any parameters.
		- @return: If anything is returned.
	- Updated the in line comments to reflect the behavior of each line.

- Directions on how to navigate the menu are included.

- Update the formatting for the intro sequence.

- Fix the book puzzle. Previously, the player would automatically know the puzzle solution.

- Fix a bug where the player could complete the game without talking to both NPCs. The
player must get both halves of the book puzzle before they are allowed to solve.

- Add in the ending game sequence:
  - Added sprWinScreen.
  - Added the winScreen room.
  - Made a link between exiting the room from the actions menu to the win screen.
  
- Fixed the logic that handles checking for the state of the:
  - lantern
  - pedestal
  - librarian
  - janitor
  - leaving the room
  - peering behind the empty bookshelves

- Created the inventory menu and associated flags:
  - The items the player gets in the game are now tracked behind the scenes.
  - The items the player gets in the game are now tracked visually through a text menu.

- Included directions in how to use the "Type your Name" box. Apparently they were not
clear enough (I still have no idea how typing in a field that says 'type' isn't clear, but okay...)

- Fixed the Title Screen:
  - There was no indication that the user's click was accepted when clicking Play. Now,
  all the buttons will vanish once the play button is clicked.

######################################################################################
--------------------------------------------------------------------------------------
######################################################################################

JALEN LEWIS:
 1. made the dialouge box and the beggining discription of the game seeting when it starts
 2. I fixed thd bugs with the pedestal
 3. I chabged the clues for the book color combination. I changed it to where the player needs to go to the janitor and the librarian for one clue each. 
4. The janitor and librarian dialogue  disabling after the tasks were done and I  make them thank the player.

######################################################################################
--------------------------------------------------------------------------------------
######################################################################################

ANGEL CRUZ:

Created and worked on:

- Actions.gml
- DialogueBox.gml
- JanitorDialogue.gml
- LibrarianDialogue.gml
- openDoor.gml
- inspectMirror.gml

Fixed instruction mistake where it said that the player could use the right mouse
button to select an option when its actually the left mouse button.

Fixed a bug where the player would select and option and receive a response that
corresponded with a different option (w/Ryan)

Fixed a bug where the Librarians responses were appearing in the incorrect branch

Fixed a bug where the apostrophe (') was appearing as a box

######################################################################################





























Assignment 4 Revision Proofs

######################################################################################

RYAN LIVINGHOUSE:

Player sprite animations
- Animations that change based on keybinds.
- Sprite updates smoothly based on movement direction.

Bird animation using three parameter keys
1. Position: Bird moves from right to left using an easing function. The easing curve
   changes the bird’s movement for a smooth start, acceleration in the middle, and
   deceleration at the end.
2. Scaling: Bird randomly scales between 0.1 and 0.4 each flight.
3. Rotation: Bird tilts slightly with random rotation (30 to 34 degrees).

I also added that each 'volley' of new birds will have random position, scaling,
rotation, and delay per instance of bird instead of per volley of birds.

objLantern
	- New 'swaying' animation added. It's a ghostly lantern, so it needs to float like
	a ghost.
	- Uses an animation curve within the sequence under position and rotation parameter
	tracks.
	- Uses 3 'track panel' parameter tracks (position, rotation, scale).

Alarm Event
- Used alarm event to delay the bird's flight for 3-6 seconds.
- After each flight, the bird resets its position, scale, and rotation.
######################################################################################
--------------------------------------------------------------------------------------
######################################################################################

JALEN LEWIS
  I Made 2 functions using sequences.
	- 1 to make 2 clouds and all 3 buttons float in the wind. 
	- The other to creat lighting when the play button is clicked.

######################################################################################
--------------------------------------------------------------------------------------
######################################################################################

ANGEL CRUZ:

Title Object
1. Sets the desired font and color
2. Calculates the centered position of each section of the title
3. Draws the title of the game ("Banished by the Book")

I created new font resources so that I could make the title a bigger font than the text of
the buttons. I also created another font for the Play button since it is bigger than the
About/Quit Buttons and I wanted the size of the text to remain consistent with the size 
of the buttons.

Effect Layer
1. Created an Effect layer of Effect Type: Gaussian Blur
2. Effect Layer was moved to be after the background but before all of the assets

Sequence animations
- Title Object
	1. The title begins offscreen and lowers into the center of the screen
	2. The title fades in as it lowers (If i get it to work)

- Book
	1. The Cursed Book begins offscreen and travels down with the title of the game
	2. The Cursed Book has rotation added in
	3. The Cursed Book was scaled up

I thought that with "Book" being included in the title it made sense to have the
Cursed Book be part of the intro. It allows the player to create a connection with
the book being mentioned and seen at the intro and the Cursed Book they'll encounter
later in the game.

######################################################################################
