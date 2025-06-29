#include "moth_inc_effects"
#include "X0_INC_HENAI"
#include "x2_inc_switches"
void main()
{
    effect ePer = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    effect eSee = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSee,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(1,9.0),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillIncrease(SKILL_DISCIPLINE,11),OBJECT_SELF);
    DelayCommand(3.0,MothPermanentNPCBuff(2));
    SetAssociateListenPatterns();
    bkSetListeningPatterns();
    SetAssociateState(NW_ASC_SCALED_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    SetAssociateState(NW_ASC_DISTANCE_4_METERS);
    if (GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster()) == OBJECT_SELF) {
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);
    }
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) == TRUE)
    {
        effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        eConceal = ExtraordinaryEffect(eConceal);
        effect eGhost = EffectCutsceneGhost();
        eGhost = ExtraordinaryEffect(eGhost);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
    }
    SetAssociateStartLocation();
}


