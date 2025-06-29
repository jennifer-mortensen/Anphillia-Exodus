#include "_inc_assault"
void main()
{
    string sWaypointTag = GetLocalString(OBJECT_SELF, "WAYPOINT_DESTINATION");
    object oWaypoint = GetWaypointByTag(sWaypointTag);
    object oPC = GetLastUsedBy();

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToObject(oWaypoint));
    if(!GetIsImmune(oPC, IMMUNITY_TYPE_KNOCKDOWN))
        DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 12.0));
    else
        DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneParalyze(), oPC, 12.0));

    DelayCommand(0.1, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_COLD), GetLocation(oWaypoint)));
    SendAssaultMessage("You need a moment to recover from the fall.", oPC);
}
