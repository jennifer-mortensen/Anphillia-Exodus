void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
object oTarget;
location lTarget;
oTarget = GetNearestObject(OBJECT_TYPE_WAYPOINT,oPC,2);
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
}

