#include "x2_i0_spells"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if (GetHasEffect(EFFECT_TYPE_POLYMORPH, oPC) == TRUE)
    {
        return TRUE;
    }
    else return FALSE;
}
