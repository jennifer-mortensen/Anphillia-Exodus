//::///////////////////////////////////////////////
//:: Name Editor: End of conversation
//:: FileName j_news_all_done
//:://////////////////////////////////////////////
/*
    Deletes all locals.
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"
#include "x0_i0_walkway"

void main()
{
    //(News_GetDatabaseString/News_SetDatabaseString)
    int iStory, iPage, iTitle;

    // First: Titles: TITLE_1 to TITLE_10 (max: 50 letters)
    for(iStory = 1; iStory <= i10; iStory++)
    {
        // Makes: 810, 820 ETC. (to 900)
        iTitle = (i800 + (i10 * iStory));
        // Title
        DeleteLocalString(OBJECT_SELF, TITLE_ + IntToString(iStory));
        // Pages...3 for now
        // STORY_1 (to 10) + _PAGE_ + 1 (to 3) EG: STORY_2_PAGE_3
        for(iPage = 1; iPage <= 3; iPage++)
        {
            DeleteLocalString(OBJECT_SELF, STORY_ + IntToString(iStory) + _PAGE_ + IntToString(iPage));
        }
    }
    // What they last said (when we listen!)
    DeleteLocalString(OBJECT_SELF, TEMP_LISTEN_STRING);
    DeleteLocalString(OBJECT_SELF, FINAL_LISTEN_STRING);
    DeleteLocalObject(OBJECT_SELF, PC_SPEAKER);
    DeleteLocalInt(OBJECT_SELF, EDIT_OR_DELETE);
    DeleteLocalInt(OBJECT_SELF, STORY_TO_ED_OR_DEL);
    DeleteLocalInt(OBJECT_SELF, EDIT_PAGE_NUMBER);
    DeleteLocalInt(OBJECT_SELF, CURRENT_STORY_CHECK);
    WalkWayPoints();
}
