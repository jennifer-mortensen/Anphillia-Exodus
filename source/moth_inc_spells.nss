#include "x0_i0_spells"
#include "x3_inc_skin"
#include "_inc_xp"
#include "_inc_gen"

//J. Persinne, July 25 2009; All bonus feat functions now respect a parameter nFeedback, which defaults to TRUE; when set to FALSE as the function is called, the player will not receive
//feedback about their updated hide.

//Spell include file for Anphillia Genesis
int nMothBonus3 = d6(3);
int nMothBonus2 = d6(2);
int nMothBonus1 = d6(1);
int nMothBonus3max = 18;
int nMothBonus2max = 12;
int nMothBonus1max = 6;

//* Adjusts Evasion Feats to do 1/4 Damage instead of 0 damage on a succeful Reflex Save.
//  Will only apply if the caster (object oSaveVersus) is a Playable Character.
int MothGetReflexAdjustedDamage(int nDamage, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);
// * Applies Petrification.
void MothPetrifyApply(object oTarget,int nDuration);
// * Handles Petrification in the spell-script.
void MothPetrify(object oSource, object oTarget, int nDuration, int nSpellID, int nDC, int nSave=SAVING_THROW_FORT);
// * Removes Petrification.
void MothRemovePetrify(object oTarget);
// * Effects from Aura vs Alignment.
effect MothCreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1);
// * Handles Missilestorms.
void MothDoMissileStorm(int nD6Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE, int nReflexSave = FALSE);
// * For Continual Flame - Less Damage, no meta magic, better damage typeand extra dmg vs undeads
void MothDoMissileStormContinualFlame(location lTarget,int nD4Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE, int nReflexSave = FALSE);
// * Special Blackstaff aura-effect.
void MothdoAura2(int nVis1, int nVis2, int nVis3, int nDamageType);
// * Special Blackstaff aura-effect.
void MothdoAura(int nAlign, int nVis1, int nVis2, int nDamageType, int nLevel);
// * Special Blackstaff effect.
void MothAddBlackStaffEffectOnWeapon (object oTarget, int nBuff, float fDuration);
// * Applies Mind Immunity and removes any ill-mindeffects.
void MothApplyMindBlank(object oTarget, int nSpellId, float fDelay=0.0);
// * Handles both Berry spells .
void MothBuffCompanion(object oTarget, int nVis, int nDamageType, int nDamageBonus, int nReduction, int nDuration, int nVisual, int nRegenAmount, float fRegenHB);
// * Places oTarget in Statis (temporary plot).
void MothApplyStatisFieldEffect(object oSource, object oTarget, float fDuration, int nSpellID, int nDC, float fDelay);
// * Clears various Timelocks and other temporary-spell effect.
//Incase the Target crashes/logs during the timer reset.
//Also makes sure no PC can be Plot-flagged.
void MothTimeLockCleaner(object oPC);
// * Removes illeffects of a supernatural nature.
void MothRemoveSupernaturalPermanentAbilityDecrease(object oTarget);
// * Handles RDD's firelink. Should be infused to the fire-based spells a RDD has acces to.
void MothFireLink(object oCaster, object oTarget, int nDamage, float fDelay=0.0);
// * Reapplies x3 hide needed for horse functions.
void MothReApplyPCHide(object oPC);
// * Grants Epic Rangers bonus spellslots.
void MothUpdateRangerSlots(object oPC, int nDisplayFeedback = TRUE);
// * Grants Epic Paladins bonus spellslots.
void MothUpdatePaladinSlots(object oPC, int nDisplayFeedback = TRUE);
// * Handles Bullrush Charge.
void MothUpdateFighterChargeBullrush(object oPC, int nDisplayFeedback = TRUE);
// * Handles Tornado Charge.
void MothUpdateFighterChargeTornado(object oPC, int nDisplayFeedback = TRUE);
// * Handles Thrust Charge.
void MothUpdateFighterThrustTornado(object oPC, int nDisplayFeedback = TRUE);
// * Updates the bonus feats applied to oPC via their PC-hide while Polymorphed.
void MothUpdateRDDHide(object oPC);
// * Updates the bonus feats applied to oPC via their PC-hide while Polymorphed.
void MothUpdateShifterHide(object oPC, int nDisplayFeedback = TRUE);
// * Updates the bonus feats applied to oPC via their PC-hide.
void MothUpdateHideFeats(object oPC, int nDisplayFeedback = TRUE);
// * Returns TRUE if oPC is Disabled in any way, excluding Polymorphed.
int MothGetIsDisabledShifter(object oPC);
// * Returns TRUE if oPC is Disabled in any way, including Polymorphed.
int MothGetIsDisabled(object oPC);
// * Returns TRUE if oTarget is any sort of associate.
int MothGetIsAssociate(object oTarget);
// * Calculates healing with regards to the Heal Domain; the equation is now base healing + 10% + an additional 10% per ten cleric levels.

