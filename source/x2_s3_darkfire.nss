#include "x2_i0_spells"
void MothShifterSR(object oShifter, int nSpell, int nBaseSR)
{
    int nSR = nBaseSR+GetHitDice(oShifter);
    if (GZGetDelayedSpellEffectsExpired(nSpell,oShifter,oShifter))
    {
        return;
    }
    if(!GetHasEffect(EFFECT_TYPE_POLYMORPH,oShifter))
    {
        return;
    }
    effect eSR = EffectSpellResistanceIncrease(nSR);
    eSR = ExtraordinaryEffect(eSR);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSR, oShifter,90.1);
    DelayCommand(90.0,MothShifterSR(oShifter,nSpell,nBaseSR));
}
void MothRDDWarlockAppearance(object oRDD, int nSpell, int nWingLevel)
{
    int nRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oRDD);
    if (GZGetDelayedSpellEffectsExpired(nSpell,oRDD,oRDD))
    {
         if(nRDD<nWingLevel)
         {
         SetCreatureWingType(CREATURE_WING_TYPE_NONE,oRDD);
         }
         SetCreatureTailType(CREATURE_TAIL_TYPE_NONE,oRDD);
         return;
    }
    effect ePlaceholder = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    ePlaceholder = SupernaturalEffect(ePlaceholder);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePlaceholder, oRDD,60.1);
    DelayCommand(60.0,MothRDDWarlockAppearance(oRDD,nSpell,nWingLevel));
}
void main()
{
  int nRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,OBJECT_SELF);
  int nWingLevel = 9;
  effect eVis = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_20);
  if(nRDD>1)
  {
  DelayCommand(4.0,MothRDDWarlockAppearance(OBJECT_SELF,GetSpellId(),nWingLevel));
  eVis = SupernaturalEffect(eVis);
  }
  else
  {
  DelayCommand(4.0,MothShifterSR(OBJECT_SELF,GetSpellId(),8));
  eVis = ExtraordinaryEffect(eVis);
  }
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, OBJECT_SELF,5.0);
}
