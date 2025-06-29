#include "x2_inc_toollib"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eVis    = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eCurse1 = EffectAbilityDecrease(ABILITY_STRENGTH,3);
    effect eCurse2 = EffectAbilityDecrease(ABILITY_DEXTERITY,3);
    effect eCurse3 = EffectAbilityDecrease(ABILITY_CONSTITUTION,3);
    effect eLink   = EffectLinkEffects(eCurse1,eCurse2);
    eLink          = EffectLinkEffects(eLink,eCurse3);
    int nDuration = GetLevelByClass(CLASS_TYPE_BLACKGUARD,OBJECT_SELF);
    int nDC = 22 + nDuration;
    location lSpell = GetSpellTargetLocation();
    float fDelay = GetDistanceBetweenLocations(lSpell, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_LOS_NORMAL_10,lSpell, 2, fDelay, 1.0f, 1.0f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact,lSpell);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lSpell);
    while(GetIsObjectValid(oTarget))
    {
        if (!MothGetIsFortAlly(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oTarget,GetSpellId()));
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC,SAVING_THROW_TYPE_NONE))
            {
             if(!GetIsImmune(oTarget,IMMUNITY_TYPE_CURSED))
                {
                RemoveEffectsFromSpell(oTarget, GetSpellId());
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lSpell);
    }
}