int MothGetReflexAdjustedDamage(int nDamage, object oTarget, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF)
{
  int nSave = MySavingThrow(SAVING_THROW_REFLEX,oTarget,nDC,nSaveType,oSaveVersus);
  if(nSave == 0)
    {
    if(GetHasFeat(FEAT_IMPROVED_EVASION,oTarget))
      {
        nDamage = nDamage/2;
        return nDamage;
      }
      else return nDamage;
    }
  if(nSave == 1)
    {
      if(GetHasFeat(FEAT_IMPROVED_EVASION,oTarget)||
         GetHasFeat(FEAT_EVASION,oTarget)
      )
      {
        if(GetIsPC(oSaveVersus) && !(Get2DAString("spells", "UseConcentration", GetSpellId()) == "1" && GetAppearanceType(oSaveVersus) > 6))
        {
        nDamage = nDamage/4;
        return nDamage;
        }
        else
        {
        nDamage = 0;
        return nDamage;
        }
      }
      else
      {
        nDamage = nDamage/2;
        return nDamage;
      }
    }
  if(nSave == 2)
    {
       nDamage = 0;
       return nDamage;
    }
  else return nDamage;
}
void MothPetrifyApply(object oTarget,int nDuration)
{
    effect eVisual   = EffectVisualEffect(476);
    effect ePetrify1 = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
    effect ePetrify2 = EffectCutsceneParalyze();
    effect ePetrify3 = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect ePetrify4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,50);
    effect ePetrify5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,50);
    effect ePetrify6 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,50);
    effect ePetrify7 = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,50);
    effect ePetrify8 = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,50);
    effect ePetrify9 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,50);
    effect ePetrify10= EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,50);
    effect ePetrify11= EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE,50);
    effect ePetrify12= EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE,50);
    effect ePetrify13= EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,50);
    effect ePetrify  = EffectLinkEffects(ePetrify1,ePetrify2);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify3);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify4);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify5);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify6);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify7);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify8);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify9);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify10);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify11);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify12);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify13);
    ePetrify         = EffectLinkEffects(ePetrify,eVisual);
    ePetrify         = ExtraordinaryEffect(ePetrify);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePetrify, oTarget,RoundsToSeconds(nDuration));
}
void MothPetrify(object oSource, object oTarget, int nDuration, int nSpellID, int nDC, int nSave=SAVING_THROW_FORT)
{
    int nMetaMagic= GetMetaMagicFeat();
    if(nMetaMagic == METAMAGIC_EXTEND)
        {
         nDuration = nDuration * 2;
        }
    SignalEvent(oTarget, EventSpellCastAt(oSource, nSpellID));
    if(MothGetIsFortAlly(oTarget,oSource)==TRUE){return;}
    if(!MySavingThrow(nSave, oTarget, nDC, SAVING_THROW_TYPE_SPELL, oSource))
       {
         SetLocalInt(oTarget,"MothIsPetrified",TRUE);
         MothPetrifyApply(oTarget,nDuration);
       }
}
void MothRemovePetrify(object oTarget)
{
    if(GetLocalInt(oTarget,"MothIsPetrified")==TRUE)
       {
        effect eLook = GetFirstEffect(oTarget);
        while(GetIsEffectValid(eLook))
        {
            if(GetEffectSpellId(eLook) == SPELL_FLESH_TO_STONE||
               GetEffectSpellId(eLook) == SPELL_STONEHOLD||
               GetEffectSpellId(eLook) == 495||
               GetEffectSpellId(eLook) == 496||
               GetEffectSpellId(eLook) == 497)
            {
                //just in case ^^*z!~~'>
                SetCommandable(TRUE, oTarget);
                DeleteLocalInt(oTarget,"MothIsPetrified");
                RemoveEffect(oTarget, eLook);
                RemoveEffectsFromSpell(oTarget, SPELL_FLESH_TO_STONE);
                RemoveEffectsFromSpell(oTarget, SPELL_STONEHOLD);
                RemoveEffectsFromSpell(oTarget, 495);
                RemoveEffectsFromSpell(oTarget, 496);
                RemoveEffectsFromSpell(oTarget, 497);
            }
            eLook = GetNextEffect(oTarget);
        }
       }
}
effect MothCreateProtectionFromAlignmentLink(int nAlignment, int nPower = 1)
{
    int nFinal = nPower * 2;
    effect eAC = EffectACIncrease(nFinal, AC_DEFLECTION_BONUS);
    eAC = VersusAlignmentEffect(eAC, ALIGNMENT_ALL, nAlignment);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nFinal);
    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, nAlignment);
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    eImmune = VersusAlignmentEffect(eImmune,ALIGNMENT_ALL, nAlignment);
    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    return eLink;
}
void MothDoMissileStorm(int nD6Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE, int nReflexSave = FALSE)
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20;
    }
    nCasterLvl = nCasterLvl*2/3;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt = 1;
    effect eMissile = EffectVisualEffect(nMIRV);
    effect eVis = EffectVisualEffect(nVIS);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    location lTarget = GetSpellTargetLocation();
    int nMissiles = nCasterLvl;
    if (nMissiles > nCap)
    {
        nMissiles = nCap;
    }
    int nEnemies = 0;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) )
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF))
        {
            if (GetObjectSeen(oTarget,OBJECT_SELF))
            {
                nEnemies++;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
     }

     if (nEnemies == 0) return;
     int nExtraMissiles = nMissiles / nEnemies;
     if (nExtraMissiles <= 0)
     {
        nExtraMissiles = 1;
     }
     int nRemainder = 0;

     if (nExtraMissiles >0)
        nRemainder = nMissiles % nEnemies;

     if (nEnemies > nMissiles)
        nEnemies = nMissiles;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF) && (GetObjectSeen(oTarget,OBJECT_SELF)))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                if (nONEHIT == TRUE)
                {
                    nExtraMissiles = 1;
                    nRemainder = 0;
                }

                int i = 0;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    for (i=1; i <= nExtraMissiles + nRemainder; i++)
                    {
                        int nDam = d6(nD6Dice);
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        {
                             nDam = nD6Dice*6;
                        }
                        if (nMetaMagic == METAMAGIC_EMPOWER)
                        {
                              nDam = nDam + nDam/2;
                        }
                        if(nReflexSave)
                        {
                            if ( nDAMAGETYPE == DAMAGE_TYPE_ELECTRICAL )
                            {
                                nDam = MothGetReflexAdjustedDamage(nDam, oTarget, MothDC(), SAVING_THROW_TYPE_ELECTRICITY);
                            }
                            else if ( nDAMAGETYPE == DAMAGE_TYPE_FIRE )
                            {
                                nDam = MothGetReflexAdjustedDamage(nDam, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                            }
                            else if ( nDAMAGETYPE == DAMAGE_TYPE_ACID )
                            {
                                nDam = MothGetReflexAdjustedDamage(nDam, oTarget, MothDC(), SAVING_THROW_TYPE_ACID);
                            }
                        }

                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;
                        effect eDam = EffectDamage(nDam, nDAMAGETYPE);
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    }
                }
                else
                {
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                }
                nCnt++;
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

}
void MothDoLesserMissileStorm(int nD6Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE)
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    if (nCasterLvl > 24)
    {
        nCasterLvl = 24;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt = 1;
    effect eMissile = EffectVisualEffect(nMIRV);
    effect eVis = EffectVisualEffect(nVIS);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    location lTarget = GetSpellTargetLocation();
    int nMissiles = nCasterLvl;

    if (nMissiles > nCap)
    {
        nMissiles = nCap;
    }
    int nEnemies = 0;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) )
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF))
        {
            if (GetObjectSeen(oTarget,OBJECT_SELF))
            {
                nEnemies++;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
     }

     if (nEnemies == 0) return;
     int nExtraMissiles = nMissiles / nEnemies;
     if (nExtraMissiles <= 0)
     {
        nExtraMissiles = 1;
     }
     int nRemainder = 0;

     if (nExtraMissiles >0)
        nRemainder = nMissiles % nEnemies;

     if (nEnemies > nMissiles)
        nEnemies = nMissiles;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF) && (GetObjectSeen(oTarget,OBJECT_SELF)))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                if (nONEHIT == TRUE)
                {
                    nExtraMissiles = 1;
                    nRemainder = 0;
                }

                int i = 0;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    for (i=1; i <= nExtraMissiles + nRemainder; i++)
                    {
                        int nDam = d6(nD6Dice);
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        {
                             nDam = nD6Dice*6;
                        }
                        if (nMetaMagic == METAMAGIC_EMPOWER)
                        {
                              nDam = nDam + nDam/2;
                        }
                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;
                        effect eDam = EffectDamage(nDam, nDAMAGETYPE);
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    }
                }
                else
                {
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                }
                nCnt++;
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }

}
//For Continual Flame - Less Damage, no meta magic, better damage typeand extra dmg vs undeads
void MothDoMissileStormContinualFlame(location lTarget,int nD4Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE, int nReflexSave = FALSE)
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    float fRadiusBase = 8.83;
    float fRadiusBonus = 0.15*nCasterLvl;
    float fRadius = fRadiusBase + fRadiusBonus;
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20;
    }
    int nCnt = 1;
    effect eMissile = EffectVisualEffect(nMIRV);
    effect eVis = EffectVisualEffect(nVIS);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    int nMissiles = nCasterLvl;
    if (nMissiles > nCap)
    {
        nMissiles = nCap;
    }
    int nEnemies = 0;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) )
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF))
        {
            if (GetObjectSeen(oTarget,OBJECT_SELF))
            {
                nEnemies++;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE);
     }
     if (nEnemies == 0) return;
     int nExtraMissiles = nMissiles / nEnemies;
     if (nExtraMissiles <= 0)
     {
        nExtraMissiles = 1;
     }
     int nRemainder = 0;
     if (nExtraMissiles >0)
        nRemainder = nMissiles % nEnemies;
     if (nEnemies > nMissiles)
        nEnemies = nMissiles;
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF) && (GetObjectSeen(oTarget,OBJECT_SELF)))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                if (nONEHIT == TRUE)
                {
                    nExtraMissiles = 1;
                    nRemainder = 0;
                }

                int i = 0;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    for (i=1; i <= nExtraMissiles + nRemainder; i++)
                    {
                        int nDam = d4(nD4Dice);
                        if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
                        {
                         nDam = nDam*2;
                        }
                        if(nReflexSave)
                        {
                         nDam = GetReflexAdjustedDamage(nDam, oTarget, MothDC(), SAVING_THROW_TYPE_DIVINE);
                        }
                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;
                        effect eDam = EffectDamage(nDam, nDAMAGETYPE);
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    }
                }
                else
                {
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                }
                nCnt++;
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

