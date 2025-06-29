//::///////////////////////////////////////////////
//:: Name Newspaper Editor: Include
//:: FileName j_news_ed_inc
//:://////////////////////////////////////////////
/*
    Include file. Variables, one function. :-)
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

// these you CAN edit.

// The cost of the paper.
const int PAPER_COST                = 55;// In gold
// The maximum page size avalible.
const int MAX_PAGE_SIZE             = 255;// Characters
// The maximum title size avalible.
const int MAX_TITLE_SIZE            = 75;// Characters

// Vendor shouting. If not in combat/conversation and a nearby PC, we shout
// a random piece of news. These numbers confere the delays.

// In the daytime, this is added to
const int RANDOM_SHOUT_DELAY_DAY    = 60;// Seconds, 0 to this number is added. See Random()
// This is added by Random(RANDOM_SHOUT_DELAY_NIGHT) to the delay between shouts.
const int RANDOM_SHOUT_DELAY_NIGHT  = 180;// Seconds, 0 to this number is added. See Random()

// The base Delayed shout time.
const float BASE_SHOUT_DELAY        = 60.0;

// Vendor shouting strings. These are to be just strings they say.
const string VENDOR_SHOUT_ONE       = "Here ye! Here ye!";
const string VENDOR_SHOUT_TWO       = "Read all about it!";
const string VENDOR_SHOUT_THREE     = "New news! Read about the conditions in Axfell!";
const string VENDOR_SHOUT_FOUR      = "Hear all the war news first!";
const string VENDOR_SHOUT_FIVE      = "Get your paper here!";
const string VENDOR_SHOUT_SIX       = "All current events on Anphillia!";
const string VENDOR_SHOUT_SEVEN     = "No news like bad news!";
const string VENDOR_SHOUT_EIGHT     = "All the best daily!";
const string VENDOR_SHOUT_NINE      = "Get your Cleaven stories here!";
const string VENDOR_SHOUT_TEN       = "Everything thats fit to print!";

// The database name.
const string sDataBaseName          = "J_NEWSPAPER";

// Sets sData, to sDataName field, in sDataBaseName database.
// * The database name is in J_News_Ed_Inc, not here
void News_SetDatabaseString(string sDataName, string sData);
// Returns a string, at sDataName field, in sDataBaseName database.
// * The database name is in J_News_Ed_Inc, not here
string News_GetDatabaseString(string sDataName);

// These are WRAPPERS for the SET and GET functions.
// I am unsure how NWNx or whatever databases work, but these are what are
// currently used. Edit at your own risk!
string News_GetDatabaseString(string sDataName)
{
    // You can edit what it returns HERE
    return GetCampaignString(sDataBaseName, sDataName);
}
void News_SetDatabaseString(string sDataName, string sData)
{
    // You can edit what it sets HERE
    SetCampaignString(sDataBaseName, sDataName, sData);
}

/*:://////////////////////////////////////////////
 These you CAN NOT EDIT! NOTHING below here can be changed without risk!
//::////////////////////////////////////////////*/

// Variable names
const string EDIT_TITLE_OR_PAGE         = "EDIT_TITLE_OR_PAGE";
const string STORY_TO_ED_OR_DEL         = "STORY_TO_ED_OR_DEL";
const string EDIT_OR_DELETE             = "EDIT_OR_DELETE";
const string TEMP_LISTEN_STRING         = "TEMP_LISTEN_STRING";
const string FINAL_LISTEN_STRING        = "FINAL_LISTEN_STRING";
const string EDIT_PAGE_NUMBER           = "EDIT_PAGE_NUMBER";
const string CURRENT_STORY_CHECK        = "CURRENT_STORY_CHECK";
const string CURRENT_STORY_TITLE_STRING = "CURRENT_STORY_TITLE_STRING0";
const string CURRENT_STORY_TITLE_PAGE   = "CURRENT_STORY_TITLE_PAGE";
const string PC_SPEAKER                 = "PC_SPEAKER";

// Consants - special.

const string PAPER_AND_DIALOG_NAME  = "j_news_paper";
const string TORCH_TAG          = "NW_IT_TORCH";
const string NEWS_PERMISSION_ITEM = "j_news_permissio";// 16 chars, hehe

// Constants.
const int TITLE                 = 1;
const int PAGE                  = 2;
const int iEditStoryNumBase     = 910;
const int TEMP_CONVER_TEXT      = 920;
const int EDITOR_LISTEN_NUMBER  = 888;
const int VENDOR_PRICE_CUSTOM   = 921;
const int VENDOR_UDE_NUMBER     = 300;
const int i800                  = 800;
const int i10                   = 10;
const int DELETE                = 2;
const int EDIT                  = 1;
const string ARRAY_SHOUT        = "ARRAY_SHOUT";
const string TITLE_             = "TITLE_";
const string STORY_             = "STORY_";
const string _PAGE_             = "_PAGE_";
const string ERROR              = "ERROR";
const string NOTHING            = "NOTHING";

// Sets variables, new customs.
void SetStoryChoice(int iStory);
// Sets the variables for editing page number. Title is 0.
void SetEditingPage(int iTitlePage, int iPageNum);
// Plays reading animation if PC speaker is ourselves
void Read();

// Sets variables, new customs.
void SetStoryChoice(int iStory)
{
    Read();
    string sStoryInt = IntToString(iStory);// String version
    string sPagePrefix = STORY_ + IntToString(iStory) + _PAGE_;
    int i;
    // Customs from local variables.
    string sThing = GetLocalString(OBJECT_SELF, TITLE_ + sStoryInt);
    SetCustomToken(iEditStoryNumBase, sThing);
    SetLocalString(OBJECT_SELF, CURRENT_STORY_TITLE_PAGE + IntToString(0), sThing);
    // Pages
    for(i = 1; i <= 3; i++)
    {
        sThing = News_GetDatabaseString(sPagePrefix + IntToString(i));
        SetLocalString(OBJECT_SELF, CURRENT_STORY_TITLE_PAGE + IntToString(i), sThing);
        SetCustomToken(iEditStoryNumBase + i, sThing);
    }
    SetLocalInt(OBJECT_SELF, STORY_TO_ED_OR_DEL, iStory);
}

// Sets the variables for editing page number. Title is 0.
void SetEditingPage(int iTitlePage, int iPageNum)
{
    Read();
    SetLocalInt(OBJECT_SELF, EDIT_TITLE_OR_PAGE, iTitlePage);
    SetLocalInt(OBJECT_SELF, EDIT_PAGE_NUMBER, iPageNum);
    SetCustomToken(iEditStoryNumBase + iPageNum, GetLocalString(OBJECT_SELF, CURRENT_STORY_TITLE_PAGE + IntToString(iPageNum)));
}

void Read()
{
    // If we are the PC (IE conversation with self = newspaper) we read
    if(GetPCSpeaker() == OBJECT_SELF)
    {
        ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_READ));
    }
}
