/// @function Alarm 0
/// @desc manages dialogue progression and action submission via the relevant dialogue struct
/// @return none

//proceed if text fully displayed and player can continue
if (global.textFullyDisplayed && global.canProceed) {
    //handle submission if choices are available
    if (global.dialogueBoxInstance.choice) {
        //submit player choice to the active dialogue
        if (global.currentDialogue != undefined) {
            global.currentDialogue.submitAction(global.dialogueBoxInstance.selected);  //submit chosen action
        }
    } else {
        //proceed without choices, trigger next alarm
        self.alarm[2] = 1;
    }
}
