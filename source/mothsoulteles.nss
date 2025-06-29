void main()
{
object oPC = GetLastUsedBy();
object oTarget1;
location lTarget1;
object oTarget2;
location lTarget2;
object oTarget3;
location lTarget3;
object oTarget4;
location lTarget4;


oTarget1 = GetWaypointByTag("mothentersoulred");
lTarget1 = GetLocation(oTarget1);
oTarget2 = GetWaypointByTag("mothentersoulblue");
lTarget2 = GetLocation(oTarget2);
oTarget3 = GetWaypointByTag("mothentersoulblack");
lTarget3 = GetLocation(oTarget3);
oTarget4 = GetWaypointByTag("mothentersoulgreen");
lTarget4 = GetLocation(oTarget4);


if ((GetTag(OBJECT_SELF) == "mothsoulportalred"))
   {
   AssignCommand(oPC,JumpToLocation(lTarget1));
   }
   else
   {
   }
if ((GetTag(OBJECT_SELF) == "mothsoulportalblue"))
   {
   AssignCommand(oPC,JumpToLocation(lTarget2));
   }
   else
   {
   }
if ((GetTag(OBJECT_SELF) == "mothsoulportalblack"))
   {
   AssignCommand(oPC,JumpToLocation(lTarget3));
   }
   else
   {
   }
if ((GetTag(OBJECT_SELF) == "mothsoulportalgreen"))
   {
   AssignCommand(oPC,JumpToLocation(lTarget4));
   }
   else
   {
   }
}
