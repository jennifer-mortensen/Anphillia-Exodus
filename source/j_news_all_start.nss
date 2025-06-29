//::///////////////////////////////////////////////
//:: Name Newspaper Editor: Set Variables
//:: FileName j_news_all_start
//:://////////////////////////////////////////////
/*
    Sets things up:

    // Titles...
    810, 820, 830, ETC to 900.
    // Pages...
    811 = Page 1...story 1
    812 = PAge 2...story 1

    To customs, for both the paper AND the editor. IE it only does it once if
    not told to again!
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    // If we are the PC (IE conversation with self = newspaper) we read
    Read();

    //(News_GetDatabaseString/News_SetDatabaseString)
    int iStory, iPage, iTitle;
    string sTitleContent, sTitleName, sPageContent, sPageName;
    SetLocalObject(OBJECT_SELF, PC_SPEAKER, GetPCSpeaker());

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
// Page content is got by the string, later on when we choose a story
//            SetCustomToken(iTitle + i2, sPageContent);
            SetLocalString(OBJECT_SELF, sPageName, sPageContent);
        }
    }
}
