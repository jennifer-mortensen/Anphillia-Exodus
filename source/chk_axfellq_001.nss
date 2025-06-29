//::///////////////////////////////////////////////
//:: FileName chk_axfellq_001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2/23/2004 9:28:13 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "Axfell_Quest_001") == 0))
        return FALSE;
    if(GetHitDice(GetPCSpeaker())>6)
        return FALSE;
    return TRUE;
}
