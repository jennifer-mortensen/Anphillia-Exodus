#include "_inc_xp"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetECLAdjustedLevelFromXP(oPC) <= 20)
        return TRUE;
    return FALSE;
}