void MothdoAura2(int nVis1, int nVis2, int nVis3, int nDamageType)
{
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nDuration2 = MothGetCasterLevel(OBJECT_SELF)+4;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = nDuration;
    if(nDamage >10)
    {nDamage=10;}
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration2 = nDuration2 * 2;
    }
    effect eBoom = EffectVisualEffect(463);
    effect eVis = EffectVisualEffect(nVis1);
    effect eDur = EffectVisualEffect(nVis2);
    effect eDur2 = EffectVisualEffect(nVis3);
    effect eEvil = EffectDamageShield(nDamage, DAMAGE_BONUS_1d4, nDamageType);
    effect eLink = EffectLinkEffects(eVis, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eEvil);
    eLink = EffectLinkEffects(eLink, eVis);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBoom, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration2));
}
void MothdoAura(int nAlign, int nVis1, int nVis2, int nDamageType, int nLevel)
{
    object oTarget = GetSpellTargetObject();
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2;
    }

    effect eVis = EffectVisualEffect(nVis1);
    effect eAC = EffectACIncrease(4, AC_DEFLECTION_BONUS);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, 4);
    effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eSR = EffectSpellResistanceIncrease(25);
    effect eDur = EffectVisualEffect(nVis2);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eEvil = EffectDamageShield(nLevel, DAMAGE_BONUS_1d8, nDamageType);
    eImmune = VersusAlignmentEffect(eImmune, ALIGNMENT_ALL, nAlign);
    eSR = VersusAlignmentEffect(eSR,ALIGNMENT_ALL, nAlign);
    eAC =  VersusAlignmentEffect(eAC,ALIGNMENT_ALL, nAlign);
    eSave = VersusAlignmentEffect(eSave,ALIGNMENT_ALL, nAlign);
    eEvil = VersusAlignmentEffect(eEvil,ALIGNMENT_ALL, nAlign);
    effect eLink = EffectLinkEffects(eImmune, eSave);
    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eSR);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eEvil);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration+4));
}
//Special Blackstaff effect.
void MothAddBlackStaffEffectOnWeapon (object oTarget, int nBuff, float fDuration)
{
   IPSafeAddItemProperty(oTarget, ItemPropertySkillBonus(SKILL_DISCIPLINE,nBuff), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE, TRUE);
   IPSafeAddItemProperty(oTarget, ItemPropertyEnhancementBonus(4), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE, TRUE);
   IPSafeAddItemProperty(oTarget, ItemPropertyOnHitProps(IP_CONST_ONHIT_GREATERDISPEL, IP_CONST_ONHIT_SAVEDC_26), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING );
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_EVIL), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE );
return;
}
//Applies Mind Immunity and removes any ill-mindeffects.
void MothApplyMindBlank(object oTarget, int nSpellId, float fDelay=0.0)
{
    effect eImm1 = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
    effect eDur = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_BLUE);
    effect eLink = EffectLinkEffects(eImm1, eDur);
    effect eSearch = GetFirstEffect(oTarget);
    int bValid;
    int nDuration = MothGetCasterLevel(OBJECT_SELF)*2;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellId, FALSE));
    while(GetIsEffectValid(eSearch))
    {
        bValid = FALSE;
        if (GetEffectType(eSearch) == EFFECT_TYPE_DAZED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_CHARMED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_SLEEP)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_CONFUSED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_STUNNED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_DOMINATED)
        {
            bValid = TRUE;
        }
        else if (GetEffectSpellId(eSearch) == SPELL_FEEBLEMIND)
        {
            bValid = TRUE;
        }
        else if (GetEffectSpellId(eSearch) == SPELL_BANE)
        {
            bValid = TRUE;
        }
        if (bValid == TRUE)
        {
            RemoveEffect(oTarget, eSearch);
        }
        eSearch = GetNextEffect(oTarget);
    }

    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

}
//Berry spells
void MothBuffCompanion(object oTarget, int nVis, int nDamageType, int nDamageBonus, int nReduction, int nDuration, int nVisual, int nRegenAmount, float fRegenHB)
{
        effect eVis = EffectVisualEffect(nVis);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        effect eDamage = EffectDamageIncrease(nDamageBonus, nDamageType);
        effect eReduction = EffectDamageResistance(nDamageType, nReduction);
        effect eHaste = EffectHaste();
        effect eRegen = EffectRegenerate(nRegenAmount, fRegenHB);
        effect eLink = EffectLinkEffects(eDamage, eReduction);
        eLink = EffectLinkEffects(eLink, eHaste);
        eLink = EffectLinkEffects(eLink, eRegen);
        effect eDur = EffectVisualEffect(nVisual);
        eLink = EffectLinkEffects(eLink, eDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));

}
void MothApplyStatisFieldEffect(object oSource, object oTarget, float fDuration, int nSpellID, int nDC, float fDelay)
{
    object oWeapon   = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    effect ePetrify1 = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
    effect ePetrify2 = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    effect ePetrify3 = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);
    effect ePetrify4 = EffectVisualEffect(VFX_DUR_GHOSTLY_PULSE);
    effect ePetrify5 = EffectCutsceneParalyze();
    effect ePetrify6 = EffectDeaf();
    effect ePetrify  = EffectLinkEffects(ePetrify1,ePetrify2);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify3);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify4);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify5);
    ePetrify         = EffectLinkEffects(ePetrify,ePetrify6);
    ePetrify         = SupernaturalEffect(ePetrify);
    effect eVis      = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    SignalEvent(oTarget, EventSpellCastAt(oSource, nSpellID));
    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SPELL, oSource))
       {
         SetLocalInt(oTarget,"MothIsInStasis",TRUE);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePetrify, oTarget,fDuration);
         DelayCommand(fDelay+0.5,SetPlotFlag(oTarget,TRUE));
         DelayCommand(fDelay+0.5,SetPlotFlag(oWeapon,TRUE));
         DelayCommand(fDuration,SetPlotFlag(oTarget,FALSE));
         DelayCommand(fDuration,SetPlotFlag(oWeapon,FALSE));
         DelayCommand(fDuration,DeleteLocalInt(oTarget,"MothIsInStasis"));
         DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+4.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+7.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+11.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+15.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+19.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+23.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+27.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
         DelayCommand(fDelay+31.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
       }

}
void MothRestorePlotWeapon(object oPC)
{
    if(GetLocalInt(oPC,"MothIsInStasis"))
    {
     object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
     SetPlotFlag(oWeapon,FALSE);
    }
}
// Clears various Timelocks and other temporary-spell effect.
// Incase the Target crashes/logs during the timer reset.
// Also makes sure no PC can be Plot-flagged.
void MothTimeLockCleaner(object oPC)
{
    DelayCommand(120.0,DeleteLocalInt(oPC,"selfharm"));
    DelayCommand(20.0,DeleteLocalInt(oPC,"mothstonehold"));
    DelayCommand(20.0,DeleteLocalInt(oPC,"truestrike"));
    DelayCommand(20.0,DeleteLocalInt(oPC,"mothpowermino"));
    DelayCommand(20.0,DeleteLocalInt(oPC,"MOTHRESTGARG"));
    DelayCommand(20.0,DeleteLocalInt(oPC,"hurlboulder"));
    DelayCommand(120.0,DeleteLocalInt(oPC, "FocusDancer"));
    DelayCommand(20.0,DeleteLocalInt(oPC,"FocusSpellStasis"));
    DelayCommand(25.0,DeleteLocalInt(oPC,"MothIsInStasis"));
    DelayCommand(25.1,SetPlotFlag(oPC,FALSE));
    DelayCommand(25.0,DeleteLocalInt(oPC,"MothAuraOfCourage"));
    DelayCommand(60.0,DeleteLocalInt(oPC,"MothIsPetrified"));
    DelayCommand(60.1,MothRemovePetrify(oPC));
    DelayCommand(33.0, DeleteLocalInt(oPC, "FocusSpell"));
    DelayCommand(33.0, DeleteLocalInt(oPC, "FocusSpell2"));
    DelayCommand(60.0, DeleteLocalInt(oPC, "MOTHKEGSPELL"));
    DelayCommand(33.0, DeleteLocalInt(oPC, "FocusSpellBB"));
    DelayCommand(30.0, DeleteLocalInt(oPC, "SUMMON_CREATURE_IX_TIMELOCK"));
    DelayCommand(60.0, DeleteLocalInt(oPC, "DIRETIGER_THRUST_TIMELOCK"));
}
void MothRemoveSupernaturalPermanentAbilityDecrease(object oTarget)
{
    //<-Remove if you have Subraces with decreasing stats(not recommended) /*
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE)
        {
            if(GetEffectSubType(eBad)==SUBTYPE_SUPERNATURAL && GetEffectDurationType(eBad)==DURATION_TYPE_PERMANENT)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    //<-Remove if you have Subraces with decreasing stats(not recommended) */
}
void MothFireLink(object oCaster, object oTarget, int nDamage, float fDelay=0.0)
{
   if(GetAppearanceType(oCaster) == 1032||
      GetAppearanceType(oCaster) == 1033)
   {
   int nRDD = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oCaster);
   float fProcentBonus = IntToFloat(nRDD)/100;
   float fProcent = 0.19 + fProcentBonus;
   float fDamage = fProcent*IntToFloat(nDamage);
   int nNewDamage = FloatToInt(fDamage);
   if(nNewDamage<5)
   {
     nNewDamage=5;
   }
   effect eDam = EffectDamage(nNewDamage, DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
   effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
   eDam = SupernaturalEffect(eDam);
   DelayCommand(0.01+fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
   DelayCommand(0.01+fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
   }
   else
   {
   return;
   }
}

void MothAddNewSkin(object oPC);

void MothReApplyPCHide(object oPC)
{
    //SKIN_SupportGetSkin(oPC);
    //return;
    MothAddNewSkin(oPC);
}

void MothAddNewSkin(object oPC)
{
   object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
   DestroyObject(oItem);
   object oSkin=CreateItemOnObject("x3_it_pchide",oPC);
   if(GetItemPossessor(oSkin) != oPC) //J. Persinne; check added for full inventory.
   {
       DestroyObject(oSkin);
       SendMessageToPC(oPC, "Some of your special abilities could not be applied because your inventory was full. Please make room for a 2x2 square in your inventory and then relog.");
       SetLocalInt(oPC, "INVENTORY_FULL", 1);
   }
   else
   {
       SetLocalObject(oPC, "oX3_Skin", oSkin);
       //DelayCommand(1.0, AssignCommand(oPC, ClearAllActions()));
       DelayCommand(1.0,AssignCommand(oPC, ActionDoCommand(ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR))));
       DeleteLocalInt(oPC, "INVENTORY_FULL");
   }
}
void MothUpdateDruidSlots(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_EPIC_DRUID,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateDruidSlots(oPC));
        }
        return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N,DURATION_TYPE_PERMANENT,-1);
    if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Epic Druid detected. Bonus Spell Slots granted.</c>");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,6),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,7),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,8),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,9),oItem);
}
void MothUpdateBardSlots(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_EPIC_BARD,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateBardSlots(oPC));
        }
        return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N,DURATION_TYPE_PERMANENT,-1);
    if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Epic Bard detected. Bonus Spell Slots granted.</c>");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,6),oItem);
}
void MothUpdateRangerSlots(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_EPIC_RANGER,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateRangerSlots(oPC));
        }
        return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N,DURATION_TYPE_PERMANENT,-1);
    if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Epic Ranger detected. Bonus Spell Slots granted.</c>");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER,4),oItem);
}
void MothUpdatePaladinSlots(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_EPIC_PALADIN,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdatePaladinSlots(oPC));
        }
        return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N,DURATION_TYPE_PERMANENT,-1);
    if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Epic Paladin detected. Bonus Spell Slots granted.</c>");
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN,4),oItem);
}
void MothUpdatePureSlots(object oPC, int nClass, int nClassProperty, int nDisplayFeedback = TRUE)
{
    if(!MothGetIsPureClass(nClass,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdatePureSlots(oPC,nClass,nClassProperty));
        }
        return;
    }
    IPRemoveMatchingItemProperties(oItem,ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N,DURATION_TYPE_PERMANENT,-1);
    if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Pure Caster detected. Bonus Spell Slots granted.</c>");
    if(nClass == CLASS_TYPE_PALADIN ||
       nClass == CLASS_TYPE_RANGER)
    {
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,4),oItem);
    }
    else if(nClass == CLASS_TYPE_DRUID)
    {
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,6),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,6),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,7),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,7),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,8),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,8),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,9),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID,9),oItem);
    }
    else if(nClass == CLASS_TYPE_BARD)
    {
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,6),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD,6),oItem);
    }
    else
    {
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,0),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,1),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,2),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,3),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,4),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,5),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,6),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,7),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,8),oItem);
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusLevelSpell(nClassProperty,9),oItem);
    }
}
void MothGetIsPureCasterForSlots(object oPC, int nDisplayFeedback = TRUE)
{
    int nClass = GetClassByPosition(1,oPC);
    if(GetECLAdjustedHitDice(oPC)<40)
    {
     return;
    }
    if(nClass == CLASS_TYPE_BARD)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_BARD, nDisplayFeedback);
    }
    else if(nClass == CLASS_TYPE_CLERIC)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_CLERIC, nDisplayFeedback);
    }
    else if(nClass == CLASS_TYPE_DRUID)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_DRUID, nDisplayFeedback);
    }
    else if(nClass == CLASS_TYPE_PALADIN)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_PALADIN, nDisplayFeedback);
    }
    else if(nClass == CLASS_TYPE_RANGER)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_RANGER, nDisplayFeedback);
    }
    else if(nClass == CLASS_TYPE_SORCERER)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_SORCERER, nDisplayFeedback);
    }
    else if(nClass == CLASS_TYPE_WIZARD)
    {
     MothUpdatePureSlots(oPC,nClass,IP_CONST_CLASS_WIZARD, nDisplayFeedback);
    }
}
void MothUpdateFighterChargeBullrush(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_SPRING_ATTACK,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    if(!GetHasFeat(FEAT_IMPROVED_KNOCKDOWN,oPC))
    {
     return;
    }
    if(!GetHasFeat(FEAT_EPIC_PROWESS,oPC))
    {
     return;
    }
    if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)<25)
    {
     return;
    }
    if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>2)
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateFighterChargeBullrush(oPC));
        }
    return;
    }
    else if(GetIsObjectValid(oItem))
    {
     if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Bullrush Charge-Ability Enabled. Useable by the Player Tool 1 Feat.</c>");
    }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_01),oItem);
}
void MothUpdateFighterChargeTornado(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_IMPROVED_WHIRLWIND,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    if(!GetHasFeat(FEAT_IMPROVED_EXPERTISE,oPC))
    {
     return;
    }
    if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)<30)
    {
     return;
    }
    if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>2)
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateFighterChargeTornado(oPC));
        }
        return;
    }
    else if(GetIsObjectValid(oItem))
    {
     if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Tornado Charge-Ability Enabled. Useable by the Player Tool 2 Feat.</c>");
    }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_02),oItem);
}
void MothUpdateFighterThrustTornado(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_EPIC_PROWESS,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    if(!GetHasFeat(FEAT_EPIC_REFLEXES,oPC))
    {
     return;
    }
    if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>2)
    {
      return;
    }
    /*if(GetHasFeat(FEAT_SMITE_EVIL,oPC))
    {
      return;
    }
    if(GetHasFeat(FEAT_SMITE_GOOD,oPC))
    {
      return;
    }*/
    if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_1, oPC) || GetHasFeat(FEAT_EPIC_GREAT_SMITING_2, oPC) || GetHasFeat(FEAT_EPIC_GREAT_SMITING_3, oPC) || GetHasFeat(FEAT_EPIC_GREAT_SMITING_4, oPC))
        return; //J. Persinne; we no longer disallow characters with smiting from acquiring the thrust ability; we only disallow it if they have any great smiting feats.

    int nMeleeLvl = GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)+
                 GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oPC)+
                 GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)+
                 GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC)+
                 GetLevelByClass(CLASS_TYPE_RANGER,oPC)+
                 GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC)+
                 GetLevelByClass(CLASS_TYPE_HARPER,oPC) +
                 GetLevelByClass(CLASS_TYPE_PALADIN, oPC) +  //J. Persinne; added paladins, blackguards, and champions of torm to this list.
                 GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) +
                 GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC);
    if(nMeleeLvl <=20)
    {
      return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateFighterThrustTornado(oPC));
        }
        return;
    }
    else if(GetIsObjectValid(oItem))
    {
     if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Thurst Charge Ability Enabled. Useable by the Player Tool 7 Feat.</c>");
    }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_07),oItem);
}
void MothUpdateFighterPerfectHealth(object oPC, int nDisplayFeedback = TRUE)
{
    if(!GetHasFeat(FEAT_EPIC_PERFECT_HEALTH,oPC) || !GetIsObjectValid(oPC))
    {
     return;
    }
    int nMeleeLvl = GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)+
                 GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)+
                 GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC)+
                 GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oPC)+
                 GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)+
                 GetLevelByClass(CLASS_TYPE_PALADIN,oPC)+
                 GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC)+
                 GetLevelByClass(CLASS_TYPE_RANGER,oPC)+
                 GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC)+
                 GetLevelByClass(CLASS_TYPE_HARPER,oPC) +
                 GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC); //J. Persinne; added Champion of Torm.
    if(nMeleeLvl <=20)
    {
      return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateFighterPerfectHealth(oPC));
        }
        return;
    }
    else if(GetIsObjectValid(oItem))
    {
     if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Perfect Health Ability Enabled. Useable by the Player Tool 9 Feat.</c>");
    }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_09),oItem);
}
void MothUpdateFighterThreadOfLife(object oPC, int nDisplayFeedback = TRUE)
{
    if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oPC)<11 || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateFighterThreadOfLife(oPC));
        }
        return;
    }
    else if(GetIsObjectValid(oItem))
    {
     if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Tread of Life Ability Enabled. Useable by the Player Tool 10 Feat.</c>");
    }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_10),oItem);
}
/*void MothUpdateRDDHide(object oPC)
{
    if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)<1)
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
    SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
    MothAddNewSkin(oPC);
    DelayCommand(2.0,MothReApplyPCHide(oPC));
    DelayCommand(5.0,MothUpdateRDDHide(oPC));
    return;
    }
    else if(GetIsObjectValid(oItem))
    {
        if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>1)
        {
         SendMessageToPC(oPC,"<cеее>[Server] Dragon Instant Spell Gained. Useable by the Player Tool 3 Feat.</c>");
         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_03),oItem);
         SendMessageToPC(oPC,"<cеее>[Server] Dragon Self Heal Enabled. Useable by the Player Tool 6 Feat.</c>");
         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_06),oItem);
        }
        if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>6)
        {
         SendMessageToPC(oPC,"<cеее>[Server] Dragon Instant Spell Gained. Useable by the Player Tool 4 Feat.</c>");
         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_04),oItem);
        }
        if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>9)
        {
         SendMessageToPC(oPC,"<cеее>[Server] Dragon Instant Spell Gained. Useable by the Player Tool 5 Feat.</c>");
         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_05),oItem);
        }
    }
}*/
void MothUpdateShifterHide(object oPC, int nDisplayFeedback = TRUE)
{
    if(GetLevelByClass(CLASS_TYPE_SHIFTER,oPC)<1 || !GetIsObjectValid(oPC))
    {
     return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateShifterHide(oPC));
        }
        return;
    }
    else if(GetIsObjectValid(oItem))
    {
        if(GetLevelByClass(CLASS_TYPE_SHIFTER,oPC)>1)
        {
         if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Shifter Self Heal Enabled. Useable by the Player Tool 6 Feat.</c>");
         AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_06),oItem);
        }
    }
}
void MothUpdateIgnorePain(object oPC, int nDisplayFeedback = TRUE)
{
    if(GetRacialType(oPC)!= RACIAL_TYPE_HALFORC || !GetIsObjectValid(oPC))
    {
    return;
    }
    object oItem = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if(!GetIsObjectValid(oItem))
    {
        if(!GetLocalInt(oPC, "INVENTORY_FULL"))
        {
            //if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] No Hide Found! Attempting to reapply!</c>");
            MothAddNewSkin(oPC);
            DelayCommand(2.0,MothReApplyPCHide(oPC));
            DelayCommand(5.0,MothUpdateIgnorePain(oPC));
        }
        return;
    }
    else if(GetIsObjectValid(oItem))
    {
     if(nDisplayFeedback) SendMessageToPC(oPC,"<cеее>[Server] Gruumsh Hand Ability Enabled. Useable by the Player Tool 8 Feat.</c>");
    }
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_PLAYER_TOOL_08),oItem);
}
void MothUpdateHideFeats(object oPC, int nDisplayFeedback = TRUE)
{
    if(GetIsPolymorphed(oPC) || !GetIsObjectValid(oPC)) //J. Persinne; this line prevents infinite hides spawning in some situations, as well as "memory leaks".
        return;
    DelayCommand(1.5,MothUpdateBardSlots(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdateDruidSlots(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdatePaladinSlots(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdateRangerSlots(oPC, nDisplayFeedback));
    //DelayCommand(1.5,MothUpdateRDDHide(oPC));
    DelayCommand(1.5,MothUpdateShifterHide(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdateFighterPerfectHealth(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdateIgnorePain(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdateFighterThreadOfLife(oPC, nDisplayFeedback));
    DelayCommand(1.5,MothUpdateFighterChargeBullrush(oPC, nDisplayFeedback));
    DelayCommand(1.7,MothUpdateFighterChargeTornado(oPC, nDisplayFeedback));
    DelayCommand(1.9,MothUpdateFighterThrustTornado(oPC, nDisplayFeedback));
    DelayCommand(2.0,MothGetIsPureCasterForSlots(oPC, nDisplayFeedback));

}
//Returns TRUE if oPC is disabled
int MothGetIsDisabledShifter(object oPC)
{
    effect eBad = GetFirstEffect(oPC);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_PETRIFY ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEGHOST ||
            GetEffectType(eBad) == EFFECT_TYPE_SLEEP ||
            GetEffectType(eBad) == EFFECT_TYPE_TIMESTOP ||
            GetEffectType(eBad) == EFFECT_TYPE_TURNED ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
        {
         return TRUE;
        }
        eBad = GetNextEffect(oPC);
    }
  return FALSE;
}
//Returns TRUE if oPC is disabled
int MothGetIsDisabledShifterHeal(object oPC)
{
    effect eBad = GetFirstEffect(oPC);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_PETRIFY ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEGHOST ||
            GetEffectType(eBad) == EFFECT_TYPE_SLEEP ||
            GetEffectType(eBad) == EFFECT_TYPE_TIMESTOP ||
            GetEffectType(eBad) == EFFECT_TYPE_TURNED ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
        {
         return TRUE;
        }
        eBad = GetNextEffect(oPC);
    }
  return FALSE;
}
int MothGetIsDisabled(object oPC)
{
    effect eBad = GetFirstEffect(oPC);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_PETRIFY ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEGHOST ||
            GetEffectType(eBad) == EFFECT_TYPE_POLYMORPH ||
            GetEffectType(eBad) == EFFECT_TYPE_SLEEP ||
            GetEffectType(eBad) == EFFECT_TYPE_TIMESTOP ||
            GetEffectType(eBad) == EFFECT_TYPE_TURNED ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
        {
         return TRUE;
        }
        eBad = GetNextEffect(oPC);
    }
  return FALSE;
}
int MothGetIsAssociate(object oTarget)
{
  if (GetAssociateType(oTarget)==ASSOCIATE_TYPE_NONE)
  {
  return FALSE;
  }
  else return TRUE;
}
void MothApplyStormwalker(object oTarget, effect eLink, effect eVis, int nDuration, int nSpell)
{
  RemoveEffectsFromSpell(oTarget, nSpell);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration+5));
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
void MothApplyStormwalkerAlly(object oTarget, effect eBeam, effect eLink, effect eVis, int nDuration, int nSpell)
{
  RemoveEffectsFromSpell(oTarget, nSpell);
  effect eImmune = EffectSpellImmunity(SPELL_ICE_STORM);
  DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, 2.0));
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmune, oTarget, RoundsToSeconds(nDuration+5));
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration+5));
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
void MothRemoveTimestopped(object oTarget)
{
   DelayCommand(7.5,SetCommandable(TRUE,oTarget));
   DelayCommand(8.0,SetCommandable(TRUE,oTarget));
}
//void main(){}
