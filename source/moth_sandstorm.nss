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
    effect ePosVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eNegVis = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eImpact1 = EffectVisualEffect(VFX_FNF_HOWL_ODD);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    effect eNegVis1 = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    effect eNegVis2 = EffectVisualEffect(VFX_IMP_TORNADO);
    effect eNegLink = EffectLinkEffects(eNegVis1, eNegVis2);
    effect eDamage;
    int nCasterLvl = MothGetCasterLevel(oPlayer);
    int nBonus;
    int nDamageBonus;
    int nDamage;
    if (nCasterLvl <= 19)
    {
    nBonus = 1;
    nDamageBonus = DAMAGE_BONUS_1;
    }
    else if (nCasterLvl <= 39)
    {
    nBonus = 2;
    nDamageBonus = DAMAGE_BONUS_2;
    }
    else
    {
    nBonus = 3;
    nDamageBonus = DAMAGE_BONUS_3;
    }
    effect eBonAttack = EffectDamageIncrease(nDamageBonus,DAMAGE_TYPE_PIERCING);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect ePosLink = EffectLinkEffects(eBonAttack, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, OBJECT_SELF,TurnsToSeconds(nDuration)*2);
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget) && oTarget != OBJECT_SELF)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,TurnsToSeconds(nDuration)*2);
        }
        else if(!MothGetIsFortAlly(oTarget))
        {
            nDamage = d4(nCasterLvl) + d6(3);
            eDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING,DAMAGE_POWER_PLUS_FIVE);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegLink, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegVis, oTarget);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


