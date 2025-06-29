//::///////////////////////////////////////////////
//:: Name Editor: Check: Is deleting story
//:: FileName j_news_ed_isdel
//:://////////////////////////////////////////////
/*
    Are we deleting? (this is the only needed check, else it is editing!)
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, EDIT_OR_DELETE) == DELETE)
    {
        return TRUE;
    }

    return FALSE;
}
