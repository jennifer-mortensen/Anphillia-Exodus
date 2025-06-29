#include "x0_i0_spells"
void main()
{
    if (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, OBJECT_SELF) >= 10)
    {
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartStand")==0)
          {
          int nChamp =1;
          IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_STAND);
          FloatingTextStringOnCreature("<c“pØ>*Epic Purple Dragon Knight. First Final Stand is a free action!*</c>",OBJECT_SELF);
          SetLocalInt(OBJECT_SELF,"MothPDKStartStand",nChamp);
          }
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartStand")>=1)
          {
          }
    }
    object oPDK = OBJECT_SELF;
    int nCount = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPDK);
    int nHeal;
    float fRangeBase = 16.0;
    float fRangeBonus = IntToFloat(nCount);
    float fRange = fRangeBase+fRangeBonus;
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nRoll =1+nChr+nCount;
    int nHP = d6(nRoll);
    effect eHP = EffectTemporaryHitpoints(nHP);
    effect eVis = EffectVisualEffect(VFX_IMP_PDK_GENERIC_HEAD_HIT);
    effect eHeal;
    DelayCommand(0.8, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE), oPDK));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_FINAL_STAND), oPDK);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,fRange, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 810, FALSE));
    while (GetIsObjectValid(oTarget))
    {
        nHeal = nCount * nChr;
        if(nHeal <= 0)
        {
            nHeal = 1;
        }
        eHeal = EffectHeal(nHeal);
      if(GetRacialType(oTarget)!=RACIAL_TYPE_UNDEAD && MothGetIsFortAlly(oTarget)==TRUE)
        {
            RemoveEffectsFromSpell(oTarget, 810);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
            DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, TurnsToSeconds(nCount)));
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_G), oTarget));
            DelayCommand(0.9, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE), oTarget));

        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,fRange, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
    }
}
