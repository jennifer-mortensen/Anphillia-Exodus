#include "moth_inc_hb"
#include "_inc_subrace"
#include "_inc_time"

void main ()
{
    int nCurrentTime;
    int nHourOfDay = GetTimeHour();
    int nRemovePvPFlag;
    int nXPHour;
    object oPC;
    object oMod = GetModule();

    // Increment heartbeat counter.
    int nHBCount = GetLocalInt(oMod, "HBCount");
    int nHBAura = GetLocalInt(oMod, "HBAura");
    nHBCount++;
    nHBAura++;
    SetLocalInt(oMod, "HBCount", nHBCount);
    SetLocalInt(oMod, "HBAura", nHBAura);

    SetTime(nHourOfDay, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());

    if (nHBAura > 4)
    {
        MothAuraOfCourageHeartbeat();
        SetLocalInt(oMod, "HBAura", 0);
    }
    if (nHBCount > 8)
    {
        nCurrentTime = GetSecondsSinceServerBoot();
        nXPHour = GetLocalInt(oMod, "MothXPHour1");
        oPC = GetFirstPC();
        while(GetIsObjectValid(oPC))
        {
            if(!GetIsDM(oPC))
            {
                if(nHourOfDay == 6 || nHourOfDay == 19)
                    HandleLightBlindness(oPC);
                if(nHourOfDay == nXPHour)
                {
                    MothGiveTimeXP(oPC, oMod, nHourOfDay);
                }
                else //We don't update PvP flags and timed XP at the same time in order to avoid TMI errors.
                {
                    nRemovePvPFlag = GetLocalInt(oPC, "REMOVE_PVP_FLAG");
                    if(nCurrentTime >= nRemovePvPFlag && nRemovePvPFlag > 0)
                    {
                    DeleteLocalInt(oPC, "REMOVE_PVP_FLAG");
                    SetLocalInt(oPC, "CURRENT_PVP_STANCE", GetLocalInt(oPC, "DEFAULT_PVP_STANCE"));
                    ExecuteScript("exe_checkfaction", oPC); //Updates factions; executed via separate script to avoid TMI.
                }
            }

         }
         oPC = GetNextPC();
       }
       // end this heartbeat
       SetLocalInt(oMod, "HBCount", 0);
    }
}

