// Corpse include file
// HCR Archaegeo 2002

void hcTransferObjects(object oFrom, object oTo, int nDesPCT=0)
{
    object oInBagItem;
//    SendMessageToPC(oFrom,"Beginning Transfer");
    object oEquip = GetFirstItemInInventory(oFrom);
    while(GetIsObjectValid(oEquip))
    {
// Item to be NOT transfered
        // SendMessageToPC(oFrom,"Checking Item " + GetTag(oEquip));
        if ( (GetTag(oEquip)=="hc_palbadgecour")
            || (GetTag(oEquip)=="hc_paladinsymb")
            || (GetTag(oEquip)=="searchtool")
            || (GetTag(oEquip)=="TrackerTool")
            || (GetTag(oEquip)=="EmoteWand")
            || (FindSubString(GetTag(oEquip), "sei_sla") != -1)
            || (GetTag(oEquip)=="fuguerobe1"))
        {
            oEquip = GetNextItemInInventory(oFrom);
            continue;
        }

        oInBagItem = GetFirstItemInInventory (oEquip);
        if (GetIsObjectValid(oInBagItem))
        {
            // Ah, recursion :)
            hcTransferObjects(oEquip, oTo, 2);
        }


        /* Mods.. */
        if ( (GetTag(oEquip) != "PotionOfCCW")
           &&(GetTag(oEquip) != "PotionOfCLW")
           &&(GetTag(oEquip) != "PotionOfCMW")
           &&(GetTag(oEquip) != "PotionOfCSW"))
        {
            oEquip = GetNextItemInInventory(oFrom);
            continue;
        }

        if(nDesPCT==2 && (GetTag(oEquip)=="PlayerCorpse" &&
            GetLocalString(oEquip,"Key")==GetPCPublicCDKey(oTo)))
        {
            oEquip=GetNextItemInInventory(oFrom);
            continue;
        }
        if(nDesPCT && GetTag(oEquip)=="PlayerCorpse" &&
            GetLocalString(oEquip,"Key")==GetPCPublicCDKey(oTo))
        {
            DestroyObject(oEquip);
            oEquip=GetNextItemInInventory(oFrom);
            continue;
        }
//        SendMessageToPC(oFrom,"Moving Item " + GetTag(oEquip));
        AssignCommand(oTo, ActionTakeItem(oEquip, oFrom));
        oEquip = GetNextItemInInventory(oFrom);
    }
}
//void main() {}
