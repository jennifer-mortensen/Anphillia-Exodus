#include "moth_inc_craftin"
void main()
{
     object oUser = GetModuleItemAcquiredBy();
     if(!GetIsPC(oUser)){return;}
     object oItem = GetModuleItemAcquired();
     string sTag=GetTag(oItem);
     if(sTag=="mothemosorb")
     {
      CreateItemOnObject("mothorbofascend",oUser);
      DestroyObject(oItem);
     }
     if(sTag=="PlayerCorpse")
     {
      object oPoss=GetItemPossessor(oItem);
      string sName=GetName(oPoss);
      object oOwner=GetLocalObject(oItem,"Owner");
      SendMessageToPC(oOwner,"<cþ¥ >"+sName+" has just picked up your corpse!</c>");
     }
     else if(GetLocalInt(oItem,"MothBloodlineFury")==TRUE)
     {
      MothCheckBloodlineFury(oItem);
     }
}
