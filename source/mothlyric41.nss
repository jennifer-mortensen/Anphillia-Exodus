#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc"
void main()
{
    if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85587,OBJECT_SELF); // no more bardsong uses left
        return;
    }
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF); // not useable when silenced
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
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eAttack = EffectAttackIncrease(1);
    effect eSave = EffectSkillIncrease(SKILL_ALL_SKILLS, 1);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    int nDuration = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
    float fDelay;
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
    PlaySound("sim_mentcharm");
    PlaySound("sim_mentcharm");
    PlaySound("sim_mentcharm");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
     if(oTarget == OBJECT_SELF)
       {
         oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
       }

        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) ||
           GetIsReactionTypeNeutral(oTarget))
        {
            ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
            fDelay = GetRandomDelay(0.4, 1.1);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

