#include "x2_inc_spellhook"
#include "x0_i0_spells"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    DelayCommand(0.1,TLVFXPillar(VFX_IMP_PULSE_NEGATIVE,GetLocation(OBJECT_SELF), 1, 0.0f, 5.0f));
    DelayCommand(0.5,TLVFXPillar(VFX_IMP_PULSE_NEGATIVE,GetLocation(OBJECT_SELF), 1, 0.0f, 4.0f));
    DelayCommand(1.1,TLVFXPillar(VFX_IMP_PULSE_NEGATIVE,GetLocation(OBJECT_SELF), 1, 0.0f, 5.0f));
    DelayCommand(1.4,TLVFXPillar(VFX_IMP_PULSE_NEGATIVE,GetLocation(OBJECT_SELF), 1, 0.0f, 2.0f));
    DelayCommand(1.6,TLVFXPillar(VFX_IMP_PULSE_NEGATIVE,GetLocation(OBJECT_SELF), 1, 0.0f, 1.0f));
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    effect eStone = EffectDamageReduction(5, DAMAGE_POWER_PLUS_TWO);
    effect eAC = EffectACIncrease(3, AC_NATURAL_BONUS);
    effect eShadow = EffectVisualEffect(499);
    effect eSpell = EffectSpellLevelAbsorption(3, 0, SPELL_SCHOOL_ENCHANTMENT);
    effect eImmDeath = EffectImmunity(IMMUNITY_TYPE_POISON);
    effect eImmNeg = EffectDamageResistance(DAMAGE_TYPE_COLD, 10); //EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 15);
    effect eLink = EffectLinkEffects(eStone, eAC);
    eLink = EffectLinkEffects(eLink, eShadow);
    eLink = EffectLinkEffects(eLink, eImmDeath);
    eLink = EffectLinkEffects(eLink, eImmNeg);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    DelayCommand(1.7,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

