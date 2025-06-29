#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
            return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(495);
    effect eAC1, eAC2, eAC3, eAC4;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }
    eAC1 = EffectACIncrease(5, AC_ARMOUR_ENCHANTMENT_BONUS);
    eAC2 = EffectACIncrease(5, AC_DEFLECTION_BONUS);
    eAC3 = EffectACIncrease(5, AC_DODGE_BONUS);
    eAC4 = EffectACIncrease(5, AC_NATURAL_BONUS);
    effect eDur = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eLink = EffectLinkEffects(eAC1, eAC2);
    eLink = EffectLinkEffects(eLink, eAC3);
    eLink = EffectLinkEffects(eLink, eAC4);
    eLink = EffectLinkEffects(eLink, eDur);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    eLink = ExtraordinaryEffect(eLink);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,1.0);
}
