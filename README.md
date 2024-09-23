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

##############################################################################################

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

Alarm Event
- Used alarm event to delay the bird's flight for 3-6 seconds.
- After each flight, the bird resets its position, scale, and rotation.
##############################################################################################
----------------------------------------------------------------------------------------------
##############################################################################################

JALEN LEWIS

##############################################################################################
----------------------------------------------------------------------------------------------
##############################################################################################

ANGEL CRUZ

##############################################################################################
