void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
object oTarget;
object oTarget2;
object oTarget3;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("mothbossspawnpeak1");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothpeakboss1", lTarget);
oTarget2 = GetObjectByTag("mothwallpeak1");
oTarget3 = GetObjectByTag("mothwallpeak2");
DestroyObject(oTarget2, 0.0);
DestroyObject(oTarget3, 0.0);
}

