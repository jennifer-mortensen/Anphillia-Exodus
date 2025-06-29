//::///////////////////////////////////////////////
//:: Name Editor: Check person
//:: FileName j_news_ed_check
//:://////////////////////////////////////////////
/*
    Must have the item "News Editor Permission" or be a DM. If not a DM
    and not got it, its TRUE
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(!GetIsDM(oPC) &&
       !GetIsObjectValid(GetItemPossessedBy(oPC, NEWS_PERMISSION_ITEM)))
    {
        return TRUE;
    }
    return FALSE;
}
