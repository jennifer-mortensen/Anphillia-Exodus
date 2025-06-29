#include "_inc_quest"

int StartingConditional()
{
    //Check whether the PC has the quest item for this quest.
    object oPC = GetPCSpeaker();

    if(GetHasQuestItem(oPC, "Q1"))
        return TRUE;
    return FALSE;
}
