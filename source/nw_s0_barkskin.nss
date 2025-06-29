#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nBonus;
    int nMetaMagic = GetMetaMagicFeat();
    float fDuration = HoursToSeconds(nCasterLevel);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_BARKSKIN);
    effect eHead = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eAC;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BARKSKIN, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        fDuration = HoursToSeconds(nCasterLevel * 2);
    }
    if (nCasterLevel <= 6)
    {
        nBonus = 1;
    }
    else
    {
        if (nCasterLevel <= 16)
        {
            nBonus = 3;
        }
        else
        {
            nBonus = 5;
        }
     }
    eAC = EffectACIncrease(nBonus, AC_NATURAL_BONUS);
    effect eLink = EffectLinkEffects(eVis, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHead, oTarget);
}
