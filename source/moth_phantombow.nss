#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "moth_inc_craftin"
void  AddBonusToRange(object oMyArmor, float fDuration, int nAmount)
{
    IPSafeAddItemProperty(oMyArmor,ItemPropertyAttackBonus(nAmount), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
    return;
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration  = MothGetCasterLevel(OBJECT_SELF);
    int nAmount = MothGetCasterLevel(OBJECT_SELF)/6;
    int nValid = FALSE;
    if (nAmount <1)
    {
        nAmount =1;
    }
    if (nAmount>=5)
    {
        nAmount =5;
    }
    if(MothGetIsPureClass(CLASS_TYPE_RANGER,OBJECT_SELF))
    {
      nAmount = nAmount+1;
    }
    if(nDuration==40)
    {
      nAmount = nAmount+1;
    }
    object oShield  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) ==BASE_ITEM_LONGBOW ||
            GetBaseItemType(oShield) ==BASE_ITEM_LIGHTCROSSBOW ||
            GetBaseItemType(oShield) ==BASE_ITEM_HEAVYCROSSBOW ||
            GetBaseItemType(oShield) ==BASE_ITEM_SHORTBOW ||
            GetBaseItemType(oShield) ==BASE_ITEM_SLING
        )
        {
            nValid = TRUE;
        }
    }
    if(oTarget==OBJECT_SELF || oTarget==oShield && nValid == TRUE)
    {
        SignalEvent(OBJECT_SELF,EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nDuration>0)
        {
            DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, TurnsToSeconds(nDuration));
            AddBonusToRange(oShield, TurnsToSeconds(nDuration),nAmount);
        }
        return;
    }
    else
    {
           SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target.</c>");
           return;
    }
}
