#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void  AddBonusToShield(object oMyArmor, float fDuration, int nAmount)
{
    IPSafeAddItemProperty(oMyArmor,ItemPropertyACBonus(nAmount), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
    IPSafeAddItemProperty(oMyArmor,ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGERESIST_5), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
    return;
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_GLOBE_USE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration  = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nAmount = MothGetCasterLevel(OBJECT_SELF)/5;
    int nValid = FALSE;
    if (nAmount <1)
    {
        nAmount =1;
    }
    if (nAmount>=5)
    {
        nAmount =5;
    }
    object oShield  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) ==BASE_ITEM_LARGESHIELD ||
            GetBaseItemType(oShield) ==BASE_ITEM_SMALLSHIELD ||
            GetBaseItemType(oShield) ==BASE_ITEM_TOWERSHIELD)
        {
            nValid = TRUE;
        }
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }
    if(oTarget==OBJECT_SELF || oTarget==oShield && nValid == TRUE)
    {
        SignalEvent(OBJECT_SELF,EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, TurnsToSeconds(nDuration));
            AddBonusToShield(oShield, TurnsToSeconds(nDuration),nAmount);
        }
        return;
    }
    else
    {
           SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target.</c>");
           return;
    }
}
