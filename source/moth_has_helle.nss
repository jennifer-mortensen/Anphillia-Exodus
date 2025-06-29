#include "nw_i0_tool"
int StartingConditional()
{
    if(GetIsObjectValid (GetItemPossessedBy (GetPCSpeaker(), "mothhellenous1")))
        return TRUE;

    return FALSE;
}
