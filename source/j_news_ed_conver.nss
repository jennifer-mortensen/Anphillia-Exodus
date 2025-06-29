//::///////////////////////////////////////////////
//:: Name    Editor: Conversation
//:: FileName j_news_ed_conver
//:://////////////////////////////////////////////
/*
    Sets last spoken thing by a PC speaker to a local string, for future
    reference. Also starts conversation
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    // See if what we just 'heard' matches any of our
    // predefined patterns
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oPC = GetPCSpeaker();
    string sShout = GetMatchedSubstring(0);

    if(nMatch == -1)
    {
        // Not a match -- start an ordinary conversation
        if(GetCommandable() && !IsInConversation(OBJECT_SELF))
        {
            ClearAllActions();
            BeginConversation();
        }
    }
    // Special: Listen, if its the PC speaker (conversationist) we set local sting
    else if(nMatch == 888)
    {
        if(GetIsObjectValid(oShouter) &&
          (GetIsPC(oShouter) ||
           GetIsObjectValid(GetItemPossessedBy(oShouter, NEWS_PERMISSION_ITEM))) &&
           oShouter == oPC)
        {
            if(sShout != "")
            {
                SetLocalString(OBJECT_SELF, TEMP_LISTEN_STRING, sShout);
            }
        }
    }
}
