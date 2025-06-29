//::///////////////////////////////////////////////
//:: Name Vendor: Gold check
//:: FileName j_news_vn_gold
//:://////////////////////////////////////////////
/*
    have they got the gold needed?

    This will return TRUE if we have NOT got the gold needed.

    Can change PAPER_COST in include file to amount. Default: 5
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////
#include "j_news_ed_inc"

int StartingConditional()
{
    // Set custom token...
    SetCustomToken(VENDOR_PRICE_CUSTOM, IntToString(PAPER_COST));
    object oPC = GetPCSpeaker();
    int iGold = GetGold(oPC);
    if(iGold < PAPER_COST)
    {
        return TRUE;
    }
    return FALSE;
}
