//::///////////////////////////////////////////////
//:: Shadow Evade
//:: X0_S2_ShadEvade    .nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster the following bonuses:
    Level 4:
      5% concealment
      5/+1 DR
      +1 AC
    Level 6
      10% concealment
      5/+2 DR
      +2 AC

    Level 8
      15% concealment
      10/+2 DR
      +3 AC

    Level 10
      20% concealment
      10/+3 DR
      +4 AC

    Lasts: 5 rounds


   Epic:
   +2 DR Amount +1 DR Power per 5 levels after 10

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:: Updated for Epic Level: 2003-07-24 Georg
//:://////////////////////////////////////////////
#include "x2_inc_spellhook"
#include "x0_i0_spells"
void main()
{
    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
    int nConceal, nDRAmount, nDRPower, nAC;
    int nDuration = 10+nLevel;
    if (nLevel <=3){nConceal = 0; nDRAmount = 0; nDRPower = DAMAGE_POWER_PLUS_ONE; nAC = 0;}
    else if (nLevel <=4){nConceal = 10; nDRAmount = 10; nDRPower = DAMAGE_POWER_PLUS_TWO; nAC = 1;}
    else if (nLevel <=6){nConceal = 25; nDRAmount = 15; nDRPower = DAMAGE_POWER_PLUS_THREE; nAC = 2;}
    else if (nLevel <=8){nConceal = 25; nDRAmount = 15; nDRPower = DAMAGE_POWER_PLUS_FOUR; nAC = 3;}
    else if (nLevel <=10){nConceal = 30; nDRAmount = 15; nDRPower = DAMAGE_POWER_PLUS_FIVE; nAC = 4;}
    else if (nLevel <=15){nConceal = 35; nDRAmount = 15; nDRPower = DAMAGE_POWER_PLUS_SIX; nAC = 5;}
    else if (nLevel <=20){nConceal = 40; nDRAmount = 20; nDRPower = DAMAGE_POWER_PLUS_SEVEN; nAC = 6;}
    else if (nLevel <=25){nConceal = 50; nDRAmount = 20; nDRPower = DAMAGE_POWER_PLUS_EIGHT; nAC = 7;}
    else {nConceal = 55; nDRAmount = 25; nDRPower = DAMAGE_POWER_PLUS_NINE; nAC = 10;}
    //Declare effects
    effect eConceal = EffectConcealment(nConceal);
    effect eDR = EffectDamageReduction(nDRAmount, nDRPower);
    effect eAC = EffectACIncrease(nAC,AC_DODGE_BONUS);
    effect eDur= EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
    effect eSkil1 = EffectSkillIncrease(SKILL_HIDE,nLevel);
    effect eSkil2 = EffectSkillIncrease(SKILL_MOVE_SILENTLY,nLevel);
    //Link effects
    effect eLink = EffectLinkEffects(eConceal, eDR);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis2);
    eLink = EffectLinkEffects(eLink, eSkil1);
    eLink = EffectLinkEffects(eLink, eSkil2);
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    //Signal Spell Event
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 477, FALSE));
    RemoveEffectsFromSpell(OBJECT_SELF,477);
    eLink = ExtraordinaryEffect(eLink);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
}


