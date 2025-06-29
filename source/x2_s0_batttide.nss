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
    effect ePosVis1 = EffectVisualEffect(VFX_IMP_KNOCK);
    effect ePosVis2 = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eNegVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect ePosVis = EffectLinkEffects(ePosVis1, ePosVis2);
    int nCasterLvl = MothGetCasterLevel(oPlayer);
    int nBonus;
    if (nCasterLvl <= 19){nBonus = 1;}
    else if (nCasterLvl <= 39){nBonus = 2;}
    else {nBonus = 3;}
    effect eBonAttack = EffectAttackIncrease(nBonus);
    effect eBonSave = EffectACIncrease(nBonus,AC_DEFLECTION_BONUS);
    effect eBonDam = EffectDamageIncrease(nBonus, DAMAGE_TYPE_NEGATIVE);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect ePosLink = EffectLinkEffects(eBonAttack, eBonSave);
    ePosLink = EffectLinkEffects(ePosLink, eBonDam);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);
    effect eNegAttack = EffectAttackDecrease(nBonus);
    effect eNegSave = EffectACDecrease(nBonus,AC_DEFLECTION_BONUS);
    effect eNegDam = EffectDamageDecrease(nBonus, DAMAGE_TYPE_MAGICAL);
    effect eNegSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nBonus);
    effect eNegDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eNegLink = EffectLinkEffects(eNegAttack, eNegSave);
    eNegLink = EffectLinkEffects(eNegLink, eNegDam);
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
            ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BATTLETIDE, FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,TurnsToSeconds(nDuration));
        }
        else if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BATTLETIDE));
            if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
            {
                ApplySpellLocalInt(oTarget, OBJECT_SELF, GetSpellId());
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eNegLink, oTarget, RoundsToSeconds(nDuration));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

