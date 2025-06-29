#include "nw_i0_tool"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(!HasItem(GetPCSpeaker(), "axfellwarriorrin"))
        return FALSE;
    if (GetHitDice(oPC) <  20) return FALSE;
    return TRUE;
}
