//
// NESS V8.0
// Spawn : Corpse Death Script
//
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//

#include "spawn_functions"

int NESS_IsNessSpawn(object oSpawned)
{
   if(GetIsObjectValid(GetLocalObject(oSpawned, "ParentSpawn")))
   {
      return TRUE;
   }
   return FALSE;
}

void CleanCorpse(object oCorpse)
{
    if(!GetIsObjectValid(oCorpse))
        return;

    object oItem = GetFirstItemInInventory(oCorpse);

    while(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oCorpse);
    }

    DelayCommand(1.0f,DestroyObject(oCorpse)); //Delete Lootable Object (Self)
}

void CopyItemVarsAndPlot(object oSource, object oInventory)
{
    int bWasPlot = GetPlotFlag(oSource);
    object oNewItem = CopyItem(oSource, oInventory, TRUE);
    if (bWasPlot == TRUE)
    {
        SetPlotFlag(oNewItem,TRUE);
    }
}
// Strip everything droppable in the regular inventory, too.
void LootInventoryAndPreserveVars(object oVictim, object oCorpse)
{
    object oItem = GetFirstItemInInventory(oVictim);
    while (GetIsObjectValid(oItem)) {
        if (GetDroppableFlag(oItem)) {
            // Copy to the corpse and destroy
            CopyItemVarsAndPlot(oItem, oCorpse);
            DestroyObject(oItem, 0.1);
        }
        oItem = GetNextItemInInventory(oVictim);
    }
}

void main()
{
    object oDeadNPC = OBJECT_SELF;
    object oLootCorpse, oBlood;
    location lCorpseLoc = GetLocation(oDeadNPC);
    float fCorpseDecay = GetLocalFloat(oDeadNPC, "CorpseDecay");
    int nCorpseDecayType = GetLocalInt(oDeadNPC, "CorpseDecayType");
    int bDropWielded = GetLocalInt(oDeadNPC, "CorpseDropWielded");
    string sLootCorpseResRef = GetLocalString(oDeadNPC, "CorpseRemainsResRef");
    struct NESS_CorpseInfo stCorpseInfo;

    int nCorpseGold = FALSE, nCorpseInv = FALSE, nCorpseEquip = FALSE;

    object oKiller = GetLastDamager();
    if (oKiller == OBJECT_INVALID)
    {
        oKiller = GetLastKiller();
    }

    if (fCorpseDecay > 0.0)
    {
        //Protect our corpse from decaying
        SetIsDestroyable(FALSE, FALSE, FALSE);

        // Create Corpse and Lootable Corpse
        if(sLootCorpseResRef == "ats_invis_corpse")
        {
            oLootCorpse = GetLocalObject(oDeadNPC, "ats_oLootCorse"); //J. Persinne; ats creatures will handle the creation of their own corpses.
            if(!GetIsObjectValid(oLootCorpse))
            {
                //SendMessageToPC(GetFirstPC(), "The corpse was not valid.");
                if(GetLocalInt(OBJECT_SELF, "RECURSION_ATTEMPTED") == TRUE)
                {
                    //SendMessageToPC(GetFirstPC(), "Recursion attempted failed; destroying self on error...");
                    SetIsDestroyable(TRUE, FALSE, FALSE);
                    DestroyObject(OBJECT_SELF, 1.0);
                }
                else
                {
                    //SendMessageToPC(GetFirstPC(), "Attempting a recursion...");
                    SetLocalInt(OBJECT_SELF, "RECURSION_ATTEMPTED", TRUE);
                    DelayCommand(0.1, ExecuteScript("spawn_corpse_dth", OBJECT_SELF));
                    return;
                }
            }
            //else
            //    SendMessageToPC(GetFirstPC(), "Corpse found.");
        }
        else
            oLootCorpse = CreateObject(OBJECT_TYPE_PLACEABLE, sLootCorpseResRef, lCorpseLoc);

        SetLocalObject(oLootCorpse, "HostBody", oDeadNPC);
        SetLocalObject(oDeadNPC, "Corpse", oLootCorpse);

        switch (nCorpseDecayType)
        {
            // Type 0:
            // Inventory Items
            case 0:
                nCorpseGold = TRUE;
                nCorpseInv = TRUE;
                nCorpseEquip = FALSE;
            break;

            // Type 1:
            // Inventory & Equipped Items
            case 1:
                nCorpseGold = TRUE;
                nCorpseInv = TRUE;
                nCorpseEquip = TRUE;
            break;

            // Type 2:
            // Inventory Items, if PC Killed
            case 2:
                if (GetIsPC(oKiller) == TRUE || GetIsPC(GetMaster(oKiller)) == TRUE)
                {
                    nCorpseGold = TRUE;
                    nCorpseInv = TRUE;
                    nCorpseEquip = FALSE;
                }
            break;

            // Type 3:
            // Inventory & Equipped Items, if PC Killed
            case 3:
                if (GetIsPC(oKiller) == TRUE || GetIsPC(GetMaster(oKiller)) == TRUE)
                {
                    nCorpseGold = TRUE;
                    nCorpseInv = TRUE;
                    nCorpseEquip = TRUE;
                }
            break;
        }

        // Get Gold
        if (nCorpseGold == TRUE)
        {
            int nAmtGold = GetGold(oDeadNPC);
            if(nAmtGold)
            {
                object oGold = CreateItemOnObject("nw_it_gold001", oLootCorpse, nAmtGold);
                AssignCommand(oLootCorpse, TakeGoldFromCreature(nAmtGold, oDeadNPC,TRUE));
            }
        }

        // Get Inventory & Equipment
        if (nCorpseEquip == TRUE)
        {
            stCorpseInfo = TransferAllInventorySlots(oDeadNPC, oLootCorpse, bDropWielded);
        }

        if (nCorpseInv == TRUE)
        {
            LootInventoryAndPreserveVars(oDeadNPC, oLootCorpse);
        }

        // Write a record of stuff left on the original corpse and its loot
        // corpse counterpart.  These are used to remove items from the visual corpse
        // when the corresponding items are looted
        SetLocalObject(oLootCorpse, "OrigArmor", stCorpseInfo.origArmor);
        SetLocalObject(oLootCorpse, "LootArmor", stCorpseInfo.lootArmor);
        SetLocalObject(oLootCorpse, "OrigRgtWpn", stCorpseInfo.origRgtWpn);
        SetLocalObject(oLootCorpse, "LootRgtWpn", stCorpseInfo.lootRgtWpn);
        SetLocalObject(oLootCorpse, "OrigLftWpn", stCorpseInfo.origLftWpn);
        SetLocalObject(oLootCorpse, "LootLftWpn", stCorpseInfo.lootLftWpn);

        // Set Corpse to Decay
        DelayCommand(fCorpseDecay - 0.1, SetLocalInt(oDeadNPC, "DecayTimerExpired", TRUE));
        DelayCommand(fCorpseDecay, ExecuteScript("spawn_corpse_dcy", oDeadNPC));

    }
}
