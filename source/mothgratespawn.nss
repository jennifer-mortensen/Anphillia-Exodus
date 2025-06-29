void main()
{
object oPC = GetPCSpeaker();
object oTarget;
object oSpawn;
location lTarget;
object oTake1 = GetItemPossessedBy(oPC,"BugbearCrowbar");
oTarget = GetWaypointByTag("mothgrateportal");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "mothgrateportal1", lTarget);
oTarget = oSpawn;
int nInt;
nInt = GetObjectType(oTarget);
if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(481), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(481), GetLocation(oTarget)));
if(GetIsObjectValid(oTake1)){DestroyObject(oTake1);}
DestroyObject(OBJECT_SELF,1.0);
}
