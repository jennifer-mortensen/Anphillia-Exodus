//::///////////////////////////////////////////////
//:: Name  Newspaper Editor: Set listened string
//:: FileName j_news_ed_setlis
//:://////////////////////////////////////////////
/*
    We set the max size, and set it to the custom token.
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "j_news_ed_inc"

void main()
{
    // What are we editing?
    string sListened = GetLocalString(OBJECT_SELF, TEMP_LISTEN_STRING);
    string sSet;// limited size
    if(sListened == "")
    {
        SpeakString("ERROR: No set string!");
        SetCustomToken(TEMP_CONVER_TEXT, ERROR);
        return;
    }
    int iWhat = GetLocalInt(OBJECT_SELF, EDIT_TITLE_OR_PAGE);
    if(iWhat == PAGE)
    {
        if(GetStringLength(sListened) <= MAX_PAGE_SIZE)
        {
            sSet = sListened;
        }
        else
        {
            sSet = GetStringLeft(sListened, MAX_PAGE_SIZE);
        }
        SetCustomToken(TEMP_CONVER_TEXT, sSet);
        SetLocalString(OBJECT_SELF, FINAL_LISTEN_STRING, sSet);
    }
    else if(iWhat == TITLE)
    {
        if(GetStringLength(sListened) <= MAX_TITLE_SIZE)
        {
            sSet = sListened;
        }
        else
        {
            sSet = GetStringLeft(sListened, MAX_TITLE_SIZE);
        }
        SetCustomToken(TEMP_CONVER_TEXT, sSet);
        SetLocalString(OBJECT_SELF, FINAL_LISTEN_STRING, sSet);
    }
    else
    {
        SpeakString("ERROR: Don't know if it is a title or page!");
        SetCustomToken(TEMP_CONVER_TEXT, ERROR);
        DeleteLocalString(OBJECT_SELF, FINAL_LISTEN_STRING);
    }
}
