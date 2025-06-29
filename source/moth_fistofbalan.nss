#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void  AddBonusToGloves(object oMyArmor, float fDuration, int nAmount)
{
    IPSafeAddItemProperty(oMyArmor,ItemPropertySkillBonus(SKILL_DISCIPLINE,2+nAmount), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING ,FALSE,TRUE);
    return;
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration  = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nValid = FALSE;
    int nAmount = MothGetCasterLevel(OBJECT_SELF)/5;
    if (nAmount <1)
    {
        nAmount =1;
    }
    object oShield  = GetItemInSlot(INVENTORY_SLOT_ARMS,OBJECT_SELF);
    if (GetIsObjectValid(oShield))
    {
        if (GetBaseItemType(oShield) ==BASE_ITEM_GLOVES)
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
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, OBJECT_SELF, HoursToSeconds(nDuration));
            AddBonusToGloves(oShield, HoursToSeconds(nDuration), nAmount);
        }
        return;
    }
    else
    {
           SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target.</c>");
           return;
    }
}
