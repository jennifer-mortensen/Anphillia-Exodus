void main()
{
    GiveGoldToCreature(GetPCSpeaker(), 1500);
    GiveXPToCreature(GetPCSpeaker(), 750);
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "mothgoldammy");
    if(GetIsObjectValid(oItemToTake) != 0)
        ActionTakeItem(oItemToTake, GetPCSpeaker());
}
