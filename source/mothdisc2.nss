void main()
{
object oPC = GetEnteringObject();
object oMod = GetModule();
object oTarget;
object oTarget2;
location lTarget;
location lTarget2;
oTarget = GetWaypointByTag("mothwaypointdisc22");
oTarget2 = GetWaypointByTag("mothwaypointdisc21");
lTarget = GetLocation(oTarget);
lTarget2 = GetLocation(oTarget2);
//int nInt;
//nInt=GetLocalInt(oMod, "mothdisc1");
if (GetLocalInt(oMod, "mothdisc1") == 1)
   {
   AssignCommand(oPC, ClearAllActions());
   AssignCommand(oPC, ActionJumpToLocation(lTarget));
   }
if (GetLocalInt(oMod, "mothdisc1") == 0)
   {
   AssignCommand(oPC, ClearAllActions());
   AssignCommand(oPC, ActionJumpToLocation(lTarget2));
   }
else
   {
   }
}
