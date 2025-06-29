//::///////////////////////////////////////////////
//:: Name
//:: FileName j_news_pp_valid
//:://////////////////////////////////////////////
/*
    Is the string for the story valid? (needs a title != NOTHING)
*/
//:://////////////////////////////////////////////
//:: Created By:
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

int StartingConditional()
{
    int iStory = GetLocalInt(OBJECT_SELF, CURRENT_STORY_CHECK);
    string sTitleContents;
    if(iStory == 0)
    {
        iStory = 1;
    }
    else if(iStory > 10 || iStory < 0)
    {
        return FALSE;
    }

    if(iStory == 10)
    {
        DeleteLocalInt(OBJECT_SELF, CURRENT_STORY_CHECK);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, CURRENT_STORY_CHECK, iStory + 1);
    }
    sTitleContents = GetLocalString(OBJECT_SELF, TITLE_ + IntToString(iStory));
    if(sTitleContents != NOTHING && sTitleContents != "")
    {
        return TRUE;
    }
    return FALSE;
}
