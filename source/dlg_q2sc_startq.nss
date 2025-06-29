#include "_inc_quest"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetCanStartQuest(oPC, "Q2"))
        return TRUE;
    return FALSE;
}
