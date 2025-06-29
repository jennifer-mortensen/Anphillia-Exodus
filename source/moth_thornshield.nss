#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nDuration2 = nDuration/2;
    int nMetaMagic = GetMetaMagicFeat();
    int nAC = 1;
    effect eVis = EffectVisualEffect(VFX_IMP_AC_BONUS);
    effect eVis2 = EffectVisualEffect(VFX_DUR_ENTANGLE);
    effect eAC1, eAC2, eAC3, eAC4;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }
    if(GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF)==40)
    {
      nAC = 2;
      nDuration2 = nDuration2*2;
    }
    eAC1 = EffectACIncrease(nAC, AC_ARMOUR_ENCHANTMENT_BONUS);
    eAC2 = EffectACIncrease(nAC, AC_DEFLECTION_BONUS);
    eAC3 = EffectACIncrease(nAC, AC_DODGE_BONUS);
    eAC4 = EffectACIncrease(nAC, AC_NATURAL_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAC1, eAC2);
    eLink = EffectLinkEffects(eLink, eAC3);
    eLink = EffectLinkEffects(eLink, eAC4);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget,2.0);
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
    if(GetBaseItemType(oItem) == BASE_ITEM_INVALID)
    {
    SendMessageToPC(OBJECT_SELF,"<cеее>[Server] No Armor Found!</c>");
    return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_ONHITCASTSPELL,DURATION_TYPE_TEMPORARY,-1);
    IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ACID_SPLASH,nDuration2), TurnsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE);

}
