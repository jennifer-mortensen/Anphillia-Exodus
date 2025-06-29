#include "NW_I0_GENERIC"
#include "_inc_faction"
#include "_inc_time"

void main()
{
    ClearAllActions();
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

    object oModule = GetModule();

    int nTimeElapsedSinceHornSignal = GetSecondsSinceServerBoot() - GetLocalInt(oModule, GetTag(OBJECT_SELF) + "_HORN_SIGNAL");
    int nHasSignaledHorn = GetLocalInt(oModule, GetTag(OBJECT_SELF) + "_HAS_SIGNALED_HORN");
    int nHornSignalDelay = GetLocalInt(OBJECT_SELF, "HORN_SIGNAL_DELAY");

    if(nTimeElapsedSinceHornSignal < nHornSignalDelay && nHasSignaledHorn) //Spam prevention.
        return;

    SetLocalInt(oModule, GetTag(OBJECT_SELF) + "_HAS_SIGNALED_HORN", TRUE);
    SetLocalInt(oModule, GetTag(OBJECT_SELF) + "_HORN_SIGNAL", GetSecondsSinceServerBoot());

    object oArea = GetArea(OBJECT_SELF);
    int nSignalMessage = GetLocalInt(OBJECT_SELF, "SIGNAL_MESSAGE");
    int nMyFaction;
    string sSignalMessage;

    if(GetIsOfFaction(OBJECT_SELF, FACTION_AXFELL))
        nMyFaction = FACTION_AXFELL;
    else if(GetIsOfFaction(OBJECT_SELF, FACTION_CLEAVEN))
        nMyFaction = FACTION_CLEAVEN;

    if(nSignalMessage == 1)
    {
        sSignalMessage = "<cþ× >[Player] " + GetName(OBJECT_SELF) + " requests that reinforcements be sent to " + GetName(oArea) + "!</c>";
        PlaySound("al_pl_x2wardrum2");
    }
    else if(nSignalMessage == 0)
    {
        sSignalMessage = "<cþ× >[Player] " + GetName(OBJECT_SELF) + " has sighted enemy movement in " + GetName(oArea) + "!</c>";
        PlaySound("as_an_wolfhowl1");
    }

    SpeakString("[" + GetName(OBJECT_SELF) + " blows a horn.]");

    //Now let's send the message to all players.
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        SendMessageToPC(oPC, sSignalMessage);
        AssignCommand(oPC, PlaySound("as_an_wolfhowl1"));
        oPC = GetNextPC();
    }
}
