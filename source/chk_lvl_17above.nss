//::///////////////////////////////////////////////
//:: FileName chk_lvl_11above
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/16/2004 10:43:51 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetHitDice(GetPCSpeaker()) >= 9)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
