#include "x2_inc_spellhook"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eNeg = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 33);
    effect eLevel = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eAbil = EffectImmunity(IMMUNITY_TYPE_CURSED);
    int nDuration = GetLevelByClass(CLASS_TYPE_BLACKGUARD,OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    effect eLink = EffectLinkEffects(eNeg, eLevel);
    eLink = EffectLinkEffects(eLink, eAbil);
    eLink = ExtraordinaryEffect(eLink);
    oTarget = OBJECT_SELF;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    TLVFXPillar(VFX_IMP_CHARM,GetLocation(oTarget), 3, 0.0f, 1.0f);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*4));
}
