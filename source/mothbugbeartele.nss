void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
string sDoor = GetTag(OBJECT_SELF);
string sJumpTo;
object oTarget = GetWaypointByTag(sJumpTo);
location lTarget;
if(sDoor == "serisbugbearden01")
{
oTarget = GetWaypointByTag("serisbugtrapdoor1");
}
else if(sDoor == "serisbugbearden02")
{
oTarget = GetWaypointByTag("serisbugtrapdoor2");
}
else if(sDoor == "serisbugbearden03")
{
oTarget = GetWaypointByTag("serisbugtrapdoor3");
}
else if(sDoor == "serisbugbearden04")
{
oTarget = GetWaypointByTag("serisbugtrapdoor4");
}
else if(sDoor == "serisbugbearden05")
{
oTarget = GetWaypointByTag("serisbugtrapdoor5");
}
else if(sDoor == "serisbugbearden06")
{
oTarget = GetWaypointByTag("serisbugtrapdoor6");
}
lTarget = GetLocation(oTarget);
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
}
