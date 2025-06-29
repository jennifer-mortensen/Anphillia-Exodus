#include "_inc_quest"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    //Check to see whether this quest has been initialized.
    if(GetIsQuestInitialized(oPC, "Q1"))
        return TRUE;
    return FALSE;
}
