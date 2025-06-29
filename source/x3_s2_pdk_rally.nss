#include "x0_i0_spells"
void main()
{
    if (GetHasEffect(EFFECT_TYPE_SILENCE,OBJECT_SELF))
    {
        FloatingTextStrRefOnCreature(85764,OBJECT_SELF);
        return;
    }
    if (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, OBJECT_SELF) >= 10)
    {
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartRally")==0)
          {
          int nChamp =1;
          IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_RALLY);
          FloatingTextStringOnCreature("<c“pØ>*Epic Purple Dragon Knight. First Rallying Cry is a free action!*</c>",OBJECT_SELF);
          SetLocalInt(OBJECT_SELF,"MothPDKStartRally",nChamp);
          }
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartRally")>=1)
          {
          }
    }
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nDuration = (nChr*5)+1;
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT);
    int nAttack = nCasterLevel/2;
    effect eAttack = EffectSkillIncrease(SKILL_ALL_SKILLS,nAttack);
    effect eSpeed = EffectDamageReduction(nCasterLevel,DAMAGE_POWER_PLUS_SIX,0);
    effect eLink = EffectLinkEffects(eAttack, eSpeed);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = ExtraordinaryEffect(eLink);
    effect eImpact = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_RALLYING_CRY), OBJECT_SELF);
    DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 16.0, GetLocation(OBJECT_SELF));
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 806, FALSE));
    while(GetIsObjectValid(oTarget))
    {
         if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
         {
            if(MothGetIsFortAlly(oTarget)==TRUE)
            {
                RemoveEffectsFromSpell(oTarget, 806);
                DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEAD_ODD), oTarget);
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 16.0, GetLocation(OBJECT_SELF));
    }
}
