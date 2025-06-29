//::///////////////////////////////////////////////
//:: FileName chk_axfellq_004
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 3/16/2004 10:51:59 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "Ranz_Quest_002") == 0))
        return FALSE;
    if(GetHitDice(GetPCSpeaker())>19)
        return FALSE;
    if(GetHitDice(GetPCSpeaker())<15)
        return FALSE;
    return TRUE;
}
