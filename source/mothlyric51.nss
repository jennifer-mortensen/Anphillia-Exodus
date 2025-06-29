#include "NW_I0_SPELLS"
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
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
    effect eKill;
    effect eHeal;
    effect eVisa = EffectVisualEffect(VFX_IMP_DOOM);
    effect eVisb = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eVis = EffectLinkEffects(eVisa,eVisb);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
    effect eImpact1 = EffectVisualEffect(VFX_FNF_DISPEL);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eImpact = EffectLinkEffects(eImpact2,eImpact1);
    float fDelay;
    int nHP = d12() + nCasterLvl*3/2;
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
    PlaySound("as_pl_x2screamf1");
    PlaySound("as_pl_x2screamf2");
    PlaySound("as_pl_x2screamf3");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                    //Make Fort save
                    if (MySavingThrow(SAVING_THROW_FORT, oTarget, nCasterLvl, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                    {
                        nHP /= 2;
                    }
                    //Calculate damage
                    //Set damage effect
                    eKill = EffectDamage(nHP, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        else
        {
            // * May 2003: Heal Neutrals as well
            if(!GetIsReactionTypeHostile(oTarget) || GetFactionEqual(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                eHeal = EffectHeal(nHP);
                //Apply heal effect and VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}
