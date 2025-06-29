#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oPlayer = OBJECT_SELF;
    object oTarget;
    effect ePosVis = EffectVisualEffect(VFX_IMP_EVIL_HELP);
    effect eNegVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    int nCasterLvl = MothGetCasterLevel(oPlayer);
    int nBonus;
    if (nCasterLvl <= 19){nBonus = 1;}
    else if (nCasterLvl <= 39){nBonus = 2;}
    else {nBonus = 3;}
    effect eBonAttack = EffectAttackIncrease(nBonus);
    effect eBonSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nBonus);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus+1);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect ePosLink = EffectLinkEffects(eBonAttack, eBonSave);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);

    effect eNegAttack = EffectAttackDecrease(nBonus);
    effect eNegSave = EffectSavingThrowDecrease(SAVING_THROW_WILL, nBonus);
    effect eNegSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nBonus+1);
    effect eNegDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

    effect eNegLink = EffectLinkEffects(eNegAttack, eNegSave);
    eNegLink = EffectLinkEffects(eNegLink, eNegSkill);
    eNegLink = EffectLinkEffects(eNegLink, eNegDur);

    int nDuration = MothGetCasterLevel(OBJECT_SELF)*2;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
      if(oTarget == OBJECT_SELF)
      {
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
      }
        if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) || GetIsReactionTypeNeutral(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIRGE, FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,HoursToSeconds(nDuration)*2);
        }
        else if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIRGE));
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eNegLink, oTarget, HoursToSeconds(nDuration));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


