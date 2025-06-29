#include "_inc_assault"
#include "spawn_functions"

void main()
{
    string sID = GetAssaultObjectID(OBJECT_SELF);

    object oClimber = GetLocalObject(OBJECT_SELF, "MY_CLIMBER");
    object oLadderPlacement = GetStoneyGroundFromID(sID);
    object oSpringboard = GetLadderTopFromID(sID);
    object oGuardSpawnPoint = GetWaypointByTag(GetLocalString(oLadderPlacement, "MY_GUARD_SPAWN_POINT"));

    SetUseableFlag(oLadderPlacement, TRUE);
    DestroyObject(oSpringboard);
    NESS_ActivateSpawn(oGuardSpawnPoint);
    if(GetIsObjectValid(oClimber))
        ApplyLadderFallDamage(oClimber);
}
