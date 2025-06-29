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
    effect eImpact1 = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    effect eImpact2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eImpact = EffectLinkEffects(eImpact1,eImpact2);
    int nCasterLvl = MothGetCasterLevel(oPlayer);
    int nBonus;
    if (nCasterLvl <= 19){nBonus = 1;}
    else if (nCasterLvl <= 39){nBonus = 2;}
    else {nBonus = 3;}
    effect eBonDam = EffectDamageIncrease(nBonus, DAMAGE_TYPE_DIVINE);
    effect eBonSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
    effect ePosDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect ePosLink = EffectLinkEffects(eBonDam, eBonSkill);
    ePosLink = EffectLinkEffects(ePosLink, ePosDur);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if(MothGetIsFortAlly(oTarget))
        {
            if(MothAllowSelfDaystar(oTarget,oPlayer))
            {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, ePosVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePosLink, oTarget,TurnsToSeconds(nDuration)*2);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}


