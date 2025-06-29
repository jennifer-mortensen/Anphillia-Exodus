#include "nw_i0_tool"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(!HasItem(oPC, "mothremoveplot"))
        return FALSE;
    return TRUE;
}
