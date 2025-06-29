//::///////////////////////////////////////////////
//:: Name Editor: Delete String in Database
//:: FileName j_news_ed_deldta
//:://////////////////////////////////////////////
/*
    Sets the data, to NOTHING, as it were.
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    int iWhat = GetLocalInt(OBJECT_SELF, EDIT_TITLE_OR_PAGE);
    int iStory = GetLocalInt(OBJECT_SELF, STORY_TO_ED_OR_DEL);
    int iPage = GetLocalInt(OBJECT_SELF, EDIT_PAGE_NUMBER);
    string sData = "NOTHING";
    string sSetTo;
    if(iWhat == TITLE)
    {
        sSetTo = TITLE_ + IntToString(iStory);
        News_SetDatabaseString(sSetTo, sData);
        SetLocalString(OBJECT_SELF, CURRENT_STORY_TITLE_PAGE + IntToString(iPage), sData);
        SetLocalString(OBJECT_SELF, sSetTo, sData);
        SetCustomToken(iEditStoryNumBase, sData);
        DeleteLocalString(OBJECT_SELF, FINAL_LISTEN_STRING);
        SpeakString("Sucess! Deleted Title");
    }
    else if(iWhat == PAGE)
    {
        if(iPage)
        {
            sSetTo = STORY_ + IntToString(iStory) + _PAGE_ + IntToString(iPage);
            News_SetDatabaseString(sSetTo, sData);
            SetLocalString(OBJECT_SELF, CURRENT_STORY_TITLE_PAGE + IntToString(iPage), sData);
            SetLocalString(OBJECT_SELF, sSetTo, sData);
            SetCustomToken(iEditStoryNumBase + iPage, sData);
            DeleteLocalString(OBJECT_SELF, FINAL_LISTEN_STRING);
            SpeakString("Sucess! Deleted page number " + IntToString(iPage));
        }
        else
        {
            SpeakString("Error: No idea of page number");
        }
    }
    else
    {
        SpeakString("Error: No idea if title or page");
    }
}
