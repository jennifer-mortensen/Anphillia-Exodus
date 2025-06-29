#include "x2_inc_spellhook"
void main()
{
   if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nBonusProcent = nDuration;
    object oTarget = GetSpellTargetObject();
    effect eBonus1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,nBonusProcent);
    effect eBonus2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,nBonusProcent);
    effect eBonus = EffectLinkEffects(eBonus1,eBonus2);
    effect eVisa = EffectVisualEffect(VFX_IMP_GOOD_HELP);
    effect eVisb = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    effect eVis = EffectLinkEffects(eVisa,eVisb);
    effect eDur1 = EffectVisualEffect(VFX_DUR_DEATH_ARMOR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_FLIES);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    effect eLink = EffectLinkEffects(eBonus, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*2+5));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}

