#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    if(MothGetIsAssociate(oTarget))
    {
     if(GetIsPC(oTarget))//just to be sure!
     {
       SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an associate!</c>");
       return;
     }
     object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oTarget);
     if(!GetIsObjectValid(oItem))
     {
        object oHide = CreateItemOnObject("mothassociatehid",oTarget);
        DelayCommand(0.5,AssignCommand(oTarget,ActionEquipItem(oHide,INVENTORY_SLOT_CARMOUR)));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, TurnsToSeconds(nLevel)));
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        return;
     }
     else
     {
      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
      DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, TurnsToSeconds(nLevel)));
      AddItemProperty(DURATION_TYPE_TEMPORARY,ItemPropertyBonusFeat(64/*Blindfight*/),oItem,TurnsToSeconds(nLevel));
     }
    }
    else
    {
       SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an associate!</c>");
       return;
    }
}

