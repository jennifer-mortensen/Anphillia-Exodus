//Tyragmocoksdfoakf
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (GetIsPC(OBJECT_SELF)==FALSE)
    {
       return;
    }
    object oPlayer = OBJECT_SELF;
    object oTarget;
    effect ePosVisa = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect ePosVisb = EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE);
    effect ePosVisc = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
    effect ePosVisd = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
    effect ePosVis = EffectLinkEffects(ePosVisa,ePosVisb);
    ePosVis = EffectLinkEffects(ePosVis,ePosVisc);
    ePosVis = EffectLinkEffects(ePosVis,ePosVisd);
    effect eImpacta = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eImpactb = EffectVisualEffect(VFX_FNF_DISPEL);
    effect eImpactc = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eImpact = EffectLinkEffects(eImpacta,eImpactb);
    eImpact = EffectLinkEffects(eImpact,eImpactc);
    int nCasterLvl = MothGetCasterLevel(oPlayer)/3;
    int nBonus = 1 + nCasterLvl;
    effect eBonAttack = EffectSkillIncrease(SKILL_LORE,nBonus);
    effect eBonSave = EffectSkillIncrease(SKILL_CONCENTRATION, nBonus);
    effect eBonDam = EffectSkillIncrease(SKILL_SPELLCRAFT,nBonus);
    effect eBonSkill = EffectSkillIncrease(SKILL_PERFORM, nBonus);
    effect eBonSkill2 = EffectSkillIncrease(SKILL_DISABLE_TRAP, nBonus);
    effect eBonSkill3 = EffectSkillIncrease(SKILL_SEARCH, nBonus);
    effect eBonSkill4 = EffectSkillIncrease(SKILL_SPOT, nBonus);
    effect eBonSkill5 = EffectSkillIncrease(SKILL_LISTEN, nBonus);
    effect ePosDur = EffectVisualEffect(VFX_DUR_PROTECTION_GOOD_MAJOR);
    effect ePosLink = EffectLinkEffects(eBonAttack, eBonSave);
    ePosLink = EffectLinkEffects(ePosLink, eBonDam);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill2);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill3);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill4);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill5);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);
    int nDuration = MothGetCasterLevel(oPlayer);
    int nMetaMagic = GetMetaMagicFeat();
    //Metamagic duration check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply Impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Get the first target in the radius around the caster
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) || GetIsReactionTypeNeutral(oTarget))
        {
            //Fire spell cast at event for target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            //Apply VFX impact and bonus effects
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,TurnsToSeconds(nDuration));
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


