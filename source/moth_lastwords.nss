#include "x2_inc_spellhook"
#include "moth_inc_bigby"
#include "moth_inc_spells"
#include "moth_inc_spell2"
void main()
{
  if (!X2PreSpellCastCode())
  {
      return;
  }
  object oScroll = GetSpellCastItem();
  int nLevel = MothGetCasterLevel(OBJECT_SELF);
  int nHeal;
  int nMetaMagic = GetMetaMagicFeat();
  float fRadiusBase = 8.00;
  float fRadiusBonus = 0.15*nLevel;
  float fRadius = fRadiusBase + fRadiusBonus;
  float fDelay;
  effect eHeal;
  effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eVis2 = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);
  effect eStrike1 = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
  effect eStrike2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
  effect eStrike3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
  effect eStrike = EffectLinkEffects(eStrike1,eStrike2);
  eStrike = EffectLinkEffects(eStrike, eStrike3);
  location lLoc =  GetSpellTargetLocation();
  if(GetIsObjectValid(oScroll))
  {
    fRadius = fRadiusBase;
  }
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc);
  while(GetIsObjectValid(oTarget))
  {
       fDelay = GetRandomDelay();
       if(MothGetIsFortAlly(oTarget)==TRUE)
         {
         SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId(),FALSE));
         eHeal = EffectHeal(400);
         DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget));
         DelayCommand(fDelay,MothRemoveBigby(oTarget));
         DelayCommand(fDelay,MothGreaterRestoration(oTarget));
         DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oTarget));
         ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
         }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc);
   }
}
