#include "_inc_const"

void main()
{
    string sWaypointTag = GetLocalString(OBJECT_SELF, "WAYPOINT_DESTINATION");
    object oWaypoint = GetWaypointByTag(sWaypointTag);
    object oPC = GetPCSpeaker();

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToObject(oWaypoint));
}
