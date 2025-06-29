void main()
{
object oPC = GetLastKiller();
if (!GetIsPC(oPC)) return;
object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("mothtarget00");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "mothmirror2", lTarget);
}

