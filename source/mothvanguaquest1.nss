void main()
{
    object oItemToTake;
    object oPC =GetPCSpeaker();
    oItemToTake = GetItemPossessedBy(oPC, "motharbiter1");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    if (!GetIsPC(oPC)) return;
    int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
    if (DoOnce==TRUE) return;
    SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
    GiveXPToCreature(oPC,1050);
    GiveGoldToCreature(oPC,3500);
}
