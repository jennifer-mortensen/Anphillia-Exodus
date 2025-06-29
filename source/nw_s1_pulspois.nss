#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int nDamage;
    int nDruid = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eHowl;
    float fDelay;
    int nAbility = ABILITY_CONSTITUTION;
    int nDCBase = 16;
    if(nDruid>1)
    {
     nAbility = ABILITY_WISDOM;
     nDCBase = 18;
    }
    int nHD = GetAbilityModifier(nAbility,OBJECT_SELF);
    int nDC = nDCBase + nHD;
    effect eImpact1 = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
    effect eImpact2 = EffectVisualEffect(VFX_IMP_PULSE_NATURE);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    effect eImpactHead = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect ePoison = EffectPoison(MothGetPoison());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpactHead, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
    if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                nDamage = d4(GetHitDice(OBJECT_SELF));
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
                fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
                eHowl = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                if(nDamage > 0)
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_POISON))
                    {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoison, oTarget));
                    }
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHowl, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(OBJECT_SELF));
    }
}


