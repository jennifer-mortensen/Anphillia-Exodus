void main()
{
object oTarget;
object oSpawn;
object oHolo = GetObjectByTag("mothprojection");
location lTarget;
oTarget = GetWaypointByTag("mothholo");
lTarget = GetLocation(oTarget);
oTarget = oSpawn;
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "mothprojection", lTarget);
}
