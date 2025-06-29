#include "moth_inc_effects"
#include "_inc_subdual"
#include "_inc_horse"
#include "_inc_death"
#include "_inc_time"
#include "anphrez_inc"
#include "_inc_faction"

void main()
{
    object oPC = GetLastPlayerDied();
    if (CheckSubdual(oPC)) return; //J. Persinne; subdual mode added.
    object oHenchman = GetHenchman(oPC);
    object oKiller;
    location lTarget;
    object oTarget;
    location lLocation;
    int nPvPDeath = FALSE;
    int nPCFaction;
    int nKillerFaction;

    if (GetIsOfFaction(oPC, FACTION_AXFELL))
    {
        oTarget = GetWaypointByTag("AxfellFugue");
        lTarget = GetLocation(oTarget);
    }
    else if(GetIsOfFaction(oPC, FACTION_CLEAVEN))
    {
        oTarget = GetWaypointByTag("CleavenFugue");
        lTarget = GetLocation(oTarget);
    }

    int iDidXPLoss = GetLocalInt (oPC, "DidXPLoss");
    if (!iDidXPLoss)
    {
        nKillerFaction = GetFaction(oKiller);
        nPCFaction = GetFaction(oPC);
        oKiller = GetTrueKiller(oPC, TRUE);

        if(GetSecondsSinceServerBoot() < GetLocalInt(oPC, "SUBDUED_BY_ENEMY"))
        {
            nPvPDeath = DEATH_PVP_DEATH;
        }
        else
        {
            nPvPDeath = GetLocalInt(oPC, "PvPDeath");
            if(!nPvPDeath && ((nKillerFaction && nKillerFaction != nPCFaction) || !GetIsObjectValid (oKiller) || GetName(oKiller) == ""))
                nPvPDeath = DEATH_PVP_DEATH;
        }
        DoXPLoss (oPC, nPvPDeath, FALSE);
        //AnphCheckPK (oPC, oKiller); Feb. 26 2010; Temporary disable for testing purposes.

        if (GetIsObjectValid (oKiller))
            SendMessageToAllDMs("** " + GetName(oPC) + " was killed by "+ GetName(oKiller) + " in " + GetName(GetArea(oKiller)));

        if(nPvPDeath){
        WriteTimestampedLogEntry("*** PvP Death -!- killerLogin:" + GetPCPlayerName(oKiller) + ",  killer:" + GetName(oKiller) + ",  victimLogin:" +  GetPCPlayerName(oPC) + ", victim:" + GetName(oPC) + ", area:" + GetName(GetArea(oKiller)) + ", ***");
        }else{
        WriteTimestampedLogEntry("*** PvE Death -!- killer:" + GetName(oKiller) + ",  victimLogin:" +  GetPCPlayerName(oPC) + ", victim:" + GetName(oPC) + ", area:" + GetName(GetArea(oKiller)) + ", ***");
        }
    }

    DeleteLocalInt(oPC, "PvPDeath");
    DeleteLocalInt(oPC, "SUBDUED_BY_ENEMY");

    if (GetIsObjectValid(oHenchman))
        RemoveHenchman(oPC, oHenchman);
    DropGold(oPC);

    if(GetArea(oPC) != OBJECT_INVALID) //J. Persinne; check added to ensure that we don't overwrite a valid location with an invalid one; this is so that we don't
    {                                  //have our corpses disappearing on us.
        location lDiedHere = GetLocation (oPC);
        SetLocalLocation (oPC, "DeathLocation", lDiedHere);
    }
    /* ensure we do not take xp more than once. */

    SetLocalInt (oPC, "DidXPLoss", 1);
    DelayCommand (20.0, DeleteLocalInt (oPC, "DidXPLoss"));

    // delete the last hostile actor again
    //Restore to full health once in Fugue
    DelayCommand(1.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectResurrection (), oPC));
    DelayCommand(1.0, ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectHeal (GetMaxHitPoints (oPC)), oPC));

    HandleHorseSettingsOnDeath(oPC);
    // Jump to correct Fugue

    AssignCommand(oPC, ClearAllActions());
    DelayCommand(0.5, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
    DelayCommand(0.8, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));

    HandleRelicLoss(oPC);
    MothGiveHalfOrcItem(oPC);
    MothSetShifterLevels(oPC);
    MothSetIsPMCaster(oPC);
}



