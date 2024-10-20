// objGameController Create Event

/// @function initialize_global_flags
/// @desc initializes all global game state flags
/// @return none

global.unlockHauntedBookshelf = false;  // Player unlocks haunted bookshelf
global.unlockHauntedBookshelfLibrarianHalf = false;
global.unlockHauntedBookshelfJanitorHalf = false;
global.hasInspectedMirror = false;  // Player has inspected the mirror
global.wallPhase = false;  // Wall phase ability unlocked
global.returnedCursedBook = false;  // Player returned cursed book
global.spokenWithLibrarian = false;  // Player has spoken with librarian
global.librarianDialogueBranch = 0;  // Tracks librarian dialogue progress
global.janitorDialogueBranch = 0;  // Tracks janitor dialogue progress
global.janitorDisabled = false;  // Janitor dialogue disabled
global.librarianDisabled = false;  // Librarian dialogue disabled
global.HasCursedBook = false;  // Player has obtained cursed book
global.lanternHasCursedFlame = false;  // Cursed flame in lantern
global.lanternLit = false;  // Lantern has been lit
global.spiritAwakening = false;  // Player's spirit awakening triggered
global.pedestalOccupied = false;  // Pedestal is occupied with cursed book
global.inventory = [];  // Empty inventory at the start
global.isTalkingToLibrarian = false;
global.isTalkingToJanitor = false;
