#include "_inc_quest"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetCanStartQuest(oPC, "Q4"))
        return TRUE;
    return FALSE;
}
