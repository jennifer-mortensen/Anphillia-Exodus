#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nConceal = nDuration+10;
    int nWillSave = nDuration/6;
    int nSpellLevel = nDuration/8;
    int nAbsorb = nDuration/5 + 5;
    int nImmunity = nDuration/2 + 5;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration *= 2;
    }
    effect eStone = EffectConcealment(nConceal);
    effect eAC = EffectSavingThrowIncrease(SAVING_THROW_WILL, nWillSave);
    effect eVis1 = EffectVisualEffect(VFX_IMP_AURA_NEGATIVE_ENERGY);
    effect eVis2 = EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE);
    effect eVis3 = EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    effect eShadow1 = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    effect eShadow2 = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_ORANGE);
    effect eShadow3 = EffectVisualEffect(VFX_DUR_AURA_ODD);
    effect eShadow = EffectLinkEffects(eShadow1,eShadow2);
    eShadow = EffectLinkEffects(eShadow,eShadow3);
    effect eSpell = EffectSpellLevelAbsorption(nSpellLevel, nAbsorb, SPELL_SCHOOL_GENERAL);
    effect eImmDeath = EffectImmunity(IMMUNITY_TYPE_BLINDNESS);
    effect eImmNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, nImmunity);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eStone, eAC);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eShadow);
    eLink = EffectLinkEffects(eLink, eImmDeath);
    eLink = EffectLinkEffects(eLink, eImmNeg);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eSpell);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}



