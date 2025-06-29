//::///////////////////////////////////////////////
//:: Mass Heal
//:: [NW_S0_MasHeal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals all friendly targets within 10ft to full
//:: unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
void main()
{
  //Declare major variables
  effect eKill;
  effect eVis = EffectVisualEffect(VFX_IMP_HEALING_X);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_X);
  effect eStrike1 = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
  effect eStrike2 = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
  effect eStrike3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
  effect eStrike = EffectLinkEffects(eStrike1,eStrike2);
  eStrike = EffectLinkEffects(eStrike, eStrike3);
  int nTouch, nModify, nDamage, nHeal;
  int nMetaMagic = GetMetaMagicFeat();
  float fDelay;
  location lLoc =  GetItemActivatedTargetLocation();
  //Apply VFX area impact
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);
  //Get first target in spell area
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lLoc);
  while(GetIsObjectValid(oTarget))
  {
      fDelay = GetRandomDelay();
      //Check to see if the target is an undead
      if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
        {
            //Make a faction check
            if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget) ||
             GetIsReactionTypeNeutral(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(GetItemActivator(), GetSpellId(), FALSE));
                //Determine amount to heal
                {
                nHeal = 450;
                }
                //Set the damage effect
                eHeal = EffectHeal(nHeal);
                //Apply the VFX impact and heal effect
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
      }
      //Get next target in the spell area
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lLoc);
   }
}
