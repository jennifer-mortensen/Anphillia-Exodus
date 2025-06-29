#include "hc_inc"
#include "hc_inc_transfer"
#include "hc_inc_on_unacq"
#include "hc_text_unacq"
#include "anph_inc"
#include "moth_inc_craftin"
void main()
{
    if(!preEvent()) return;
    object oDropped = GetModuleItemLost();
    if(GetObjectType(GetItemPossessor(oDropped)) == OBJECT_TYPE_STORE)
        SetLocalInt(oDropped, "DO_NOT_DUPLICATE_ON_PURCHASE", TRUE);
    string sDTag=GetTag(oDropped);
    object oPC=GetModuleItemLostBy();
    string sPCName=GetName(oPC);
    MothRemoveItemTempEffect(oDropped);
    if(GetObjectType(oDropped) == BASE_ITEM_CREATUREITEM)
    {
        DestroyObject(oDropped);
    }
    else if (GetLocalInt(oMod,"LOOTSYSTEM"))
    {
       if (sDTag=="PlayerCorpse")
       {
            object oPoss=GetItemPossessor(oDropped);
            if(oPoss==OBJECT_INVALID && GetTag(GetArea(oDropped))=="")
            {
                postEvent();
                return;
            }
            object oDC=GetLocalObject(oDropped,"DeathCorpse");
            object oOwner=GetLocalObject(oDropped,"Owner");
            string sName=GetLocalString(oDropped,"Name");
            string sCDK=GetLocalString(oDropped,"Key");
            string sFaction = GetLocalString(oDropped,"Faction");
            SendMessageToPC(oOwner,"<cþ¥ >"+sPCName+" has just dropped your corpse!</c>");
            object oDeadMan;
            object oDeathCorpse;
            if(GetIsObjectValid(oDC))
            {
                oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                    GetLocation(oDropped));
            }
            else
            {
                oDeathCorpse=CreateObject(OBJECT_TYPE_PLACEABLE, "DeathCorpse",
                                    GetLocation(oDropped));
            }
            oDeadMan=CreateItemOnObject("PlayerCorpse", oDeathCorpse);
            SetLocalObject(oDeadMan,"Owner",oOwner);
            SetLocalString(oDeadMan,"Name",sName);
            SetLocalString(oDeadMan,"Key", sCDK);
            SetLocalObject(oDeadMan,"DeathCorpse",oDeathCorpse);
            SetLocalString(oDeadMan, "Faction", sFaction);
            SetLocalInt(oDeadMan,"Alignment",GetLocalInt(oDropped,"Alignment"));
            SetLocalString(oDeadMan,"Deity",GetLocalString(oDropped,"Deity"));
            SetLocalObject(oMod,"DeathCorpse"+sName+sCDK,oDeathCorpse);
            SetLocalObject(oMod,"PlayerCorpse"+sName+sCDK,oDeadMan);
            SetLocalObject(oDeathCorpse,"Owner",oOwner);
            SetLocalString(oDeathCorpse,"Name",sName);
            SetLocalString(oDeathCorpse,"Key",sCDK);
            SetLocalObject(oDeathCorpse,"PlayerCorpse",oDeadMan);
            SetLocalString(oDeathCorpse, "Faction", sFaction);
            DestroyObject(oDropped);
            hcTransferObjects(oDC, oDeathCorpse);
            DestroyObject(oDC);
       }
    }
  postEvent();
}
