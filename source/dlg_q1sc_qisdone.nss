#include "_inc_quest"

int StartingConditional()
{
    //Check to see whether this quest has been completed.
    object oPC = GetPCSpeaker();

    if(GetIsQuestComplete(oPC, "Q1"))
        return TRUE;
    return FALSE;
}
