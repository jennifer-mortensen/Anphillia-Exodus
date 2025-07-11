#include "x2_inc_spellhook"
#include "x0_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eRegen = EffectRegenerate(1, 9.0);
    float  fDelay = GetRandomDelay(0.4, 1.1);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
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
            if(MothAllowSelfMonsterousRegen(oTarget,OBJECT_SELF))
            {
            RemoveEffectsFromSpell(oTarget, GetSpellId());
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, oTarget,HoursToSeconds(nLevel)));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}
