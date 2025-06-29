#include "anph_db_inc"
#include "_inc_db"
#include "_inc_const"
#include "_inc_gen"

void main()
{
    object oPC = GetFirstPC();

    itemproperty iProperty;
    int iVal;
    iVal = GetLocalInt (OBJECT_SELF, "count");
    iVal++;
    if (iVal == 5 ||
        iVal == 15)
    {
        AnphCampaignSyncPlayers ();
    }
    else if (iVal == 10)
    {
        AnphCampaignSyncGlobal ();
    }
    else if (iVal == 13)
    {
       int nYear = GetCalendarYear();
       int nMonth = GetCalendarMonth();
       int nDay = GetCalendarDay();
       int nHour = GetTimeHour();
       int nMinute = GetTimeMinute();
       string sDateTime = "YS" + IntToString(nYear) + "YE" +
                          "MS" + IntToString(nYear) + "ME" +
                          "DS" + IntToString(nYear) + "DE" +
                          "HS" + IntToString(nYear) + "HE" +
                          "TS" + IntToString(nYear) + "TE";
       SetCampaignString("Anphillia", "DateTime", sDateTime);
    }
    else if (iVal == 19)
    {
        if(DISABLE_SERVER_SAVE == TRUE) //Used for local vault testing.
            return;
        SendMessageToAllDMs ("Saving all characters...");
        WriteTimestampedLogEntry ("Saving all characters...");
        while(GetIsObjectValid(oPC)) //J. Persinne; We now loop through PCs on save in order to store database variables.
        {
            if(!GetIsDM(oPC))
            {
                if(!GetIsPolymorphed(oPC))
                {
                    ExportSingleCharacter(oPC);
                    SavePCDatabaseVariables(oPC);
                }
            }
            oPC = GetNextPC();
        }
        SendMessageToAllDMs ("Saving Characters Complete.");
        WriteTimestampedLogEntry ("Saving Complete.");
    }
    else if (iVal == 20)
    {
        iVal = 0;
        AnphCampaignSyncGlobal ();

    }
    SetLocalInt (OBJECT_SELF, "count", iVal);
}
