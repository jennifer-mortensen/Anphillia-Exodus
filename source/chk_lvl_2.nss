//::///////////////////////////////////////////////
//:: FileName chk_lvl_2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/17/2004 7:17:23 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetHitDice(GetPCSpeaker()) < 2)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
