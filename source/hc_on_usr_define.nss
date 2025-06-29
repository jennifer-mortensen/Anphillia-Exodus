// HardCore Ruleset User Define
// Archaegeo 2002 Aug 10
//
// Much script from the PWDB system by Valerio Santinelli

#include "hc_inc"
#include "hc_inc_on_user"
#include "hc_inc_htf"
#include "hc_inc_timecheck"

void PWDB_SaveToDatabase()
{
    WriteTimestampedLogEntry("PWDB_SaveToDatabase()");
    // Set some test vars on PCs who haven't had them.
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        if (GetLocalInt(oPC, "PV_TEST_VARS_SET"))
        {
          oPC = GetNextPC();
          continue;
        }
        if(!GetIsDM(oPC))
            SetPersistentLocation(oPC, "PV_START_LOCATION", GetLocation(oPC));
        SetLocalInt(oPC, "PV_TEST_VARS_SET", 1);

        oPC = GetNextPC();
    }

    object oMod = GetModule();
    int iHeartBeat = GetLocalInt(oMod, "TMP_HBMONITOR");
    SetPersistentInt(oMod,"CurrentYear",GetCalendarYear());
    SetPersistentInt(oMod,"CurrentMonth",GetCalendarMonth());
    SetPersistentInt(oMod,"CurrentDay",GetCalendarDay());
    SetPersistentInt(oMod,"CurrentHour",GetTimeHour());
    SetPersistentInt(oMod,"CurrentMin",GetTimeMinute());
    if (iHeartBeat == 0)
    {
        SetLocalInt(oMod, "TMP_HBMONITOR", 1);
        WriteTimestampedLogEntry("Saving ALL to PWDB");
        PWDBSaveAll();
    }
    else
    {
        SetLocalInt(oMod, "TMP_HBMONITOR", 0);
        WriteTimestampedLogEntry("Saving CHANGED to PWDB");
        PWDBSaveChanged();
    }

    // If all clients have left, save the entire database.
    object oTemp = GetFirstPC();
    int iPlayerCount = 0;
    while (oTemp != OBJECT_INVALID)
    {
        iPlayerCount++;
        oTemp = GetNextPC();
    }

    int iSavedAll = GetLocalInt(oMod, "PWDB_SAVEDALL");
    if (iPlayerCount < 1 && !iSavedAll)
    {
        SetLocalInt(oMod, "PWDB_SAVEDALL", 1);
        PWDBSaveAll();
    }
    else if (iPlayerCount > 0 && iSavedAll)
    {
        SetLocalInt(oMod, "PWDB_SAVEDALL", 0);
    }
}

void main()
{
    int PWDB_HEARTBEAT_EVENT = 502;
    float BEAT_TIME = 60.0f;

    int nUser=GetUserDefinedEventNumber();

    if (nUser == PWDB_HEARTBEAT_EVENT) {
        // Set up the next iteration of the custom heartbeat
        event evEvent = EventUserDefined(PWDB_HEARTBEAT_EVENT);

        // Send the custom heartbeat event to myself in 1 minute
        DelayCommand(BEAT_TIME,SignalEvent(OBJECT_SELF,evEvent));
        PWDB_SaveToDatabase();
    }

    /*if (nUser == HTFCHKEVENTNUM)
    {
        int nCheckTime;
        nCheckTime=SecondsSinceBegin();
        nCheckTime+=(FloatToInt(HoursToSeconds(1))/60)*HTFCHKTIMER;
        SetLocalInt(oMod,"NEXTHTFCHECK",nCheckTime);
        LoopHTFSystemChk();
    }*/
    if(!preEvent()) return;
    postEvent();
}
