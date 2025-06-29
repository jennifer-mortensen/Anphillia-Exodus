
void main()
{
    object oItem;
    object oPC = GetPCSpeaker();
    string sTag;

    oItem = GetFirstItemInInventory (oPC);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag (oItem);
        if (sTag == "Foodmagic")
        {
            DestroyObject (oItem);
            GiveGoldToCreature (oPC, 250);
            GiveXPToCreature (oPC, 250);
        }
        oItem = GetNextItemInInventory (oPC);
    }
}

