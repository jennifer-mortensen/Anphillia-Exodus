#include "_inc_quest"

int StartingConditional()
{
    //Check whether the PC can finish this quest.
    object oPC = GetPCSpeaker();
    if(GetCanFinishQuest(oPC, "Q5"))
        return TRUE;
    return FALSE;
}
