void main()
{
    object oPC = GetItemActivator();
    object oBag = GetItemActivatedTarget();
    if(GetBaseItemType(oBag)!=BASE_ITEM_INVALID
    && GetItemPossessor(oBag) == oPC)
    {
        if(GetPlotFlag(oBag)==TRUE)
        {
         if(GetTag(oBag)=="axfellgatekey"
         ||GetTag(oBag)=="axfellwarriorrin"
         ||GetTag(oBag)=="MothBattleHorn"
         ||GetTag(oBag)=="drowgatekey"
         ||GetTag(oBag)=="drowring"
         ||GetTag(oBag)=="cleavengatekey"
         ||GetTag(oBag)=="cleavenmilitiari"
         ||GetTag(oBag)=="ranzingtongateke"
         ||GetTag(oBag)=="ranzingtoncitize"

         )
         {
          SendMessageToPC(oPC, "<cþÞ >*You cannot destroy Faction Item!*</c>");
          return;
         }
         if(GetTag(oBag)=="ATS_SKILLBOX_NOD"
         ||GetTag(oBag)=="ATS_JOURNAL_NOD")
         {
          SendMessageToPC(oPC, "<cþÞ >*You cannot destroy ATS Plot Item!*</c>");
          return;
         }
         if(GetIsObjectValid(oBag))
           {
            DestroyObject(oBag);
            string sBag = GetName(oBag);
            string sPlayer = GetName(oPC);
            string sPlayerCD = GetPCPublicCDKey(oPC);
            WriteTimestampedLogEntry("Player "+sPlayer+" with CD Key "+sPlayerCD+" has destroyed an item with the name "+sBag+".");
            SendMessageToPC(oPC, "<cþÞ >"+sBag+" has been destroyed. This action has been logged!*</c>");
            return;
           }
        }
        else
        {
        SendMessageToPC(oPC, "<cþÞ >*Target must be a Plot Item!*</c>");
        return;
        }
    }
    else
    {
        SendMessageToPC(oPC, "<cþÞ >*Target must be a in your Inventory!*</c>");
        return;
    }
}
