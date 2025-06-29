#include "NW_I0_GENERIC"
#include "moth_inc_effects"
void main()
{
     SetDeity(OBJECT_SELF,"MOTH");
     MothGuardBuff(OBJECT_SELF, FALSE);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectTemporaryHitpoints(500)), OBJECT_SELF);
     SetListeningPatterns();
     //WalkWayPoints();

    //Disable stoney ground around myself so that ladders can no longer be set.

    //string sTag;
    //int i = 1;
    //int nTerminateLoop;
    //object oGround = GetNearestObject(OBJECT_TYPE_PLACEABLE);

    object oSpawnWaypoint = GetWaypointByTag(GetResRef(OBJECT_SELF));  //J. Persinne; needed in order to know whether we've gone far enough from our
    SetLocalObject(OBJECT_SELF, "MY_SPAWN_POINT", oSpawnWaypoint);     //spawn point to require a force return.

    //string sPlacementTag = GetLocalString(OBJECT_SELF, "MY_GROUND_TAG");
    //oGround = GetObjectByTag(sPlacementTag);
    //SetLocalObject(oGround, "MY_GUARD", OBJECT_SELF);
    //SetLocalObject(oGround, "MY_GUARD_SPAWN_POINT", oSpawnWaypoint);
    //SetLocalObject(OBJECT_SELF, "MY_GROUND", oGround);
    //SetUseableFlag(oGround, FALSE);
}


