void main()
{
object oPC = GetLastUsedBy();
object oGate = GetObjectByTag("mothgate1");
object oGate2 = GetObjectByTag("mothgate2");
if ((GetTag(OBJECT_SELF) == "mothgate1"))
   {
   AssignCommand(oPC, ClearAllActions());
   AssignCommand(oPC, ActionJumpToObject(oGate2));
   }
else if((GetTag(OBJECT_SELF) == "mothgate2"))
   {
   AssignCommand(oPC, ClearAllActions());
   AssignCommand(oPC, ActionJumpToObject(oGate));
   }
  }
