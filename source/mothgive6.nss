void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
if (GetItemPossessedBy(oPC, "crystalofcosmicf")!= OBJECT_INVALID) return;
SendMessageToPC(oPC, "<cýõæ>You break of a chunk from this crystal, it seems to hold some arcane powers.</c>");
CreateItemOnObject("crystalofcosmicf", oPC);
DestroyObject(OBJECT_SELF);
}
