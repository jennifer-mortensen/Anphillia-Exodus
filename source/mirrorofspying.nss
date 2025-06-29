void main()
{
object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC,"spyonce");
if (DoOnce==TRUE) return;
SetLocalInt(oPC, "spyonce", TRUE);
ActionStartConversation(oPC, "mirrorofspying");
}
