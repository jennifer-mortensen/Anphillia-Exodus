void main()
{
object oTarget = GetWaypointByTag("MothAnnouncer1");
location lTarget = GetLocation(oTarget);
object oTarget2 = GetWaypointByTag("MothAnnouncer2");
location lTarget2 = GetLocation(oTarget2);
CreateObject(OBJECT_TYPE_CREATURE, "announcer", lTarget);
CreateObject(OBJECT_TYPE_CREATURE, "announcer2", lTarget2);
}
