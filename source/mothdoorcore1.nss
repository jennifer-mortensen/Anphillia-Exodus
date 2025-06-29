void main()
{
object oPC = GetClickingObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
string sString = GetTag(OBJECT_SELF);
ActionStartConversation(oPC,sString);
}
