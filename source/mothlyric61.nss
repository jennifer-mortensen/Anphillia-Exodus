#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85587,OBJECT_SELF); // no more bardsong uses left
        return;
    }
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
        return;
    }
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_BARD,oCaster);
    float fDelay = 0.5;
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
    PlaySound("as_cv_flute2");
    PlaySound("as_cv_flute2");
    PlaySound("as_cv_flute2");
    effect eExplode1 = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_PWKILL);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    effect eVis1 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SILENCE);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSpellFailure = EffectSpellFailure(25,SPELL_SCHOOL_GENERAL);
    effect eLink = EffectLinkEffects(eDur,eSpellFailure);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    while (GetIsObjectValid(oTarget))
    {
       if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster))
       {
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nCasterLvl, SAVING_THROW_TYPE_NONE, oCaster, fDelay))
            {
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
               DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCasterLvl)));
            }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lTarget);
    }
}

