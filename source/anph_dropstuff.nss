void AnphTransferThings (object oPlayer, object oDest)
{
    string sItemTag;
    object oItem;
    string sResRef;
    object newItem;
    int ANPH_DROP_STOLEN = GetLocalInt(GetModule(), "ANPH_DROP_STOLEN_ITEMS_ON_DEATH");

    oItem = GetFirstItemInInventory (oPlayer);
    while(GetIsObjectValid (oItem))
    {
        sResRef = "";
        sItemTag = GetTag (oItem);

        /* holy fucking stupid, apparently potions
           don't have resrefs? */

        if (sItemTag == "PotionOfCCW")
            sResRef = "potionofcurel004";
        else if (sItemTag == "PotionOfCLW")
            sResRef = "potionofcurel003";
        else if (sItemTag == "PotionOfCMW")
            sResRef = "potionofcurel001";
        else if (sItemTag == "PotionOfCSW")
            sResRef = "potionofcurel002";

        if (sResRef != "" && GetIsObjectValid (oDest))
        {
            DestroyObject (oItem);
            CreateItemOnObject (sResRef, oDest);
        }
        else if (GetStolenFlag(oItem) == TRUE && GetIsObjectValid (oDest) && ANPH_DROP_STOLEN == TRUE)
        {
            newItem = CreateItemOnObject(GetResRef(oItem), oDest);
            if (GetIsObjectValid (newItem))
            {
                SetItemCharges(newItem, GetItemCharges(oItem));
                DestroyObject(oItem);
            }
        }

        oItem = GetNextItemInInventory (oPlayer);
    }
}

void AnphDropStuff (object oPlayer)
{
    location lDiedHere = GetLocation(oPlayer);
    object oBackpack;
    string sID=GetName(oPlayer)+GetPCPublicCDKey(oPlayer);
    object oMod = GetModule();

    oBackpack=GetLocalObject(oMod,"PlayerBackpack"+sID);
    if(GetIsObjectValid(oBackpack)==FALSE)
    {
        oBackpack = CreateObject (OBJECT_TYPE_PLACEABLE, "playerbackpack", lDiedHere);

        if (!GetIsObjectValid (oBackpack))
        {
            SendMessageToPC (oPlayer, "invalid backpack");
        }
        SetLocalObject(oMod,"PlayerBackpack"+sID, oBackpack);

    }
    int nAmtGold=GetGold(oPlayer);
    int nAmtGold2=GetGold(oPlayer);
    if (nAmtGold != nAmtGold2)
    {
        WriteTimestampedLogEntry ("ERROR: Golds do not match!");
        return;
    }
    WriteTimestampedLogEntry ("Dropping gold from player - " +
                              IntToString (nAmtGold));

    if (nAmtGold2 < nAmtGold)
    {
        nAmtGold = nAmtGold2;
    }

    /* Take all their gold */
    AssignCommand (oPlayer, TakeGoldFromCreature(nAmtGold, oPlayer, TRUE));

    if (nAmtGold > 3000000)
    {
        nAmtGold = 3000000;
    }

    if (nAmtGold > 0)
    {
        CreateItemOnObject("NW_IT_GOLD001", oBackpack, nAmtGold);
    }

    /* Now, go through and find the gold! */
    object oItem = GetFirstItemInInventory (oBackpack);
    if (!GetIsObjectValid (oItem))
    {
        DestroyObject (oBackpack);
    }

    int nGold;
    while (GetIsObjectValid (oItem))
    {
        if (GetTag (oItem) == "NW_IT_GOLD001")
        {
            nGold = GetNumStackedItems (oItem);
            if (nGold > 3000000)
            {
                WriteTimestampedLogEntry ("** ERROR: Amount of gold in dropped bag is - " +
                                          IntToString (nGold));
            }
            if (nGold != nAmtGold)
            {
                WriteTimestampedLogEntry ("** ERROR: Amount of gold dropped does not equal amnt - " +
                                          IntToString (nGold));
            }
        }
        oItem = GetNextItemInInventory (oBackpack);
    }

    AnphTransferThings (oPlayer, oBackpack);
}
