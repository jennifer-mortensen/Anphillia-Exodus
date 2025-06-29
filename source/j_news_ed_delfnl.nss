//::///////////////////////////////////////////////
//:: Name Editor: Delete Story Set
//:: FileName j_news_ed_delfnl
//:://////////////////////////////////////////////
/*
    Deletes the set story, or sets the variables to "NOTHING".
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    int iSetStory = GetLocalInt(OBJECT_SELF, STORY_TO_ED_OR_DEL);
    if(iSetStory)
    {
        //(News_GetDatabaseString/News_SetDatabaseString)
        int i, iTitle;
        // First: Title.
        News_SetDatabaseString(TITLE_ + IntToString(iSetStory), NOTHING);
        // Then: Pages.
        // Pages...3 for now
        // STORY_1 (to 10) + _PAGE_ + 1 (to 3) EG: STORY_2_PAGE_3
        for(i = 1; i <= 3; i++)
        {
            News_SetDatabaseString(STORY_ + IntToString(iSetStory) + _PAGE_ + IntToString(i), NOTHING);
        }
        SpeakString("Sucess! Deleted Entire Story: " + IntToString(iSetStory));
    }
    else
    {
        SpeakString("Error on deleting: No Found stored story");
    }
}
