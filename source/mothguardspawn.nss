#include "NW_I0_GENERIC"
#include "moth_inc_effects"
void main()
{
     SetDeity(OBJECT_SELF,"MOTH");
     MothGuardBuff();
     ApplyEffectToObject(DURATION_TYPE_PERMANENT, ExtraordinaryEffect(EffectTemporaryHitpoints(1000)), OBJECT_SELF);
     SetListeningPatterns();
     //WalkWayPoints();

     object oSpawnWaypoint = GetWaypointByTag(GetResRef(OBJECT_SELF));  //J. Persinne; needed in order to know whether we've gone far enough from our
     SetLocalObject(OBJECT_SELF, "MY_SPAWN_POINT", oSpawnWaypoint);     //spawn point to require a force return.
}


