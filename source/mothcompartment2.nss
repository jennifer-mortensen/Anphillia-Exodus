void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
object oTarget;
location lTarget;
oTarget = GetWaypointByTag("mothwaypointdisc22");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
}
