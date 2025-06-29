#include "nw_i0_tool"
int StartingConditional()
{
    if(GetIsObjectValid (GetItemPossessedBy (GetPCSpeaker(), "mothdragonblood")))
    {
        return TRUE;
    }
    return FALSE;
}
