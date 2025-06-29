//::///////////////////////////////////////////////
//:: FileName chk_axfellq_001b
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/16/2004 8:50:53 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if((GetHitDice(GetPCSpeaker()) >= 7) && (GetHitDice(GetPCSpeaker()) <= 10))
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
