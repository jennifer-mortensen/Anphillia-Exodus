#include "_inc_const"
#include "_inc_gen"
#include "_inc_time"
#include "moth_inc_effects"
#include "_inc_faction"

/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Change these constants to set the maximum of 'knockout hits' that a PC can
// receive before moving to the next stage of unconsciousness.
// For example, if SUBDUE_WINDED = 3, a PC can receive 3 hits in a short period
// of time and remain winded. 4 hits will cause him to black out.

// Main subdual check funciton. Call only in OnPlayerDeath and OnPlayerDying.
// Will return the degree of damage the player has incurred, or 0 if it was
// not subdual damage.
int CheckSubdual(object oPC);

// Only CheckSubdual is meant to be called, and then only from
// OnPlayerDeath and OnPlayerDying. The rest are internal functions.

void SetSubdualHealth(object oPC);
void SetSubdued(object oPC, int nNumberOfSubdualBlows);
void SubdualDecrease(object oPC, int nLastValue);
int GetSubdual(object oPC);

int CheckSubdual(object oPC)
{
    int nSubdualType = GetSubdual(oPC);
    if(nSubdualType)
    {
        int nNumberOfSubdualBlows = GetLocalInt(oPC, "nSubdued");
        if(!(nSubdualType == SUBDUAL_MODE_SPARRING && nNumberOfSubdualBlows == SUBDUE_WINDED))
            nNumberOfSubdualBlows++;
        SetLocalInt(oPC, "nSubdued", nNumberOfSubdualBlows);
        SetSubdualHealth(oPC);
        SetSubdued(oPC, nNumberOfSubdualBlows);
        return nNumberOfSubdualBlows;
    }
    return FALSE;
}

void SetSubdualHealth(object oPC)
{
    int nCurrentHitPoints = GetCurrentHitPoints(oPC);
    if(nCurrentHitPoints < -9)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
        ExecuteScript("exe_bonuses", oPC);
        ExecuteScript("exe_appimmunes", oPC);
    }
    else if(nCurrentHitPoints < 1)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(abs(nCurrentHitPoints + 1)), oPC);
}

void SetSubdued(object oPC, int nNumberOfSubdualBlows)
{

    float fTimeDazed;
    float fTimeUnconscious;
    int nACDecrease;
    int nMoveDecrease;
    string sMessage;

    if(nNumberOfSubdualBlows <= SUBDUE_WINDED)
    {
        sMessage = "[" + GetName(oPC) + " is winded.]";
        fTimeUnconscious = 15.0;
        fTimeDazed = 30.0;
        nMoveDecrease = 20;
        nACDecrease = 2;
    }
    else if(nNumberOfSubdualBlows <= SUBDUE_BLACKOUT)
    {
        sMessage = "[" + GetName(oPC) + " has blacked out.]";
        fTimeUnconscious = 30.0;
        fTimeDazed = 60.0;
        nMoveDecrease = 35;
        nACDecrease = 5;
    }
    else if(nNumberOfSubdualBlows <= SUBDUE_KNOCKOUT)
    {
        sMessage = "[" + GetName(oPC) + " has been knocked out.]";
        fTimeUnconscious = 45.0;
        fTimeDazed = 120.0;
        nMoveDecrease = 50;
        nACDecrease = 7;
    }
    else
    {
        sMessage = "[" + GetName(oPC) + " has suffered a concussion.]";
        fTimeUnconscious = 60.0;
        fTimeDazed = 240.0;
        nMoveDecrease = 75;
        nACDecrease = 10;
    }
    AssignCommand(oPC, ClearAllActions());
    if(nNumberOfSubdualBlows == 1 || nNumberOfSubdualBlows == SUBDUE_WINDED + 1 || nNumberOfSubdualBlows == SUBDUE_BLACKOUT + 1 || nNumberOfSubdualBlows == SUBDUE_KNOCKOUT + 1)
        AssignCommand(oPC, ActionSpeakString(sMessage));
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, fTimeUnconscious));
    AssignCommand(oPC, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedDecrease(nMoveDecrease), oPC, fTimeDazed)));
    AssignCommand(oPC, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACDecrease(nACDecrease), oPC, fTimeDazed)));
    AssignCommand(oPC, ActionDoCommand(SetCommandable(TRUE, oPC)));
    AssignCommand(oPC, SetCommandable(FALSE, oPC));
    DelayCommand(fTimeUnconscious + fTimeDazed, SubdualDecrease(oPC, nNumberOfSubdualBlows));
}

// Returns type of subdual.
// GetLastAttacker, GetGoingToBeAttackedBy, GetLastHostileActor
// seem to work correctly in an ondeath script for a PC.
// To be safe, check everything for a possible subdual attack.
// If there is an incorrect positive, the attacker can always hit
// the PC again.
int GetSubdual(object oPC)
{
    int nSubdualType;

    if(GetLocalInt(GetArea(oPC), "ARENA_AREA"))
        return SUBDUAL_MODE_SPARRING;

    object oKiller = GetTrueKiller(oPC, TRUE);
    int nKillerFaction = GetFaction(oKiller);

    nSubdualType = GetLocalInt(oKiller, "SUBDUAL");

    if(nSubdualType && nKillerFaction && (nKillerFaction != GetFaction(oPC)))
        SetLocalInt(oPC, "SUBDUED_BY_ENEMY", GetSecondsSinceServerBoot() + 300); //Used to track whether to count a death as a PvP death after a PC is subdued; applies for five minutes.

    return nSubdualType;
}

void SubdualDecrease(object oPC, int nLastValue)
{
    if(GetLocalInt(oPC, "nSubdued") == nLastValue)
        SetLocalInt(oPC, "nSubdued", 0);
}
