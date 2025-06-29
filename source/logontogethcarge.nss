void main()
{
object oPC = GetEnteringObject();
object oTarget77;
object oItem77;
oTarget77 = oPC;
oItem77 = GetItemPossessedBy(oTarget77, "mothorb1");
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
SetItemCharges(oItem77, 1);
}
