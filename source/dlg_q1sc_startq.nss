#include "_inc_quest"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetCanStartQuest(oPC, "Q1"))
        return TRUE;
    return FALSE;
}
