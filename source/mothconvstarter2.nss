void main()
{
object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;
object oTarget;
oTarget = OBJECT_SELF;
AssignCommand(oTarget, ActionStartConversation(oPC, ""));
}

