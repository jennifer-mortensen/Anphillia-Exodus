#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nVis = VFX_DUR_GHOSTLY_VISAGE;
    int nDam1 = 5;
    int nDam2 = DAMAGE_POWER_PLUS_ONE;
    int nSpellAbs = 1;
    int nConceal = 20;
    int nSignal = SPELL_GHOSTLY_VISAGE;
    int nDuration = MothGetCasterLevel(OBJECT_SELF)+4;
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(nVis);
    effect eDam = EffectDamageReduction(nDam1, nDam2);
    effect eSpell = EffectSpellLevelAbsorption(nSpellAbs);
    effect eConceal = EffectConcealment(nConceal);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eDam, eVis);
    eLink = EffectLinkEffects(eLink, eSpell);
    eLink = EffectLinkEffects(eLink, eConceal);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSignal, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

