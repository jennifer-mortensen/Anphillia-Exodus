#include "hc_inc"
#include "anph_inc"
#include "anph_persist_inc"

void main()
{
    string sTeam = "";
    object oMarker;
    object oPC;
    object oLeader;
    int nGold;

    oPC = GetLastSpeaker ();
    oLeader = OBJECT_SELF;
    oMarker = GetObjectByTag (GetTag (oLeader) + "Marker");

    nGold = GetMaxHitPoints (oMarker);
    TakeGoldFromCreature (nGold, oPC, TRUE);

    sTeam = AnphGetPlayerTeam (oPC);

    SetAnphString (GetTag (oLeader) + "_team", sTeam);

    if (sTeam == "Axfell") {
        UpdateTeamFaction ("Cleaven", oLeader, -100);
        UpdateTeamFaction ("Drow", oLeader, -100);
        UpdateTeamFaction ("Axfell", oLeader, 80);
    } else if (sTeam == "Cleaven") {
        UpdateTeamFaction ("Cleaven", oLeader, 80);
        UpdateTeamFaction ("Drow", oLeader, -100);
        UpdateTeamFaction ("Axfell", oLeader, -100);
    } else if (sTeam == "Drow") {
        UpdateTeamFaction ("Cleaven", oLeader, -100);
        UpdateTeamFaction ("Axfell", oLeader, -100);
        UpdateTeamFaction ("Drow", oLeader, 80);
    }

    ApplyEffectToObject (DURATION_TYPE_INSTANT,EffectHeal(
                         GetMaxHitPoints(OBJECT_SELF)), OBJECT_SELF);
}
