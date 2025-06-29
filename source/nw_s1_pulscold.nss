#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int nDamage;
    int nRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,OBJECT_SELF);
    int nDruid = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eHowl;
    float fDelay;
    int nAbility = ABILITY_CONSTITUTION;
    int nDCBase = 16;
    if(nRDD>1)
    {
     nAbility = ABILITY_CHARISMA;
     nDCBase = 20;
    }
    if(nDruid>1)
    {
     nAbility = ABILITY_WISDOM;
     nDCBase = 18;
    }
    int nHD = GetAbilityModifier(nAbility,OBJECT_SELF);
    int nDC = nDCBase + nHD;
    effect eImpact1 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eImpact2 = EffectVisualEffect(VFX_IMP_PULSE_COLD);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    effect eImpactHead = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactHead, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
    if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_PULSE_COLD));
                nDamage = d6(GetHitDice(OBJECT_SELF));
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_COLD);
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                eHowl = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }
}


