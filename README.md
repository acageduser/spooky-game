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
