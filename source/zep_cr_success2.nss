#include "zep_inc_craft2"

int StartingConditional() {
    return (GetLocalInt(GetPCSpeaker(), "ZEP_CR_DONE") == ZEP_CR_DONE_SUCCESS);
}
