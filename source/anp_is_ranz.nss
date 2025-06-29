#include "nw_i0_tool"
int StartingConditional()
{
    if(GetIsObjectValid (GetItemPossessedBy (GetPCSpeaker(), "RanzingtonCitizenRing")))
        return TRUE;

    return FALSE;
}
