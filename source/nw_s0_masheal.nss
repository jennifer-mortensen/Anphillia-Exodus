#include "x2_inc_spellhook"
#include "_inc_spells"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
  object oScroll = GetSpellCastItem();
  int nLevel = MothGetCasterLevel(OBJECT_SELF);
  int nPureDruid = FALSE;
  if(MothGetIsPureClass(CLASS_TYPE_DRUID,OBJECT_SELF))
  {
   nPureDruid = TRUE;
  }
  int nTouch, nModify, nDamage, nHeal;
  int nMetaMagic = GetMetaMagicFeat();
  int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
  float fRadiusBase = 6.67;
  float fRadiusBonus = 0.15*nLevel;
  float fRadius = fRadiusBase + fRadiusBonus;
  float fDelay;
  effect eKill, eHeal;
  effect eVis = EffectVisualEffect(VFX_IMP_HEALING_X);
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_X);
  effect eStrike1 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
  effect eStrike2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
  effect eStrike3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
  effect eStrike = EffectLinkEffects(eStrike1,eStrike2);
  eStrike = EffectLinkEffects(eStrike, eStrike3);
  location lLoc =  GetSpellTargetLocation();
  if(GetIsObjectValid(oScroll))
  {
    fRadius = fRadiusBase;
    nPureDruid = FALSE;
  }
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lLoc);
  while(GetIsObjectValid(oTarget))
  {
    fDelay = GetRandomDelay();
    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD && MothGetIsFortAlly(oTarget)==FALSE)
      {
         SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,SPELL_MASS_HEAL));
            nTouch = TouchAttackRanged(oTarget);
            if (nTouch > 0)
            {
             if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
               {
                //if(GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
                //  {
                //  nModify = d20(6);
                //  }
                //  else
                //  {
                //  nModify = d20();
                //  }
                //  if (nMetaMagic == METAMAGIC_MAXIMIZE)
                //     {
                //     if(GetHasFeat(FEAT_HEALING_DOMAIN_POWER))
                //       {
                //       nModify = 120;
                //       }
                //       else
                //       {
                //       nModify = 20;
                //       }
                //     }
                 nDamage = GetDomainAdjustedHeal(250) /*+ nModify*/;
                 eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                 DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eKill,oTarget));
                 DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                 }
            }
      }
    else
      {
       if(GetRacialType(oTarget)!=RACIAL_TYPE_UNDEAD && MothGetIsFortAlly(oTarget)==TRUE)
         {
         SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,SPELL_MASS_HEAL,FALSE));
         //if(GetHasFeat(FEAT_HEALING_DOMAIN_POWER) && !GetIsObjectValid(oScroll))
         //  {
         //  nHeal = 375;
         //  }
         //  else
         //  {
           nHeal = GetDomainAdjustedHeal(250);
         //  }
         if(GetRacialType(oTarget)==RACIAL_TYPE_ANIMAL ||
           GetRacialType(oTarget)==RACIAL_TYPE_DRAGON)
         {
           if(nPureDruid == TRUE)
           {
           nHeal = 500;
           }
         }
         eHeal = EffectHeal(nHeal);
         if(nDruid > 0) //J. Persinne; Druids that cast this spell now provide a heal over time effect to the target.
         {
            ApplyDruidHoT(250, oTarget);
         }
         DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oTarget));
         DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis2,oTarget));
         }
      }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLoc);
   }
}
