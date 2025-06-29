//::///////////////////////////////////////////////
//:: Name Vendor: Give paper
//:: FileName j_news_vn_paper
//:://////////////////////////////////////////////
/*
    gives the paper item. It is called The Empire Paper by default. Easily
    changed.

    Tag: j_news_paper
    Resref: j_news_paper
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(PAPER_COST, oPC, TRUE);// take gold
    CreateItemOnObject(PAPER_AND_DIALOG_NAME, oPC);// Give
}
