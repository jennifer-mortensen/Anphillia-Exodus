//
// Now the location where all features have their default value set.
// This is to allow things to be toggleable on the fly.
#include "hc_inc"
#include "hc_inc_on_load"
#include "hc_inc_htf"
#include "moth_inc"
#include "moth_inc_puzzle"
#include "moth_inc_loot"
#include "anph_persist_inc"
#include "x2_inc_switches"
#include "fb_inc_chat"

int ExtractDateTimeInteger(string sDateTime, string sStart, string sEnd)
{
   int nStartPos = FindSubString(sDateTime, sStart);
   int nEndPos = FindSubString(sDateTime, sEnd);
   int nLength = GetStringLength(sDateTime);

   string sResult = GetSubString(sDateTime, nStartPos + 2, nEndPos - (nStartPos + 2));
   return (StringToInt(sResult));
}
void main()
{
    fbCHInit(); //NWNX Chat Handler

    SetCustomToken(2000, "</c>"); //Close color brackets.
    SetCustomToken(2001, "<c »þ>"); //blue
    SetCustomToken(2002, "<cþ  >"); //red

    SetMaxHenchmen(1);
    int PWDB_HEARTBEAT_EVENT = 502;
    WriteTimestampedLogEntry ("********************************************");
    WriteTimestampedLogEntry ("*****A N P H I L L I A - E X O D U S********");
    WriteTimestampedLogEntry ("********************************************");
    // Execute ConfigScript
    ExecuteScript("anph_config_inc", OBJECT_SELF);
    //Creates reboot-unique items in the stated container. Check moth_inc_random for details.
    //MothRandomItemLow("X0_MOD_TREASURE_LOW",TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE);
    //MothRandomItemMedium("X0_MOD_TREASURE_MED",TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE);
    //MothRandomItemHigh("X0_MOD_TREASURE_HIGH",TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE);
    //MothCreatePetTraps();
    //Modifies the Time XP. Check the moth_inc script for details.
    MothGiveTimeXPSettings(oMod);
    // enable AoE spells to hurt everyone
    SetLocalInt(oMod, "X0_G_ALLOWSPELLSTOHURT", 10);
    SetLocalInt(oMod, "mothdisc1", 0);
    SetLocalInt(oMod, "PPAutoBoot", FALSE);
    SetLocalInt(oMod, "JelenaQuest", FALSE);
    AnphPersistModuleInit ();
    //MothDepopStart();
    // Load the persistent data
    if (GetLocalInt(oMod,"AlreadyExecutedOMD") ==1)
    {
        postEvent();
        return;
    }
    else
    SetLocalInt(oMod,"AlreadyExecutedOMD",1);
    ExecuteScript("hc_pwdb_data",oMod);
    // Setup the event to save the world
    event evEvent = EventUserDefined(PWDB_HEARTBEAT_EVENT);
    SignalEvent(OBJECT_SELF,evEvent);
    ExecuteScript("wa_narbondel", GetModule()); // Activate Narbondel
    if(!preEvent()) return;
    ExecuteScript("hc_defaults",oMod);
    ExecuteScript("hc_setareavars",oMod);
    // Get the persistent Time and set it
    string sDateTime = GetCampaignString("Anphillia", "DateTime");
    int iCurYear = ExtractDateTimeInteger(sDateTime, "YS", "YE");
    int iCurMonth = ExtractDateTimeInteger(sDateTime, "MS", "ME");
    int iCurDay = ExtractDateTimeInteger(sDateTime, "DS", "DE");
    int iCurHour = ExtractDateTimeInteger(sDateTime, "HS", "HE");
    int iCurMin = ExtractDateTimeInteger(sDateTime, "TS", "TE");
    /*
    int iCurYear=GetCampaignInt("Anphillia","CurrentYear");
    int iCurMonth=GetCampaignInt("Anphillia","CurrentMonth");
    int iCurDay=GetCampaignInt("Anphillia","CurrentDay");
    int iCurHour=GetCampaignInt("Anphillia","CurrentHour");
    int iCurMin=GetCampaignInt("Anphillia","CurrentMin");
    */
    SetCalendar(iCurYear, iCurMonth, iCurDay);
    SetTime(10, 0, 0, 0);
    /* Remember starting year.. this is so that the seconds
       since start thing doesn't make the integer too big. */
    SetLocalInt(oMod, "ModuleStartYear", GetCalendarYear ());
    /* Initialize Anphillia */
    ExecuteScript("anph_initialize", GetModule());
    SetLocalInt(oMod,"bX3_MOUNT_NO_ZAXIS",TRUE);
    SetLocalFloat(oMod,"fX3_TIMEOUT_TO_MOUNT",7.0f);
    SetLocalFloat(oMod,"fX3_FREQUENCY",1.0);
    SetLocalInt(oMod,"X3_HORSE_ACT_VS_DELAY",TRUE);
    SetLocalInt(oMod,"X3_HORSE_ENABLE_SADDLEBAGS",FALSE);
    SetLocalInt(oMod,"X3_HORSE_DISABLE_SPEED",FALSE);
    SetLocalInt(oMod,"X3_NO_MOUNT_COMMANDABLE",TRUE);
    SetLocalInt(oMod,"X3_HORSE_ENABLE_ACBOOST",FALSE);
    SetLocalInt(oMod,"X3_HORSE_ENABLE_HPBOOST",FALSE);
    SetLocalInt(oMod,"X3_ENABLE_MOUNT_DAMAGE",TRUE);
    SetLocalInt(oMod,"X3_HORSE_DISABLE_SKILL",TRUE);
    SetLocalInt(oMod,"X3_MOUNTS_EXTERNAL_ONLY",FALSE);
    SetLocalInt(oMod,"X3_HORSE_NO_CORPSES",TRUE);
    postEvent();
}
