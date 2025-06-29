#include "hc_inc"
#include "anph_inc"


void jumpToFugue (object oPlayer)
{
    string sLimboTag;

    // Get Faction's Fugue
    int iPlayerTeam = AnphGetPlayerTeamInt (oPlayer);
    sLimboTag = GetLocalString(oMod, "FACTION_0" + IntToString(iPlayerTeam) + "_FUGUE");

    //SendMessageToPC (oPlayer, "Player fugue tag:" + sLimboTag);

    object oLimbo = GetObjectByTag (sLimboTag);
    AssignCommand (oPlayer, JumpToObject (oLimbo));
    object oPC = GetLastRespawnButtonPresser ();
    ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectResurrection (), oPC);
    ApplyEffectToObject (DURATION_TYPE_INSTANT, EffectHeal (GetMaxHitPoints (oPC)), oPC);
    // Reactivate Elementeal Trial if player does one
    //SetLocalObject(GetObjectByTag("TrialStore"), "oPCFailed", oPC);
    //SignalEvent(GetObjectByTag("ElementalTrial"), EventUserDefined(696969));
    jumpToFugue (oPC);
}
