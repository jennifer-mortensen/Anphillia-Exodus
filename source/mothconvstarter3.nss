void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
object oTarget;
oTarget = OBJECT_SELF;
AssignCommand(oTarget, ActionStartConversation(oPC, ""));
}

