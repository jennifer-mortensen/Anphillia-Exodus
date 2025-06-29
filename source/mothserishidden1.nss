void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
object oTarget = GetWaypointByTag("serisscatteredwaypoint1");
location lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
DelayCommand(0.7,FloatingTextStringOnCreature("<cðøþ>*You found a hidden passage!*</c>",oPC));
}
