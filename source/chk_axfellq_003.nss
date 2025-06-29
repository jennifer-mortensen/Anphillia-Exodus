//::///////////////////////////////////////////////
//:: FileName chk_axfellq_003
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/16/2004 10:51:59 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "Axfell_Quest_003") == 0))
        return FALSE;
    if(GetHitDice(GetPCSpeaker())>12)
        return FALSE;
    if(GetHitDice(GetPCSpeaker())<9)
        return FALSE;
    return TRUE;
}
