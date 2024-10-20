// objPlayer: Create Event
player = new myPlayer(self);

// Initialize global inventory if not already done
if (!variable_global_exists("inventory")) {
    global.inventory = [];
}
