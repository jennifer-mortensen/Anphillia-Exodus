#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eHowl;
    float fDelay;
    int nHD = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC = 16 + nHD;
    effect eImpact1 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eImpact2 = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    effect eImpactHead = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactHead, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_HOLY));
                nDamage = d6(GetHitDice(OBJECT_SELF));
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_ACID);
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                eHowl = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }
}


