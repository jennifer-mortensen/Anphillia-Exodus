#include "x2_inc_spellhook"
#include "x0_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eRegen = EffectRegenerate(2, 9.0);
    float  fDelay = GetRandomDelay(0.4, 1.1);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eDur1 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eDur2 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    int nHeal;
    effect eHeal;
    int nMeta = GetMetaMagicFeat();
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    if (nMeta == METAMAGIC_EXTEND)
    {
        nLevel *= 2;
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDur, OBJECT_SELF));
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget))
        {
            if(oTarget != OBJECT_SELF)
            {
            nHeal = d4(nLevel);
            RemoveEffectsFromSpell(oTarget, GetSpellId());
            eHeal = EffectHeal(nHeal);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oTarget,HoursToSeconds(nLevel)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
