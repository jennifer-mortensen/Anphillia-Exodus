//::///////////////////////////////////////////////
//:: Name Newspaper: Begin Conversation!
//:: FileName j_paper
//:://////////////////////////////////////////////
/*
    Begins a silent, secret newspaper conversation :-)
*/
//:://////////////////////////////////////////////
//:: Created By: Japerre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    object oPC = GetItemActivator();
    if(!GetIsObjectValid(oPC)) return;
    // Conversation
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionStartConversation(oPC, PAPER_AND_DIALOG_NAME, TRUE, FALSE));
}
