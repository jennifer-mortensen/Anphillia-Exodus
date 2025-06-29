//If set to TRUE, the rest event will use a fade to black effect.  Otherwise, it will use a blind effect.
const int FADE_TO_BLACK_ON_REST = FALSE;
//If set to TRUE, debug features will be enabled.  Ensure that this is set to FALSE on the live server.
const int DEBUG_MODE = FALSE;
//If set to TRUE, server character saves will be disabled.  Ensure that this is set to FALSE on the live server.
const int DISABLE_SERVER_SAVE = FALSE;
//Controls the number of seconds that a PC will remain hostile after he leaves hostile territory, or turns off PvP mode.
const int PVP_FLAG_DURATION = 1200;
//The following constants control the number of hits that comprise each subdual stages.
const int SUBDUE_WINDED = 3;
const int SUBDUE_BLACKOUT = 6;
const int SUBDUE_KNOCKOUT = 9;

//--Script Constants.  Do not change variables below this point!
//Subdual mode constants.
const int SUBDUAL_MODE_FULL_DAMAGE = 0;
const int SUBDUAL_MODE_SUBDUAL = 1;
const int SUBDUAL_MODE_SPARRING = 2;
