//::///////////////////////////////////////////////
//:: FileName chk_lvl_below11
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/16/2004 10:42:03 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetHitDice(GetPCSpeaker()) <= 10)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
