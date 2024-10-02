// inspectMirror.gml
function inspectMirror() {
    if (global.librarianDisabled == true && global.janitorDisabled == true) {
        objDialogueBox.setDialogue("You look into the mirror and realize there is no reflection... A strange power awakens within you.");
        global.wallPhase = true;  // Unlock Wall Phase ability
    } else {
        objDialogueBox.setDialogue("It's just a dusty mirror...");
    }
}
