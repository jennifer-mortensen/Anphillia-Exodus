void main ()
{
    object oAltar = OBJECT_SELF;
    object oPC = GetLastClosedBy ();
    int nNum;

    nNum = GetLocalInt (oAltar, "NeededNumber");
    if (nNum == 0)
    {
        nNum = Random (14 + 1);
        SetLocalInt (oAltar, "NeededNumber", nNum);
    }

    object oItem = GetFirstItemInInventory (oAltar);
    while (GetIsObjectValid (oItem))
    {
        if (GetTag (oItem) == "NW_IT_GOLD001")
        {
            FloatingTextStringOnCreature (IntToString (nNum), oPC);
        }
        DestroyObject (oItem);
        oItem = GetNextItemInInventory (oAltar);
    }
}


