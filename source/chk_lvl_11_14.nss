//::///////////////////////////////////////////////
//:: FileName chk_lvl_11_14
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/17/2004 1:51:59 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if((GetHitDice(GetPCSpeaker()) >= 5) && (GetHitDice(GetPCSpeaker()) <= 8))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
