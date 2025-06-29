#include "x2_inc_spellhook"
#include "X0_I0_SPELLS"
void main()
{
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect eHowl1 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY_FEMALE);
    effect eHowl2 = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    effect eHowl = EffectLinkEffects(eHowl1,eHowl2);
    effect eImpactHead = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactHead, OBJECT_SELF);
    DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eHowl, GetLocation(OBJECT_SELF)));
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, OBJECT_SELF,BODY_NODE_CHEST);
    float fDelay;
    int nHD = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDC = 18 + nHD;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_LIGHTNING));
                nDamage = d6(GetHitDice(OBJECT_SELF));
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_ELECTRICITY);
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                eHowl = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget, 0.5));
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }
}

