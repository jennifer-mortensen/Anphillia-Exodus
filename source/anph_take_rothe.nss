
void main()
{
    object oItem;
    object oPC = GetPCSpeaker();
    string sTag;
    int iReward = 25 + (GetAbilityModifier(ABILITY_CHARISMA, oPC) * 3);

    oItem = GetFirstItemInInventory (oPC);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag (oItem);
        if (sTag == "RotheMeat")
        {
            DestroyObject (oItem);
            GiveGoldToCreature (oPC, iReward);
            GiveXPToCreature (oPC, 5);
        }
        oItem = GetNextItemInInventory (oPC);
    }
}
