#include "_inc_quest"

int StartingConditional()
{
    //Check whether the PC can finish this quest.
    object oPC = GetPCSpeaker();
    if(GetCanFinishQuest(oPC, "Q2"))
        return TRUE;
    return FALSE;
}
