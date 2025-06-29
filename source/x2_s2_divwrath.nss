#include "nw_i0_spells"
void main()
{
    if (GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, OBJECT_SELF) >= 11)
    {
        if(GetLocalInt(OBJECT_SELF,"MothChampStart")==0)
          {
          int nChamp =1;
          IncrementRemainingFeatUses(OBJECT_SELF,FEAT_DIVINE_WRATH);
          FloatingTextStringOnCreature("<cðæŒ>*Epic Champion of Torm. First Divine Wrath is a free action!*</c>",OBJECT_SELF);
          SetLocalInt(OBJECT_SELF,"MothChampStart",nChamp);
          }
        if(GetLocalInt(OBJECT_SELF,"MothChampStart")>=1)
          {
          }
    }
    object oTarget = OBJECT_SELF;
    int nDuration = GetAbilityModifier(ABILITY_CHARISMA, OBJECT_SELF);
    int nDuration2 = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oTarget);
    if(nDuration <= 0)
    {
        FloatingTextStrRefOnCreature(100967,OBJECT_SELF);
        return;
    }
    nDuration = nDuration+nDuration2;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    eVis = EffectLinkEffects(EffectVisualEffect(VFX_IMP_GOOD_HELP),eVis);
    effect eAttack, eDamage, eSaving, eReduction;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 621, FALSE));
    int nAttackB = 3;
    int nDamageB = DAMAGE_BONUS_3;
    int nSaveB = 3 ;
    int nDmgRedB = 5;
    int nDmgRedP = DAMAGE_POWER_PLUS_ONE;
    int nLevel = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oTarget) ;
    int nLevelB = (nLevel / 5)-1;
    if (nLevelB <=0)
    {
        nLevelB =0;
    }
    else
    {
        nAttackB += (nLevelB*2);
        nSaveB += (nLevelB*2);
    }

    if (nLevelB >6 )
    {
        nDmgRedP = DAMAGE_POWER_PLUS_FIVE;
        nDmgRedB = 7*5;
        nDamageB = DAMAGE_BONUS_17;
    }
    else if (nLevelB >5 )
    {
        nDmgRedP = DAMAGE_POWER_PLUS_FIVE;
        nDmgRedB = 6*5;
        nDamageB = DAMAGE_BONUS_15;
    }
    else if (nLevelB >4 )
    {
        nDmgRedP = DAMAGE_POWER_PLUS_FIVE;
        nDmgRedB = 5*5;
        nDamageB = DAMAGE_BONUS_13;
    }
    else if (nLevelB >3)
    {
        nDmgRedP = DAMAGE_POWER_PLUS_FOUR;
        nDmgRedB = 4*5;
        nDamageB = DAMAGE_BONUS_11;
    }
    else if (nLevelB >2)
    {
        nDmgRedP = DAMAGE_POWER_PLUS_THREE;
        nDmgRedB = 3*5;
        nDamageB = DAMAGE_BONUS_9;
    }
    else if (nLevelB >1)
    {
        nDmgRedP = DAMAGE_POWER_PLUS_TWO;
        nDmgRedB = 2*5;
        nDamageB = DAMAGE_BONUS_7;
    }
    else if (nLevelB >0)
    {
        nDamageB = DAMAGE_BONUS_5;
    }
    eAttack = EffectAttackIncrease(nAttackB,ATTACK_BONUS_MISC);
    eDamage = EffectDamageIncrease(nDamageB, DAMAGE_TYPE_DIVINE);
    eSaving = EffectSavingThrowIncrease(SAVING_THROW_ALL,nSaveB, SAVING_THROW_TYPE_ALL);
    eReduction = EffectDamageReduction(nDmgRedB, nDmgRedP);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eAttack, eDamage);
    eLink = EffectLinkEffects(eSaving,eLink);
    eLink = EffectLinkEffects(eReduction,eLink);
    eLink = EffectLinkEffects(eDur,eLink);
    eLink = SupernaturalEffect(eLink);
    RemoveEffectsFromSpell(oTarget, GetSpellId());
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
