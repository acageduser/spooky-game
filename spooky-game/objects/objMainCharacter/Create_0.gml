/// @description Initialize Variables

/*************************************************************************/
/*                                                                       */
/* Event name: Create                                                    */
/* Description: Initializes the animation timer and speed for            */
/* controlling the frame rate of character animations.                   */
/* Parameters: none                                                      */
/* Return Value: none                                                    */
/*                                                                       */
/*************************************************************************/

image_speed = 0; //fix the character cycling through all 32 of my animations when idle. DO NOT CHANGE

animation_timer = 0;
animation_speed = room_speed / 6; //room speed by default is (I think) 30 FPS

