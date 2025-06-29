#include "_inc_quest"

int StartingConditional()
{
    //Check whether the PC has the quest item for this quest.
    object oPC = GetPCSpeaker();

    if(GetHasQuestItem(oPC, "Q5"))
        return TRUE;
    return FALSE;
}
