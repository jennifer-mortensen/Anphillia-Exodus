//::///////////////////////////////////////////////
//:: Name Newspaper Editor: Set Variables
//:: FileName j_news_ed_start
//:://////////////////////////////////////////////
/*
    Sets things up:

    // Titles...
    810, 820, 830, ETC to 900.
    // Pages...
    811 = Page 1...story 1
    812 = PAge 2...story 1
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    //(News_SetDatabaseString/News_GetDatabaseString)
    int iStory, iPage, iTitle;
    string sTitleContent, sTitleName, sPageContent, sPageName;

    // First: Titles: TITLE_1 to TITLE_10 (max: 50 letters)
    for(iStory = 1; iStory <= i10; iStory++)
    {
        // Makes: 810, 820 ETC. (to 900)
        iTitle = (i800 + (i10 * iStory));
        // Set title
        sTitleName = TITLE_ + IntToString(iStory);
        sTitleContent = News_GetDatabaseString(sTitleName);
        SetCustomToken(iTitle, sTitleContent);
        // Store it via. Local as well.
        SetLocalString(OBJECT_SELF, sTitleName, sTitleContent);
        // Set pages...
        // Pages...3 for now
        // STORY_1 (to 10) + _PAGE_ + 1 (to 3) EG: STORY_2_PAGE_3
        for(iPage = 1; iPage <= 3; iPage++)
        {
            sPageName = STORY_ + IntToString(iStory) + _PAGE_ + IntToString(iPage);
            sPageContent = News_GetDatabaseString(sPageName);
            SetCustomToken(iTitle + iPage, sPageContent);
            SetLocalString(OBJECT_SELF, sPageName, sPageContent);
        }
    }
}
