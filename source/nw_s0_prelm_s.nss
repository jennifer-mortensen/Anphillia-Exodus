#include "x2_inc_spellhook"
#include "x0_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eLinka = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eLinkb = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eLinkc = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eLink = EffectLinkEffects(eLinka, eLinkb);
    eLink = EffectLinkEffects(eLink, eLinkc);
    eLink = ExtraordinaryEffect(eLink);
    int nDuration = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF) + GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF) ;
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = IntToFloat(nDuration)*30.0;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        fDuration = fDuration *2;
    }
    object oPC = OBJECT_SELF;
    object oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oPC);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eDur = ExtraordinaryEffect(eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC,fDuration);
    if(GetBaseItemType(oItem) == BASE_ITEM_INVALID)
    {
    SendMessageToPC(oPC,"<cеее>[Server] No Armor Found!</c>");
    return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_ONHITCASTSPELL,DURATION_TYPE_TEMPORARY,-1);
    IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ELECTRIC_JOLT,nDuration), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE);
}
