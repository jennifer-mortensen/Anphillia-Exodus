// Include script for some of the functions added by me.
// Created to make tweaking easier.
// Be sure to dig in all Moth_Inc_* scripts.
// ----------------------------------------------------
#include "moth_inc_depop"
// * Get the DC to save against for a spell on Moth's Anphillia (10 + spell level + relevant ability
// bonus).  This can be called by a creature. For persistant Area of Effect-spells, use MothFogDC().
// The base of 10 will increase with +1 for every Greater Wisdom,Intelligene,Charisma feats
// passed IV to a maximum of 6 extra points to the DC. If multiclasses, the bonuses will be invalid.
// Works with MothGetCasterLevel so the DC bonuses applies to RDD and PM's when
// they cast their class custom spells.
// For Fogs or other presistant AoE's, use MothFogDC().
int MothDC();
// * Works like MothDC(), but for persistant AoE spells.
int MothFogDC();
// * A wrapper that gives RDD and Pale Masters their respected levels
// to Fire based spells & Dispel/Breach spells(RDD)
// or Necromancy(PM) school-based spells.
int MothGetCasterLevel(object oCreature, int iSpell = 0);
// * Returns the type of spell.
//Values are: 1 = spell, 2 = spell-like ability, 3 = feat, 4 = special
int MothGetSpellType(int nSpell);
// * Returns TRUE if oTarget is friends with oCaster.
// Works on both NPC's and PC's and does not require
// them to be in a Party to be a friend.
// Else it returns FALSE.
int MothGetIsFortAlly(object oTarget, object oCaster=OBJECT_SELF);
// * Returns the SPELL_SCHOOL_* of nSpell.
// Will only work inside a spell-script or an ability listed in 'spells.2da'.
// Returns SPELL_SCHOOL_GENERAL if no school can be found.
int MothGetSpellSchool(int nSpell=SPELL_SCHOOL_GENERAL);
// * Check to see if the spell is a spell-like ability.
// Returns TRUE if the spell doesn't use a concentration check
// Use the Concentration switch to see if the "spell" is a real spell an not some special ability.
int MothGetIsSpellAbility(int nSpell);
// * Returns the Innate level of a spell. On no value, returns -1.
int MothGetSpellLevel(int nSpell);
// * Returns FALSE if oPlayer is Multiclassed.
// Determands if oPlayer is Pure in its class, meaning no Multiclassing.
// Use CLASS_TYPE_* to establish the Class to compare with HitDice (Total Levels).
int MothGetIsPureClass(int nClass, object oPlayer=OBJECT_SELF);
// * Returns TRUE if oPlayer has EPIC_FEAT_GREAT_*_5 or above.
// nAbility need to be ABILITY_INTELLIGENCE, ABILITY_CHARISMA or ABILITY_WISDOM.
int MothGetHasGreatAbility(int nAbility, object oPlayer=OBJECT_SELF);
// * Prevents presistant AoE objects to be stacked.
// Also prevents Persistant AoE from being created in No PvP areas.
int MothGetIsAoEAtTargetlocation(object oCaster, location lTarget, int nSphere=SHAPE_SPHERE, float fSize=5.0);
// * A wrapper of HasItem. Checks if oCreature has sItem in their inventory
//or in an equippment slot. Please note that while Polymorphed, a PC's items
//end up in Limbo and won't return in this loop.
int MothHasItem(object oCreature, string sItem);
// * Returns TRUE if the nSpell's Hostile Setting is 1 (hostile).
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellHostile(int nSpell);
// * Returns the type of spell. Values are: 1 = spell, 2 = spell-like ability, 3 = feat, 4 = special
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetSpellType(int nSpell);
// * Returns TRUE if nSpell is a Spell.
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetSpellTypeSpell(int nSpell);
// * Returns TRUE if nSpell is a Spell-like Ability.
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetSpellTypeSpellAbility(int nSpell);
// * Returns TRUE if nSpell is a Feat Ability.
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetSpellTypeFeat(int nSpell);
// * Returns TRUE if nSpell is a Special Ability.
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetSpellTypeSpecial(int nSpell);
// * Returns TRUE if the spell is of Necromancy School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolNecromancy(int nSpell);
// * Returns TRUE if the spell is of Abjuration School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolAbjuration(int nSpell);
// * Returns TRUE if the spell is of Evocation School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolEvocation(int nSpell);
// * Returns TRUE if the spell is of Enchantment School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolEnchantment(int nSpell);
// * Returns TRUE if the spell is of Conjuration School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolConjuration(int nSpell);
// * Returns TRUE if the spell is of Transmutation School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolTransmutation(int nSpell);
// * Returns TRUE if the spell is of Divination School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolDivination(int nSpell);
// * Returns TRUE if the spell is of Illusion School
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetIsSpellSchoolIllusion(int nSpell);
// * Returns the SPELL_SCHOOL_* of the casted spell.
//Don't use Constant Int's, use row numbers from Spells.2da instead.GetSpellId() will work.
int MothGetSpellSchool(int nSpell);
// * A wrapper that opens a store with an bonus of max 8.6%.
// 1% for each 5 points of Appraise.
void MothOpenStore(object oStore, object oPC, int nBonusMarkUp = 0, int nBonusMarkDown = 0);
// * Checks to see if the Autoboot on PC's with pocketing skill is on.
// If so, the get frozen and booted.
void MothPPCheck(object oPC, object oMod);
// * Kicks PC if they level up and got PP-skill points.
void MothPPLevel(object oPC);
// * Checks to see if the player logging on has been previously temp-banned
// with the HCR-wand and if so, boots them again
void MothBanWandCheck(object oPC, object oMod);
// * Gives the PC the lastest journal entires.
void MothGiveJournal(object oPC);
// * Makes sure that as long as the subrace field is empty, the player doesn't
// get a +2 to ECL from subrace.
int MothGetPlayerLevel (object oPC);
// * Gives NPCs permanent buffs and visual effects.
//Used in OnSpawn.
void MothGiveNPCBuff(object oTarget=OBJECT_SELF,int nRegen=TRUE,int nAB=FALSE,int nSeeInvis=FALSE,int nSR40=FALSE,int nSR44=FALSE,int nGlowRed=FALSE,int nGlowGrey=FALSE,int nGlowBrown=FALSE,int nPositiveDmg=FALSE,int nAcidDmg=FALSE,int nAC=FALSE);
// * Set the alignment of oSubject to a specific alignment
//without changing the alignment for partymembers.
void MothSetAlignment(object oSubject,int nLawChaos,int nGoodEvil);
// * Returns TRUE if oPet belongs to oMaster.
int MothGetIsTargetMyPet(object oMaster, object oPet);
// * Sets which Faction (Axfell or Cleaven) oPC belongs to.
void MothSetFactionInt(object oPC);
// * Respawns a door and closes it.
void MothRespawnGate(object oGate);
// * Returns TRUE if the spell is a real spell and of necromancy school.
//Used with MothSetIsPMCaster to establish if a PM should ignore SR for necrospells.
int MothIsSpellRealNecromancySpell(int nSpell);
// * Call at Login, Death and Level Up to see if the Player is a PM Caster.
//Also the PC needs Epic Spell Penetration Feat for this to return TRUE.
void MothSetIsPMCaster(object oPC);
// * Returns TRUE if the oDeadman is in either Fugue Plane.
int MothGetIsInFugue(object oDeadman);
// * Returns TRUE if oTarget has the specified Domain
int MothHasClericDomain(object oTarget,int nDomain);
// * Gets the exact facing and returns it as a Text Message to oUser.
void MothGetDirection(float fFacing, object oUser, object oTarget);
// * Returns the race of oTarget as a text string.
string MothGetRace(object oTarget);
// * Returns TRUE if oPlayer is in a Orb world. Scans for an object
// called MOTHORBWORLD, so Orb-areas must contain one such object -
// Preferably a waypoint.
int MothGetIsOrbWorld(object oPlayer);
// * Returns a random Poison
int MothGetPoison();
// * Returns a random Disease
int MothGetDisease();
// * Returns TRUE if oTarget is an NPC and an ally to oCaster
int MothGetIsFriendlyNPC(object oCaster, object oTarget);
// * Removes any Polymorph effect from oPC.
void MothRemovePolymorph(object oPC);
// * Returns TRUE if oArea is a No PvP area.
// Must be manually updated as new No PvP areas are added.
int MothGetIsNoPvPArea(object oArea);
int MothGetIsNoPvPArea1(object oArea);
// * Returns TRUE if the nSphere of a radius of fSize is clear of ANY objects.
int MothGetIsLocationClear(object oCaster,location lTarget, int nSphere=SHAPE_SPHERE, float fSize=4.0);



//Used for Noah's Custom Dispell Script
void SetLocalArrayInt(object oidObject, string sVarName, int nVarNum, int nValue);
int GetLocalArrayInt(object oidObject, string sVarName, int nVarNum);
int GetIsAlreadyFailed(object oTarget, int nSpellEffect, int nFailed);
void DeleteFailedDispelArray(object oTarget, int nFailed);
void noahRemoveEffect(int nEffectSpell);

// autoclosing of doors and gates delay
const float fDoorCloseDelay = 6.0;
// delay on the axfell and cleaven gate to respawn
const float fGateRespawnTime = 3600.0;

void ApplySpellLocalInt(object oTarget, object oCaster, int nSpell)
{
    int iTargetIsPC = GetIsPC(oTarget);
    int nSpellLevel;
    string sSpellName;

    if(iTargetIsPC){
       nSpellLevel = MothGetCasterLevel(oCaster);
       sSpellName = Get2DAString("spells", "Label", nSpell);

       SetLocalInt(oTarget, IntToString(nSpell), nSpellLevel);

    }
}
//noah's new dispel function
void NoahDispelMagicAll(int nDispellerLevel, object oTarget)
{
    object oCaster;
    effect eCurrentEffect;
    int nEffectSpell;
    int nEffectLevel;
    int nEffectSubtype;

    int nDiceRoll;
    int nDC;

    int nFailed = 1;
    int nIsAlreadyFailed;

    string sEffectSpellName;

    oCaster = GetLastSpellCaster();

    string dispelEffects = "<c þþ>Dispelled Effects:</c><c¥ ¥> ";
    string effectsDispelled = "<c þþ>Effects Dispelled:</c><c¥ ¥> ";



    int iHitDice = GetHitDice(OBJECT_SELF);
    int iPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
    int iRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,OBJECT_SELF);
    int iCaster = MothGetCasterLevel(OBJECT_SELF);
    iCaster=iPM+iRDD+iCaster;
    if(iHitDice>iCaster){}
    else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_10,OBJECT_SELF)||
             GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_10,OBJECT_SELF)||
             GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_10,OBJECT_SELF))
    {
        nDispellerLevel+=6;
    }
    else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_9,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_9,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_9,OBJECT_SELF))
    {
        nDispellerLevel+=5;
    }
    else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_8,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_8,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_8,OBJECT_SELF))
    {
        nDispellerLevel+=4;
    }
    else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_7,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_7,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_7,OBJECT_SELF))
    {
        nDispellerLevel+=3;
    }
    else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_6,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_6,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_6,OBJECT_SELF))
    {
        nDispellerLevel+=2;
    }
    else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_5,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_5,OBJECT_SELF) ||
             GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_5,OBJECT_SELF))
    {
        nDispellerLevel+=1;
    }


    eCurrentEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eCurrentEffect)){
        nEffectSpell = GetEffectSpellId(eCurrentEffect);
        nEffectSubtype = GetEffectSubType(eCurrentEffect);
        sEffectSpellName = GetStringByStrRef(StringToInt(Get2DAString("spells", "Name", nEffectSpell)));

        //only dispel the spell if it is valid, not supernatural, and not already attempted
        nIsAlreadyFailed = GetIsAlreadyFailed(oTarget, nEffectSpell, nFailed);
        if(nEffectSpell != -1 && nIsAlreadyFailed == FALSE){
           nEffectLevel = GetLocalInt(oTarget, IntToString(nEffectSpell));

           if(nEffectLevel!=0 && nEffectSubtype!=SUBTYPE_SUPERNATURAL && nEffectSubtype != SUBTYPE_EXTRAORDINARY){
               //now we can perform the dispel check on this effect
               nDiceRoll = d100();


               nDC = nDispellerLevel - nEffectLevel;

               if(nDC < 5)
               {
                    nDC = 5;
               }


               if(nDiceRoll <= nDC && nDiceRoll < 96){
                   //Due to spells that create both visual and physical effects, I need to run through
                   //all effects again and remove each one associated with nEffectSpell
                   AssignCommand(oTarget, noahRemoveEffect(nEffectSpell));
                   dispelEffects = dispelEffects + sEffectSpellName + ", ";
                   effectsDispelled= effectsDispelled + sEffectSpellName + ", ";
               }

               //if the dispeller fails to dispel the first effect encountered of a spell, then he must not attempt to dispel the other effects of that spell.
               //to do this i will keep an array for the duration of the dispel script that will keep track of any nEffectSpell that was failed to dispel.
               SetLocalArrayInt(oTarget, "faileddispelarray", nFailed, nEffectSpell);
               nFailed++;

           }
        }

        eCurrentEffect = GetNextEffect(oTarget);
    }
     SendMessageToPC(OBJECT_SELF, dispelEffects + "</c>");
     SendMessageToPC(oTarget, effectsDispelled + "</c>");
    DeleteFailedDispelArray(oTarget, nFailed);
}


void noahRemoveEffect(int nEffectSpell)
{
    //Due to spells that create both visual and physical effects, I need to run through
    //all effects again and remove each one associated with nEffectSpell
    effect eCurrentEffectRemoveLoop = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eCurrentEffectRemoveLoop)){
        if(GetEffectSpellId(eCurrentEffectRemoveLoop) == nEffectSpell){
            RemoveEffect(OBJECT_SELF, eCurrentEffectRemoveLoop);
        }
        eCurrentEffectRemoveLoop = GetNextEffect(OBJECT_SELF);
    }

}

int GetLocalArrayInt(object oidObject, string sVarName, int nVarNum)
{
    string sFullVarName = sVarName + IntToString(nVarNum) ;
    return GetLocalInt(oidObject, sFullVarName);
}

void SetLocalArrayInt(object oidObject, string sVarName, int nVarNum, int nValue)
{
    string sFullVarName = sVarName + IntToString(nVarNum) ;
    SetLocalInt(oidObject, sFullVarName, nValue);
}


//this is just for use with NoahDispelMagicAll
int GetIsAlreadyFailed(object oTarget, int nSpellEffect, int nFailed)
{
    int nLoop;
    int nAlreadyFailed = FALSE;
    for (nLoop=1; nLoop<=nFailed; nLoop++)
    {
          if(GetLocalArrayInt(oTarget, "faileddispelarray", nLoop) == nSpellEffect){
              nAlreadyFailed = TRUE;
          }
    }
    return nAlreadyFailed;
}

void DeleteFailedDispelArray(object oTarget, int nFailed)
{
    string sFullVarName;
    int nLoop;
    for (nLoop=1; nLoop<=nFailed; nLoop++){
        sFullVarName = "faileddispelarray" + IntToString(nLoop);
        DeleteLocalInt(oTarget, sFullVarName);
    }
}
int MothGetIsFortAlly(object oTarget, object oCaster=OBJECT_SELF)
{
    if(GetIsReactionTypeFriendly(oTarget,oCaster) || GetFactionEqual(oTarget,oCaster) ||
       GetIsReactionTypeNeutral(oTarget,oCaster))
       {
        return TRUE;
       }
  else return FALSE;
}
// Handles the timebased XP without any idle-checks in OnModuleLoad-script.
// Depending on server latency it will give the stated XP amount twice per
// specified hour. 25 means disabled.
// The strings should be tags of areas you dont want the PC to get any time XP in.
// Leave the strings "EMPTY" to not activate them.
// In this case below, it will give 200(+200) each time the clock is 12:00-12:59
// unless the PC is in A Dream-area(auto-excluded).
void MothGiveTimeXPSettings(object oMod)
{
       int nXP=200;
       int nHourToGive1=12;
       int nHourToGive2=25;
       int nHourToGive3=25;
       int nHourToGive4=25;
       string sAreaToExclude1="ADream_ud";
       string sAreaToExclude2="EMPTY";
       string sAreaToExclude3="EMPTY";
       string sAreaToExclude4="EMPTY";
       string sAreaToExclude5="EMPTY";
       SetLocalInt(oMod,"MothXpAmount",nXP);
       SetLocalInt(oMod,"MothXPHour1",nHourToGive1);
       SetLocalInt(oMod,"MothXPHour2",nHourToGive2);
       SetLocalInt(oMod,"MothXPHour3",nHourToGive3);
       SetLocalInt(oMod,"MothXPHour4",nHourToGive4);
       SetLocalString(oMod,"MothXpArea1",sAreaToExclude1);
       SetLocalString(oMod,"MothXpArea2",sAreaToExclude2);
       SetLocalString(oMod,"MothXpArea3",sAreaToExclude3);
       SetLocalString(oMod,"MothXpArea4",sAreaToExclude4);
       SetLocalString(oMod,"MothXpArea5",sAreaToExclude5);
}
// A wrapper of HasItem
int MothHasItem(object oCreature, string sItem)
{
    return  GetIsObjectValid(GetItemPossessedBy(oCreature, sItem));
}
//Returns the Innate level of a spell. On no value, returns -1.
int MothGetSpellLevel(int nSpell)
{
    string sSpellName = Get2DAString("spells", "Innate", nSpell);
    int nSpellLevel = StringToInt(sSpellName);
    if(nSpellLevel < 0)
    {
     return -1;
    }
   return nSpellLevel;
}
//Returns TRUE if the nSpell's Hostile Setting is 1 (hostile).
int MothGetIsSpellHostile(int nSpell)
{
    string sSpellSetting = Get2DAString("spells", "HostileSetting", nSpell);
    int nSpellSetting = StringToInt(sSpellSetting);
    if(nSpellSetting == 1)
    {
     return TRUE;
    }
   return FALSE;
}
//Returns the type of spell. Values are: 1 = spell, 2 = spell-like ability, 3 = feat, 4 = special
int MothGetSpellType(int nSpell)
{
    string sIsASpell = Get2DAString("spells", "UserType", nSpell);
    int nIsASpell = StringToInt(sIsASpell);
    return nIsASpell;
}
int MothGetSpellTypeSpell(int nSpell)
{
    string sIsASpell = Get2DAString("spells", "UserType", nSpell);
    int nIsASpell = StringToInt(sIsASpell);
    if(nIsASpell == 1)
    {
     return TRUE;
    }
   else return FALSE;
}
int MothGetSpellTypeSpellAbility(int nSpell)
{
    string sIsASpell = Get2DAString("spells", "UserType", nSpell);
    int nIsASpell = StringToInt(sIsASpell);
    if(nIsASpell == 2)
    {
     return TRUE;
    }
   else return FALSE;
}
int MothGetSpellTypeFeat(int nSpell)
{
    string sIsASpell = Get2DAString("spells", "UserType", nSpell);
    int nIsASpell = StringToInt(sIsASpell);
    if(nIsASpell == 3)
    {
     return TRUE;
    }
   else return FALSE;
}
int MothGetSpellTypeSpecial(int nSpell)
{
    string sIsASpell = Get2DAString("spells", "UserType", nSpell);
    int nIsASpell = StringToInt(sIsASpell);
    if(nIsASpell == 4)
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Necromancy School
int MothGetIsSpellSchoolNecromancy(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "N")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Abjuration School
int MothGetIsSpellSchoolAbjuration(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "A")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Evocation School
int MothGetIsSpellSchoolEvocation(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "V")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Enchantment School
int MothGetIsSpellSchoolEnchantment(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "E")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Conjuration School
int MothGetIsSpellSchoolConjuration(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "C")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Transmutation School
int MothGetIsSpellSchoolTransmutation(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "T")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Divination School
int MothGetIsSpellSchoolDivination(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "D")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns TRUE if the spell is of Illusion School
int MothGetIsSpellSchoolIllusion(int nSpell)
{
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "I")
    {
     return TRUE;
    }
   else return FALSE;
}
//Returns the SPELL_SCHOOL_* of the casted spell.
int MothGetSpellSchool(int nSpell)
{
    int nMothGetSpellSchool = SPELL_SCHOOL_GENERAL;
    string sSpellName = Get2DAString("spells", "School", nSpell);
    if(sSpellName == "I")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_ILLUSION;
    }
    else if(sSpellName == "D")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_DIVINATION;
    }
    else if(sSpellName == "T")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_TRANSMUTATION;
    }
    else if(sSpellName == "C")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_CONJURATION;
    }
    else if(sSpellName == "E")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_ENCHANTMENT;
    }
    else if(sSpellName == "V")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_EVOCATION;
    }
    else if(sSpellName == "A")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_ABJURATION;
    }
    else if(sSpellName == "N")
    {
     nMothGetSpellSchool=SPELL_SCHOOL_NECROMANCY;
    }
  return nMothGetSpellSchool;
}
//Adjusts Caster levels for PM's and RDD's
int MothGetCasterLevel(object oCreature, int iSpell=0)
{
     if(iSpell == 0)
     {
     iSpell = GetSpellId();
     }
     int iMothGetCasterLevel = GetCasterLevel(oCreature);
     //int iRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oCreature);
     int iPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,oCreature);
     if (iPM >=1)
     {
         if(MothGetIsSpellSchoolNecromancy(iSpell)==TRUE)
            {
             iMothGetCasterLevel+=iPM;
             return iMothGetCasterLevel;
            }
     }
     //if (iRDD >=1)
     //{
     //    if(MothGetIsSpellSchoolEvocation(iSpell)==TRUE)
     //       {
     //        iMothGetCasterLevel+=iRDD;
     //        return iMothGetCasterLevel;
     //       }
     //}
     return iMothGetCasterLevel;
}
// A wrapper that opens a store with an bonus of max 14.3%.
// 1% for each 3 points of Appraise.
void MothOpenStore(object oStore, object oPC, int nBonusMarkUp = 0, int nBonusMarkDown = 0)
{
    string sTag = ObjectToString(OBJECT_SELF);
    int nAppraise = GetSkillRank(SKILL_APPRAISE, oPC,TRUE)/3;
    nBonusMarkUp = nBonusMarkUp - nAppraise;
    nBonusMarkDown = nBonusMarkDown + nAppraise;
    string sBonusMarkDown = IntToString(nBonusMarkDown);

    if(GetTag(oStore) == "STORE_Banker")
    {
        nBonusMarkUp = 0;
        nBonusMarkDown = 0;
    }else{
        FloatingTextStringOnCreature("<cðøþ>Appraise grants you a " + sBonusMarkDown + " % bonus.</c>",oPC,FALSE);
    }

    OpenStore(oStore, oPC, nBonusMarkUp, nBonusMarkDown);
}
int MothDC()
{
     int iMothDC = GetSpellSaveDC();
     if(GetSpellCastItem() != OBJECT_INVALID)
        return iMothDC;
     int iHitDice = GetHitDice(OBJECT_SELF);
     int iPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
     int iCaster = MothGetCasterLevel(OBJECT_SELF);
     int nNecromancy = MothGetIsSpellSchoolNecromancy(GetSpellId());
     if(nNecromancy) //J. Persinne; PMs no longer get DC bonuses for non-necromantic spells.
        iCaster=iPM+iCaster;
     if(iHitDice>iCaster){return iMothDC;}
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_10,OBJECT_SELF)||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_10,OBJECT_SELF)||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_10,OBJECT_SELF))
              {
              iMothDC+=6;
              }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_9,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_9,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_9,OBJECT_SELF))
             {
              iMothDC+=5;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_8,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_8,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_8,OBJECT_SELF))
             {
              iMothDC+=4;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_7,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_7,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_7,OBJECT_SELF))
             {
              iMothDC+=3;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_6,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_6,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_6,OBJECT_SELF))
             {
              iMothDC+=2;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_5,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_5,OBJECT_SELF) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_5,OBJECT_SELF))
             {
              iMothDC+=1;
             }
     object oEpicPMSummon = GetLocalObject(OBJECT_SELF, "PALE_MASTER_EPIC_SUMMON");
     float fDistance = GetDistanceToObject(oEpicPMSummon);
     //J. Persinne; Palemasters now gain a +3 DC bonus to their necromancy spells while they are near their dragonflesh summon.
     if(fDistance != -1.0 && fDistance <= 20.0 && nNecromancy)
     {
        iMothDC += 3;
     }
     iMothDC += 2; //J. Persinne; +2 DC bonus for all pure casters.
     return iMothDC;
}
int MothFogDC()
{
     int iMothDC = GetSpellSaveDC();
     if(GetSpellCastItem() != OBJECT_INVALID)
        return iMothDC;
     object oCaster = GetAreaOfEffectCreator();
     int iHitDice = GetHitDice(oCaster);
     int iPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,OBJECT_SELF);
     int iCaster = MothGetCasterLevel(OBJECT_SELF);
     int nNecromancy = MothGetIsSpellSchoolNecromancy(GetSpellId());
     if(nNecromancy) //J. Persinne; PMs no longer get DC bonuses for non-necromantic spells.
        iCaster=iPM+iCaster;
     if(iHitDice>iCaster){return iMothDC;}
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_10,oCaster)||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_10,oCaster)||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_10,oCaster))
              {
              iMothDC+=6;
              }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_9,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_9,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_9,oCaster))
             {
              iMothDC+=5;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_8,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_8,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_8,oCaster))
             {
              iMothDC+=4;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_7,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_7,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_7,oCaster))
             {
              iMothDC+=3;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_6,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_6,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_6,oCaster))
             {
              iMothDC+=2;
             }
     else if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_5,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_5,oCaster) ||
              GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_5,oCaster))
             {
              iMothDC+=1;
             }
     object oEpicPMSummon = GetLocalObject(OBJECT_SELF, "PALE_MASTER_EPIC_SUMMON");
     float fDistance = GetDistanceToObject(oEpicPMSummon);
     //J. Persinne; Palemasters now gain a +3 DC bonus to their necromancy spells while they are near their dragonflesh summon.
     if(fDistance != -1.0 && fDistance <= 20.0 && nNecromancy)
     {
        iMothDC += 3;
     }
    iMothDC += 2; //J. Persinne; +2 DC bonus for all pure casters.
     return iMothDC;
}
// Checks to see if the Autoboot on PC's with pocketing skill is on.
// If so, the get frozen and booted.
// ______________________________________
// Not used with the changes to Skill.2da.
void MothPPCheck(object oPC, object oMod)
{
    /*if(GetLocalInt(oMod,"PPAutoBoot")==FALSE)
    {
        if(GetSkillRank(SKILL_PICK_POCKET,oPC,TRUE)>=1 && GetIsPC(oPC) && !GetIsDM (oPC))
        {
            DelayCommand(4.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Pick Pocketing-Skill Points Detected. You will be booted in 10 seconds. Contact a DM on the Forums for any questions.</c>"));
            DelayCommand(14.0,BootPC(oPC));
            effect eFreeze = EffectCutsceneParalyze();
            eFreeze = SupernaturalEffect(eFreeze);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFreeze,oPC);
        }
    }*/
}
// Kicks PC if they level up and got PP-skill points.
// ______________________________________
// Not used with the changes to Skill.2da.
void MothPPLevel(object oPC)
{
   /* if(GetSkillRank(SKILL_PICK_POCKET,oPC,TRUE)>=1)
    {
        DelayCommand(4.0,SendMessageToPC(oPC,"<cÜ>*Pick Pocketing-Skill Points Detected. You will be booted in 10 seconds. Contact a DM on the Forums for any questions.*"));
        DelayCommand(14.0,BootPC(oPC));
        effect eFreeze = EffectCutsceneParalyze();
        eFreeze = SupernaturalEffect(eFreeze);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFreeze,oPC);
    }*/
}
// Checks to see if the player logging on has been previously temp-banned
// with the HCR-wand and if so, boots them again
void MothBanWandCheck(object oPC, object oMod)
{
    if(GetLocalInt(oMod,"BANNED"+GetPCPublicCDKey(oPC))==TRUE)
    {
     BootPC(oPC);
     return;
    }
}
// Gives the PC that logs on the lastest journal entires.
void MothGiveJournal(object oPC)
{
 if (GetLocalInt(oPC, "MothEntryOn")== FALSE)
    {
    AddJournalQuestEntry("Rules1", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("CharacterBuildRestrictions", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("Subraces", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Anphillianhistory1", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Anphillianhistory2", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Anphillianhistory3", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Anphillianhistory4", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Anphillianhistory5", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Anphillianhistory6", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("ATS", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("Rules3", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("Death", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("DMNote", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("ItemDamageImmunities", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("ChatCommands", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("ChatCommands2", 1, oPC, FALSE, FALSE, FALSE);
    AddJournalQuestEntry("AnphilliaForum", 1, oPC, FALSE, FALSE, FALSE);
    //AddJournalQuestEntry("Bulletin", 1, oPC, FALSE, FALSE, FALSE);

    SetLocalInt(oPC,"MothEntryOn",TRUE);
    }
}
// Makes sure that as long as the subrace field is empty, the player doesn't
// get a +2 to ECL from subrace.
int MothGetPlayerLevel (object oPC)
{
    int iLevel=0;
    iLevel = iLevel+2;
    iLevel += GetLevelByPosition (1, oPC);
    iLevel += GetLevelByPosition (2, oPC);
    iLevel += GetLevelByPosition (3, oPC);
    if(GetSubRace(oPC) == ""){iLevel = iLevel-2;}
    return (iLevel);
}
void MothDepopRun()
{
    int iCreatureLimit = 150;
    float fCreatureTime = 240.0;
    int nTotal;
    object oDepop;
    object oMod = GetModule();
    object oCreature = GetHeadLink("CREATURE");
    object oObject = GetObjectByTag ("temp_object");
    DelayCommand(fCreatureTime,MothDepopRun());
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        SetLocalInt (oObject, GetTag (GetArea (oPC)), 1);
        oPC = GetNextPC();
    }
    nTotal = GetLinkTotal ("CREATURE");
    while (nTotal > iCreatureLimit)
    {
        if(!GetLocalInt (oObject, GetTag (GetArea (oCreature))))
        {
            oDepop = oCreature;
            oCreature = GetNextLink (oCreature,"CREATURE");
            RemoveLink (oDepop, "CREATURE");
            DestroyObject (oDepop);
            nTotal--;
        }
        else
        {
            oCreature = GetNextLink (oCreature, "CREATURE");
        }
        if (!GetIsObjectValid (oCreature))
            break;
    }
    oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
        DeleteLocalInt (oObject, GetTag (GetArea (oPC)));
        oPC = GetNextPC();
    }
}
void MothDepopStart()
{
    MothDepopRun();
}
void MothDepopulate(object oDepopper)
{
   if(GetPlotFlag(oDepopper)){return;}
   if(!GetIsObjectValid(oDepopper)){return;}
   if(GetIsDead(oDepopper)){return;}
   if(GetDeity(oDepopper)=="MOTH"){return;}
   object oArea = GetArea(oDepopper);
   if(oArea == OBJECT_INVALID){return;}
   DestroyObject(oDepopper,1.0);
}
void MothDepopEnd(object oCreature)
{
    RemoveLink(oCreature, "CREATURE");
}
void MothDepop(object oTarget)
{
    int nLevel = GetHitDice(oTarget);
    float fRandom = IntToFloat(d10(4));
    float fDelayBase = 600.0;
    float fDelayBonus = IntToFloat(nLevel) * 45.0;
    float fDelay = fDelayBase+fDelayBonus+fRandom;
    if(GetAssociateType(oTarget) == ASSOCIATE_TYPE_NONE)
    {
    DelayCommand(fDelay,MothDepopulate(oTarget));
    }
    /*
    if(GetDeity(oTarget)=="MOTH"){return;}
    if(GetAssociateType(oTarget) != ASSOCIATE_TYPE_NONE){return;}
    if(GetPlotFlag(oTarget)){return;}
    if(GetSubRace(oTarget)=="")
    {
    AddLink(oTarget, "CREATURE");
    }*/

}
void MothGiveNPCBuffOn(object oTarget,
                     int nRegen,
                     int nAB,
                     int nSeeInvis,
                     int nSR40,
                     int nSR44,
                     int nGlowRed,
                     int nGlowGrey,
                     int nGlowBrown,
                     int nPositiveDmg,
                     int nAcidDmg,
                     int nAC
                     )
{
    //MothDepop(oTarget);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSavingThrowDecrease(SAVING_THROW_FORT,5,SAVING_THROW_TYPE_SPELL),oTarget);
    if(nRegen==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(1,9.0),oTarget);
    }
    if(nAB==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(5),oTarget);
    }
    if(nSeeInvis==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(),oTarget);
    }
    if(nSR40==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(40),oTarget);
    }
    if(nSR44==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(44),oTarget);
    }
    if(nGlowRed==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_LIGHT_RED),oTarget);
    }
    if(nGlowGrey==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_GREY),oTarget);
    }
    if(nGlowBrown==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_LIGHT_BROWN),oTarget);
    }
    if(nPositiveDmg==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_POSITIVE),oTarget);
    }
    if(nAcidDmg==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageIncrease(DAMAGE_BONUS_2d6,DAMAGE_TYPE_ACID),oTarget);
    }
    if(nAC==TRUE)
    {
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(4),oTarget);
    }
}
void MothGiveNPCBuff(object oTarget=OBJECT_SELF,
                     int nRegen=FALSE,
                     int nAB=FALSE,
                     int nSeeInvis=FALSE,
                     int nSR40=FALSE,
                     int nSR44=FALSE,
                     int nGlowRed=FALSE,
                     int nGlowGrey=FALSE,
                     int nGlowBrown=FALSE,
                     int nPositiveDmg=FALSE,
                     int nAcidDmg=FALSE,
                     int nAC=FALSE
                     )
{
    float fDelay = IntToFloat(d4(2));
    DelayCommand(fDelay,MothGiveNPCBuffOn(oTarget,nRegen,nAB,nSeeInvis,nSR40,nSR44,nGlowRed,nGlowGrey,nGlowBrown,nPositiveDmg,nAcidDmg,nAC));
}
// Sets an alignment of on PC only without effecting the Party
void MothAdjustAlignmentOnePCOnly(object oPC, int iAlignment, int iShift)
{
    object oPartyLeader = GetFirstFactionMember(oPC, TRUE);
        if(oPartyLeader == oPC)
        {
            oPartyLeader = GetNextFactionMember(oPC, TRUE);
            if(!GetIsObjectValid(oPartyLeader))
            {
                AdjustAlignment(oPC, iAlignment, iShift);
                return;
            }
        }
    RemoveFromParty(oPC);
        AdjustAlignment(oPC, iAlignment, iShift);
    AddToParty(oPC, oPartyLeader);
}
void MothSetAlignment(object oSubject,int nLawChaos,int nGoodEvil)
{
int nGE = GetGoodEvilValue(oSubject);
int nLC = GetLawChaosValue(oSubject);
    while (nGE != nGoodEvil || nLC != nLawChaos)
    {
        MothAdjustAlignmentOnePCOnly(oSubject, ALIGNMENT_CHAOTIC, nLC-nLawChaos);
        MothAdjustAlignmentOnePCOnly(oSubject, ALIGNMENT_EVIL, nGE-nGoodEvil);
        nGE = GetGoodEvilValue(oSubject);
        nLC = GetLawChaosValue(oSubject);
    }
}
// Handles mules and makes them reclaimable after a PC crash.
void MothHireMule(object oPC)
{
    location lSpawn = GetLocation(oPC);
    object oSpawn;
    if (MothHasItem(oPC, "axfellwarriorrin") == TRUE)
    {
        oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "axfellmule", lSpawn);
    }
    else
    {
        oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "cleavenmule", lSpawn);
    }
    AddHenchman(oPC, oSpawn);
    TakeGoldFromCreature(500,oPC, TRUE);

    SetLocalString(oSpawn, "mothmuleowner", GetName(oPC));
}
void MothHireEpicMule(object oPC)
{
    location lSpawn = GetLocation(oPC);
    object oSpawn;
    if (MothHasItem(oPC, "axfellwarriorrin") == TRUE)
    {
        oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "axfellmule2", lSpawn);
    }
    else
    {
        oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "cleavenmule2", lSpawn);
    }
    AddHenchman(oPC, oSpawn);
    TakeGoldFromCreature(10000,oPC, TRUE);

    SetLocalString(oSpawn, "mothmuleowner", GetName(oPC));
}
void MothKillMule(object oPC)
{
    DestroyObject(OBJECT_SELF);
    RemoveHenchman(oPC,OBJECT_SELF);
}
void MothRegainMule(object oPC)
{
    object oMule = OBJECT_SELF;
    AddHenchman(oPC, OBJECT_SELF);
}
//Tokens to make the Subrace conversation dynamic and COLORFUL! :)
void MothUpdateCustomToken(object oPC)
{
    string sRace ="Humans";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sRace="Dwarves";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sRace="Elves";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sRace="Gnomes";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sRace="Halfelves";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sRace="Halflings";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sRace="Halforcs";}
    string sSubRaceOne ="Aasimar";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sSubRaceOne="Duergar";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sSubRaceOne="Drow";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sSubRaceOne="Svirfneblin";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sSubRaceOne="Half-drow";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sSubRaceOne="Ghostwise";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sSubRaceOne="Orc";}
    string sSubRaceTwo ="Tiefling";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sSubRaceTwo="Shield Dwarf";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sSubRaceTwo="Moonelf";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sSubRaceTwo="Forest Gnome";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sSubRaceTwo="Half Moonelf";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sSubRaceTwo="Furchin";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sSubRaceTwo="Half-orge";}
    string sSubRaceThree ="N/A";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sSubRaceThree="N/A";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sSubRaceThree="N/A";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sSubRaceThree="N/A";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sSubRaceThree="N/A";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sSubRaceThree="N/A";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sSubRaceThree="Half-Troll";}
    string sSubRaceOneInfo ="The Aasimar gets +2 Strength and +3 Charisma. ECL is +2.";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sSubRaceOneInfo="The Duergar gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sSubRaceOneInfo="The Drow gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sSubRaceOneInfo="The Svirfneblin gets gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sSubRaceOneInfo="The Half-Drow gets gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sSubRaceOneInfo="The Ghostwise Halfling gets +3 Dexterity and +2 Intelligence. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sSubRaceOneInfo="The Orc gets +2 Consitution and +3 Strength. ECL is +2.";}
    string sSubRaceTwoInfo ="The Tiefling gets +2 Dexterity and +3 Intelligence. ECL is +2.";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sSubRaceTwoInfo="The Shield Dwarf gets +2 Consitution and +3 Strength. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sSubRaceTwoInfo="The Moonelf gets +2 Dexterity and +3 Intelligence. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sSubRaceTwoInfo="The Forest Gnome gets +2 Wisdom and +3 Charisma. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sSubRaceTwoInfo="The Half-Moonelf gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sSubRaceTwoInfo="The Furchin Halfling gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sSubRaceTwoInfo="The Half-Orge gets +3 Consitution and +2 Strength. ECL is +2.";}
    string sSubRaceThreeInfo ="Humans currently have no third Subrace.";
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF){sSubRaceThreeInfo="Dwarves currently have no third Subrace.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_ELF){sSubRaceThreeInfo="Elves currently have no third Subrace.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_GNOME){sSubRaceThreeInfo="Gnomes currently have no third Subrace.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF){sSubRaceThreeInfo="Half-elves currently have no third Subrace.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING){sSubRaceThreeInfo="Halflings currently have no third Subrace.";}
    else if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC){sSubRaceThreeInfo="The Half-Troll gets 22 Spellresistance plus one per 2 character levels. ECL is +2.";}
    SetCustomToken(102, sRace); //Base Race
    SetCustomToken(100, sSubRaceOne); //Subrace One
    SetCustomToken(101, sSubRaceTwo); // Subrace Two
    SetCustomToken(111, sSubRaceThree); // Subrace Three
    SetCustomToken(1001,sSubRaceOneInfo); //Subrace One Info
    SetCustomToken(1011,sSubRaceTwoInfo); // Subrace Two Info
    SetCustomToken(1021,sSubRaceThreeInfo); // Subrace Three Info
    SetCustomToken(104, "<c þþ>"); // Cyan
    SetCustomToken(105, "<cþ þ>"); // Magenta
    SetCustomToken(106, "<cþþ >"); // Yellow
    SetCustomToken(116, "<c  þ>"); // Blue
    SetCustomToken(107, "</c>"); // End the color tag
}
// Call at Login and Level Up to set the number of Shifter Levels on PC
// Good for abilities that are cast while in a Shape that should be based on Shifter Levels.
// Can be called at PC death too if the PC might delvl.
void MothSetShifterLevels(object oPC)
{
    int nShifterLevels = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
    if(nShifterLevels>1)
    {
     //Set Shifter Levels
     SetLocalInt(oPC,"MothShifterLevels",nShifterLevels);
    }
}
// Use to get the number of Shifter Levels. Can only be used if MothSetShifterLevels()
// is called at Login and preferably at PC Level Up/death/orb(respawn) too.
// In short, each time a PC will gain and possibly lose a level.
int MothGetShifterLevels(object oPC)
{
   int nLevel = GetLocalInt(oPC,"MothShifterLevels");
   return nLevel;
}
void MothShifterHeal(object oPC, int nShifterLevel)
{
    if(GetRacialType(oPC) == RACIAL_TYPE_UNDEAD){return;}
    int nWis = GetAbilityModifier(ABILITY_WISDOM);
    int nHeal = nShifterLevel*nWis;
    nHeal = nHeal + d20(7);
    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    int iTimer = GetLocalInt(oPC, "ShifterHealSpell");
    if (iTimer <2)
    {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    SetLocalInt(OBJECT_SELF, "ShifterHealSpell", iTimer);
    }
    else if (iTimer==2)
    {
    DelayCommand(0.7, FloatingTextStringOnCreature("<cðøþ>*Healing Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(oPC, "<c¥¥¥>[Server] Self-Healing Focus is lost.</c>"));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    SetLocalInt(oPC, "ShifterHealSpell", iTimer);
    }
    else if (iTimer >2)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Healing Focus!*</c>",oPC,FALSE);
    SendMessageToPC(oPC, "<c¥¥¥>[Server] You do not have enough Self-Healing focus right now.</c>");
    }
}
int MothGetIsNoPvPArea1(object oArea)
{
   if(GetTag(oArea)=="ADream_ud"||
      GetTag(oArea)=="DeadmansCrossing"||
      GetTag(oArea)=="AxfellFuguePlane"||
      GetTag(oArea)=="CleavenFuguePlane"||
      GetTag(oArea)=="HopeCanyonLamirs"||
      GetTag(oArea)=="Ranzington"||
      GetTag(oArea)=="RanzingtonChurchofTri"||
      GetTag(oArea)=="RanzingtonElevationTowerFloor1"||
      GetTag(oArea)=="RanzingtonElevationTowerFloor2"||
      GetTag(oArea)=="RanzingtonFloras"||
      GetTag(oArea)=="RanzingtonJewelry"||
      GetTag(oArea)=="RanzingtonLibrary"||
      GetTag(oArea)=="RanzingtonMagus"||
      GetTag(oArea)=="RanzingtonReldarsHouse"||
      GetTag(oArea)=="RanzingtonRoad"||
      GetTag(oArea)=="RanzingtonsSavingsandAccounts"||
      GetTag(oArea)=="RanzingtonTheAnphilliaChronicle"||
      GetTag(oArea)=="RanzingtonBlacksmith"||
      GetTag(oArea)=="RanzingtonTowerCouncilOpera"||
      GetTag(oArea)=="RanzingtonTowerMagicCouncilOper"||
      GetTag(oArea)=="RanzingtonTowerFloor1"||
      GetTag(oArea)=="RanzingtonTowerFloor2"||
      GetTag(oArea)=="RanzingtonTownHall"||
      GetTag(oArea)=="Ulwynels"||
      GetTag(oArea)=="RanzingtonTanner"||
      GetTag(oArea)=="GrandForestDruidsGrove"||
      GetTag(oArea)=="SerisIslandDarons"||
      GetTag(oArea)=="Area001"||
      GetTag(oArea)=="SeersHouse"||
      GetTag(oArea)=="Area002"||
      GetTag(oArea)=="AnphPersistenceMarker"||
      GetTag(oArea)=="HomeoftheGods"||
      GetTag(oArea)=="ATS_AREA_RESERVED"||
      GetTag(oArea)=="FuguePlane"||
      GetTag(oArea)=="mothordworld1"||
      GetTag(oArea)=="mothordworld2"||
      GetTag(oArea)=="mothordworld3"||
      GetTag(oArea)=="mothordworld4"||
      GetTag(oArea)=="mothordworld5"||
      GetTag(oArea)=="mothordworld6"||
      GetTag(oArea)=="mothordworld7"||
      GetTag(oArea)=="mothordworld8"||
      GetTag(oArea)=="mothordworld9"||
      GetTag(oArea)=="mothordworld10"||
      GetTag(oArea)=="mothordworld11"||
      GetTag(oArea)=="mothordworld12"||
      GetTag(oArea)=="mothordworld13"||
      GetTag(oArea)=="mothordworld14"||
      GetTag(oArea)=="mothordworld15"||
      GetTag(oArea)=="mothordworld16"||
      GetTag(oArea)=="mothordworld17"||
      GetTag(oArea)=="mothordworld18"||
      GetTag(oArea)=="mothordworld19"||
      GetTag(oArea)=="mothordworld20"||
      GetTag(oArea)=="mothordworld21"||
      GetTag(oArea)=="mothordworld22"||
      GetTag(oArea)=="mothordworld23"||
      GetTag(oArea)=="mothordworld24"||
      GetTag(oArea)=="mothordworld25"||
      GetTag(oArea)=="mothordworld26"||
      GetTag(oArea)=="mothordworld27"||
      GetTag(oArea)=="mothordworld28")
    {
     return TRUE;
    }
  else return FALSE;
}
int MothGetIsNoPvPArea(object oArea)
{
   string aArea = GetTag(oArea);
   if(aArea=="ADream_ud"||
      aArea=="DeadmansCrossing"||
      aArea=="AxfellFuguePlane"||
      aArea=="CleavenFuguePlane"||
      aArea=="HopeCanyonLamirs"||
      aArea=="Ranzington"||
      aArea=="RanzingtonChurchofTri"||
      aArea=="RanzingtonElevationTowerFloor1"||
      aArea=="RanzingtonElevationTowerFloor2"||
      aArea=="RanzingtonFloras"||
      aArea=="RanzingtonJewelry"||
      aArea=="RanzingtonLibrary"||
      aArea=="RanzingtonMagus"||
      aArea=="RanzingtonReldarsHouse"||
      aArea=="RanzingtonRoad"||
      aArea=="RanzingtonsSavingsandAccounts"||
      aArea=="RanzingtonTheAnphilliaChronicle"||
      aArea=="RanzingtonBlacksmith"||
      aArea=="RanzingtonTowerCouncilOpera"||
      aArea=="RanzingtonTowerMagicCouncilOper"||
      aArea=="RanzingtonTowerFloor1"||
      aArea=="RanzingtonTowerFloor2"||
      aArea=="RanzingtonTownHall"||
      aArea=="Ulwynels"||
      aArea=="RanzingtonTanner"||
      aArea=="GrandForestDruidsGrove"||
      aArea=="SerisIslandDarons"||
      aArea=="Area001"||
      aArea=="SeersHouse"||
      aArea=="Area002"||
      aArea=="AnphPersistenceMarker"||
      aArea=="HomeoftheGods"||
      aArea=="ATS_AREA_RESERVED"||
      aArea=="FuguePlane"||
      aArea=="mothordworld1"||
      aArea=="mothordworld2"||
      aArea=="mothordworld3"||
      aArea=="mothordworld4"||
      aArea=="mothordworld5"||
      aArea=="mothordworld6"||
      aArea=="mothordworld7"||
      aArea=="mothordworld8"||
      aArea=="mothordworld9"||
      aArea=="mothordworld10"||
      aArea=="mothordworld11"||
      aArea=="mothordworld12"||
      aArea=="mothordworld13"||
      aArea=="mothordworld14"||
      aArea=="mothordworld15"||
      aArea=="mothordworld16"||
      aArea=="mothordworld17"||
      aArea=="mothordworld18"||
      aArea=="mothordworld19"||
      aArea=="mothordworld20"||
      aArea=="mothordworld21"||
      aArea=="mothordworld22"||
      aArea=="mothordworld23"||
      aArea=="mothordworld24"||
      aArea=="mothordworld25"||
      aArea=="mothordworld26"||
      aArea=="mothordworld27"||
      aArea=="mothordworld28")
    {
     return TRUE;
    }
  else return FALSE;
}
int MothGetIsAoEAtTargetlocation(object oCaster, location lTarget, int nSphere=SHAPE_SPHERE, float fSize=5.0)
{
    object oTarget = GetFirstObjectInShape(nSphere, fSize, lTarget, TRUE,OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
    object oArea = GetArea(oCaster);
    int nObjectType;
    if(MothGetIsNoPvPArea(oArea))
    {
    return TRUE;
    }
    while (GetIsObjectValid(oTarget))
    {
        nObjectType = GetObjectType(oTarget);
        if (nObjectType == OBJECT_TYPE_AREA_OF_EFFECT)
        {
           string sAoE;
           sAoE = GetTag(oTarget);
           if (sAoE!="VFX_MOB_CIRCEVIL"&&
               sAoE!="VFX_MOB_CIRCGOOD"&&
               sAoE!="VFX_MOB_CIRCLAW"&&
               sAoE!="VFX_MOB_CIRCCHAOS"&&
               sAoE!="VFX_MOB_FEAR"&&
               sAoE!="VFX_MOB_BLINDING"&&
               sAoE!="VFX_MOB_UNEARTHLY"&&
               sAoE!="VFX_MOB_MENACE"&&
               sAoE!="VFX_MOB_UNNATURAL"&&
               sAoE!="VFX_MOB_STUN"&&
               sAoE!="VFX_MOB_PROTECTION"&&
               sAoE!="VFX_PER_WALLWIND"&&
               sAoE!="VFX_MOB_FIRE"&&
               sAoE!="VFX_MOB_FROST"&&
               sAoE!="VFX_MOB_ELECTRICAL"&&
               sAoE!="VFX_MOB_TYRANT_FOG"&&
               sAoE!="VFX_MOB_SILENCE"&&
               sAoE!="VFX_MOB_INVISIBILITY_PURGE"&&
               sAoE!="VFX_MOB_DRAGON_FEAR"&&
               sAoE!="VFX_MOB_BATTLETIDE")
            {
               return TRUE;
            }
            //else
            //{
            //   return FALSE;
            //}
        }
        else if(nObjectType == OBJECT_TYPE_PLACEABLE && GetTag(oTarget) == "X2_PLC_GLYPH")
        {
            return TRUE;
        }
        //else
        //{
        // return FALSE;
        //}
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE,OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
    }
return FALSE;
}
int MothGolemWalkImmunityLow(object oTarget)
{
  int nSpell = GetSpellId();
  if(GetLocalInt(oTarget,"MOTHGOLEMWALKINT"))
  {
    return TRUE;
  }
  else return FALSE;
}
int MothGolemWalkImmunityMedium(object oTarget)
{
  int nSpell = GetSpellId();
  if(GetLocalInt(oTarget,"MOTHGOLEMWALKINT")>20)
  {
    return TRUE;
  }
  else return FALSE;
}
int MothGolemWalkImmunityHigh(object oTarget)
{
  if(GetLocalInt(oTarget,"MOTHGOLEMWALKINT")>39)
  {
    return TRUE;
  }
  else return FALSE;
}
//Returns TRUE if oPet belongs to oMaster.
int MothGetIsTargetMyPet(object oMaster, object oPet)
{
  if(GetMaster(oPet)==oMaster)
  {
  return TRUE;
  }
  else return FALSE;
}
void MothSetFactionInt(object oPC)
{
    if (MothHasItem(oPC, "axfellwarriorrin"))
    {
        //DeleteLocalString(oPC,"MothSetFactionInt"); //J. Persinne, Feb. 11 2009; removed string deletion, as it was completely unnecessary.
        SetLocalString(oPC,"MothSetFactionInt","MothAxfellMember");
    }
    else if (MothHasItem (oPC, "cleavenmilitiari"))
    {
        //DeleteLocalString(oPC,"MothSetFactionInt");
        SetLocalString(oPC,"MothSetFactionInt","MothCleavenMember");
    }
}
void MothRespawnGate(object oGate)
{
    PlayAnimation(ANIMATION_DOOR_CLOSE);
    int nHP = GetMaxHitPoints(oGate) - GetCurrentHitPoints(oGate);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHP), oGate);
}
void MothDontStealDacksKey(object oPC)
{
    // Dack
    //----------------------------------
    // Stop Rann from using my cd-key
    //----------------------------------
    /*if(GetPCPublicCDKey(oPC) == "FTRE7N9K" && GetPCPlayerName(oPC) != "Dabalk"){
        BootPC(oPC);
    } */
}
void RemoveRelics(object oPC)
{
    object aRelic = GetItemPossessedBy(oPC, "axfellrelic");
    object cRelic = GetItemPossessedBy(oPC, "cleavenrelic");

    if (GetIsObjectValid (aRelic)){
        DestroyObject (aRelic);
    }
    if (GetIsObjectValid (cRelic)){
        DestroyObject (cRelic);
    }
}
//Returns TRUE if the spell is a real spell and of necromancy school.
//Used with MothSetIsPMCaster to establish if a PM should ignore SR for necrospells.
int MothIsSpellRealNecromancySpell(int nSpell)
{
  if(MothGetIsSpellSchoolNecromancy(nSpell))
  {
    if(!GetIsObjectValid(GetSpellCastItem()))
       {
       return TRUE;
       }
     else return FALSE;
  }
 return FALSE;
}
//Call at Login, Death and Level Up to see if the Player is a PM Caster.
//Also the PC needs Epic Spell Penetration Feat for this to return TRUE.
void MothSetIsPMCaster(object oPC)
{
   int nPM = GetLevelByClass(CLASS_TYPE_PALEMASTER,oPC);
   int nCaster = GetCasterLevel(oPC);
   if(nPM>nCaster &&
   GetHasFeat(FEAT_EPIC_SPELL_PENETRATION,oPC)
   )
   {
    SetLocalInt(oPC,"MOTHISPMCASTER",TRUE);
   }
   else
   {
    DeleteLocalInt(oPC,"MOTHISPMCASTER");
   }
}
//Returns TRUE if the oDeadman is in either Fugue Plane.
int MothGetIsInFugue(object oDeadman)
{
   if(GetTag(GetArea(oDeadman)) == "AxfellFuguePlane"||
      GetTag(GetArea(oDeadman)) == "CleavenFuguePlane"
     )
     {
     return TRUE;
     }
    else return FALSE;
}
//Returns TRUE if oTarget has the specified Domain
int MothHasClericDomain(object oTarget,int nDomain)
{
  if(GetHasFeat(nDomain,oTarget))
  {
   return TRUE;
  }
 return FALSE;
}
//Returns TRUE if oTarget should be allowed a blessing
int MothAllowSelfPrayer(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  MothHasClericDomain(oCaster,FEAT_GOOD_DOMAIN_POWER)
  )
  {
    return TRUE;
  }
  if(oTarget == oCaster &&
  GetLevelByClass(CLASS_TYPE_PALADIN,oCaster)>19||
  GetLevelByClass(CLASS_TYPE_RANGER,oCaster)>19
  )
  {
    return TRUE;
  }
  return FALSE;
}
int MothAllowSelfBless(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  MothHasClericDomain(oCaster,FEAT_GOOD_DOMAIN_POWER)
  )
  {
    return TRUE;
  }
  if(oTarget == oCaster &&
  GetLevelByClass(CLASS_TYPE_PALADIN,oCaster)>19
  )
  {
    return TRUE;
  }
  return FALSE;
}
int MothAllowSelfAid(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  MothHasClericDomain(oCaster,FEAT_EVIL_DOMAIN_POWER)
  )
  {
    return TRUE;
  }
  if(oTarget == oCaster &&
  GetLevelByClass(CLASS_TYPE_PALADIN,oCaster)>19||
  GetLevelByClass(CLASS_TYPE_RANGER,oCaster)>19
  )
  {
    return TRUE;
  }
  return FALSE;
}
int MothAllowSelfSheildOfFaith(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  MothHasClericDomain(oCaster,FEAT_EVIL_DOMAIN_POWER)
  )
  {
    return TRUE;
  }
  return FALSE;
}
int MothAllowSelfRegen(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  MothHasClericDomain(oCaster,FEAT_PLANT_DOMAIN_POWER)
  )
  {
    return TRUE;
  }
  if(oTarget == oCaster &&
  GetLevelByClass(CLASS_TYPE_DRUID,oCaster)>29
  )
  {
    return TRUE;
  }
  return FALSE;
}
int MothAllowSelfMonsterousRegen(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  GetLevelByClass(CLASS_TYPE_DRUID,oCaster)>29
  )
  {
    return TRUE;
  }
  if(oTarget == oCaster &&
  GetLevelByClass(CLASS_TYPE_RANGER,oCaster)>20
  )
  {
    return TRUE;
  }
  return FALSE;
}
int MothAllowSelfDaystar(object oTarget, object oCaster)
{
  if(oTarget != oCaster)
  {
   return TRUE;
  }
  if(oTarget == oCaster &&
  MothGetIsPureClass(CLASS_TYPE_BARD,oCaster)
  )
  {
    return TRUE;
  }
  return FALSE;
}
// Call at Login and Level Up to set the number of RDD Levels on PC
// Good for abilities that are cast while in a Shape that should be based on RDD Levels.
// Can be called at PC death too if the PC might delvl.
void MothSetRDDLevels(object oPC)
{
    int nRDDLevels = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oPC);
    if(nRDDLevels>1)
    {
     //Set Shifter Levels
     SetLocalInt(oPC,"MothRDDLevels",nRDDLevels);
    }
}
// Use to get the number of RDD Levels. Can only be used if MothGetRDDLevels()
// is called at Login and preferably at PC Level Up/death/orb(respawn) too.
// In short, each time a PC will gain and possibly lose a level.
int MothGetRDDLevels(object oPC)
{
   int nLevel = GetLocalInt(oPC,"MothRDDLevels");
   return nLevel;
}
void MothRDDHeal(object oPC, int nRDDLevel)
{
    int nCon = GetAbilityModifier(ABILITY_CONSTITUTION);
    int nHeal = nRDDLevel*nCon;
    nHeal = nHeal + d20(5);
    effect eHeal = EffectHeal(nHeal);
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_G);
    int iTimer = GetLocalInt(oPC, "RDDHealSpell");
    if (iTimer<2)
    {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    SetLocalInt(OBJECT_SELF, "RDDHealSpell", iTimer);
    }
    else if (iTimer == 2)
    {
    DelayCommand(0.7, FloatingTextStringOnCreature("<cðøþ>*Healing Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(oPC, "<c¥¥¥>[Server] Self-Healing Focus is lost.</c>"));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    SetLocalInt(oPC, "RDDHealSpell", iTimer);
    }
    else if (iTimer>2)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Healing Focus!*</c>",oPC,FALSE);
    SendMessageToPC(oPC, "<c¥¥¥>[Server] You do not have enough Self-Healing focus right now.</c>");
    }
}
void MothGetDirection(float fFacing, object oUser, object oTarget)
    {
    if (fFacing >= 360.0)
        fFacing  =  720.0 - fFacing;
    if (fFacing <    0.0)
        fFacing += (360.0);
    int iFacing = FloatToInt(fFacing);
    string sDirection = "";
    if((iFacing >= 359) && (iFacing <=   2))
        sDirection = "east";
    if((iFacing >=   3) && (iFacing <=  45))
        sDirection = "east northeast";
    if((iFacing >=  46) && (iFacing <=  87))
        sDirection = "north northeast";
    if((iFacing >=  88) && (iFacing <=  92))
        sDirection = "north";
    if((iFacing >=  93) && (iFacing <= 135))
        sDirection = "north northwest";
    if((iFacing >= 136) && (iFacing <= 177))
        sDirection = "west northwest";
    if((iFacing >= 178) && (iFacing <= 182))
        sDirection = "west";
    if((iFacing >= 183) && (iFacing <= 225))
        sDirection = "west southwest";
    if((iFacing >= 226) && (iFacing <= 267))
        sDirection = "south southwest";
    if((iFacing >= 268) && (iFacing <= 272))
        sDirection = "south";
    if((iFacing >= 273) && (iFacing <= 315))
        sDirection = "south southeast";
    if((iFacing >= 316) && (iFacing <= 358))
        sDirection = "east southeast";
    SendMessageToPC(oUser,"<cðæŒ>*"+GetName(oTarget)+" is to the "+sDirection+".*</c>");
    return ;
}
//Return the race of oTarget.
string MothGetRace(object oTarget)
{
  string sRace;
  int nRace = GetRacialType(oTarget);
  if(nRace == RACIAL_TYPE_ABERRATION){sRace == "Aberration";}
  else if(nRace == RACIAL_TYPE_ANIMAL){sRace == "Animal";}
  else if(nRace == RACIAL_TYPE_BEAST){sRace == "Beast";}
  else if(nRace == RACIAL_TYPE_CONSTRUCT){sRace == "Construct";}
  else if(nRace == RACIAL_TYPE_DRAGON){sRace == "Dragon";}
  else if(nRace == RACIAL_TYPE_DWARF){sRace == "Dwarf";}
  else if(nRace == RACIAL_TYPE_ELEMENTAL){sRace == "Elemental";}
  else if(nRace == RACIAL_TYPE_ELF){sRace == "Elf";}
  else if(nRace == RACIAL_TYPE_FEY){sRace == "Fey";}
  else if(nRace == RACIAL_TYPE_GIANT){sRace == "Giant";}
  else if(nRace == RACIAL_TYPE_GNOME){sRace == "Gnome";}
  else if(nRace == RACIAL_TYPE_HALFELF){sRace == "Half-elf";}
  else if(nRace == RACIAL_TYPE_HALFLING){sRace == "Halfling";}
  else if(nRace == RACIAL_TYPE_HALFORC){sRace == "Halforc";}
  else if(nRace == RACIAL_TYPE_HUMAN){sRace == "Human";}
  else if(nRace == RACIAL_TYPE_MAGICAL_BEAST){sRace == "Magical Beast";}
  else if(nRace == RACIAL_TYPE_OOZE){sRace == "Ooze";}
  else if(nRace == RACIAL_TYPE_OUTSIDER){sRace == "Outsider";}
  else if(nRace == RACIAL_TYPE_SHAPECHANGER){sRace == "Shapechanger";}
  else if(nRace == RACIAL_TYPE_UNDEAD){sRace == "Undead";}
  else if(nRace == RACIAL_TYPE_VERMIN){sRace == "Vermin";}
  return sRace;

}
int MothGetIsPureClass(int nClass, object oPlayer=OBJECT_SELF)
{
   int nTotalLevel = GetHitDice(oPlayer);
   int nClassLevel = GetLevelByClass(nClass,oPlayer);
   if(nTotalLevel>nClassLevel)
   {
   return FALSE;
   }
   else return TRUE;
}
int MothGetHasGreatAbility(int nAbility, object oPlayer=OBJECT_SELF)
{
  if(nAbility == ABILITY_INTELLIGENCE)
  {
      if (GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_5,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_6,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_7,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_8,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_9,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_INTELLIGENCE_10,oPlayer))
          {
          return TRUE;
          }
          else return FALSE;
      }
  else if(nAbility == ABILITY_CHARISMA)
  {
      if (GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_5,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_6,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_7,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_8,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_9,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_CHARISMA_10,oPlayer))
          {
          return TRUE;
          }
          else return FALSE;
      }
  else if(nAbility == ABILITY_WISDOM)
  {
      if (GetHasFeat(FEAT_EPIC_GREAT_WISDOM_5,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_WISDOM_6,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_WISDOM_7,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_WISDOM_8,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_WISDOM_9,oPlayer)||
          GetHasFeat(FEAT_EPIC_GREAT_WISDOM_10,oPlayer))
          {
          return TRUE;
          }
          else return FALSE;
      }
  else return FALSE;
}
int MothGetIsOrbWorld(object oPlayer)
{
    object oArea = GetArea(oPlayer);
    int nCheck=FALSE;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         if(GetTag(oObject) == "MOTHORBWORLD")
         {
             nCheck=TRUE;
         }
         oObject = GetNextObjectInArea(oArea);
    }
    if(nCheck==FALSE)
    {
     return FALSE;
    }
    else return TRUE;
}
int MothGetPoison()
{
    int nRand = Random(44)+1;
    int nDisease;
    switch (nRand)
    {
        case 1:
            nDisease = POISON_ARANEA_VENOM;
        break;
        case 2:
            nDisease = POISON_ARSENIC;
        break;
        case 3:
            nDisease = POISON_BEBILITH_VENOM;
        break;
        case 4:
            nDisease = POISON_BLACK_ADDER_VENOM;
        break;
        case 5:
            nDisease = POISON_BLACK_LOTUS_EXTRACT;
        break;
        case 6:
            nDisease = POISON_BLADE_BANE;
        break;
        case 7:
            nDisease = POISON_BLOODROOT;
        break;
        case 8:
            nDisease = POISON_BLUE_WHINNIS;
        break;
        case 9:
            nDisease = POISON_BURNT_OTHUR_FUMES;
        break;
        case 10:
            nDisease = POISON_CARRION_CRAWLER_BRAIN_JUICE;
        break;
        case 11:
            nDisease = POISON_CHAOS_MIST;
        break;
        case 12:
            nDisease = POISON_COLOSSAL_SPIDER_VENOM;
        break;
        case 13:
            nDisease = POISON_DARK_REAVER_POWDER;
        break;
        case 14:
            nDisease = POISON_DEATHBLADE;
        break;
        case 15:
            nDisease = POISON_DRAGON_BILE;
        break;
        case 16:
            nDisease = POISON_ETTERCAP_VENOM;
        break;
        case 17:
            nDisease = POISON_GARGANTUAN_SPIDER_VENOM;
        break;
        case 18:
            nDisease = POISON_GIANT_WASP_POISON;
        break;
        case 19:
            nDisease = POISON_GREENBLOOD_OIL;
        break;
        case 20:
            nDisease = POISON_HUGE_SPIDER_VENOM;
        break;
        case 21:
            nDisease = POISON_ID_MOSS;
        break;
        case 22:
            nDisease = POISON_IRON_GOLEM;
        break;
        case 23:
            nDisease = POISON_LARGE_SCORPION_VENOM;
        break;
        case 24:
            nDisease = POISON_LARGE_SPIDER_VENOM;
        break;
        case 25:
            nDisease = POISON_LICH_DUST;
        break;
        case 26:
            nDisease = POISON_MALYSS_ROOT_PASTE;
        break;
        case 27:
            nDisease = POISON_MEDIUM_SPIDER_VENOM;
        break;
        case 28:
            nDisease = POISON_NIGHTSHADE;
        break;
        case 29:
            nDisease = POISON_NITHARIT;
        break;
        case 30:
            nDisease = POISON_OIL_OF_TAGGIT;
        break;
        case 31:
            nDisease = POISON_PHASE_SPIDER_VENOM;
        break;
        case 32:
            nDisease = POISON_PIT_FIEND_ICHOR;
        break;
        case 33:
            nDisease = POISON_PURPLE_WORM_POISON;
        break;
        case 34:
            nDisease = POISON_QUASIT_VENOM;
        break;
        case 35:
            nDisease = POISON_SASSONE_LEAF_RESIDUE;
        break;
        case 36:
            nDisease = POISON_SHADOW_ESSENCE;
        break;
        case 37:
            nDisease = POISON_SMALL_CENTIPEDE_POISON;
        break;
        case 38:
            nDisease = POISON_STRIPED_TOADSTOOL;
        break;
        case 39:
            nDisease = POISON_TERINAV_ROOT;
        break;
        case 40:
            nDisease = POISON_TINY_SPIDER_VENOM;
        break;
        case 41:
            nDisease = POISON_UNGOL_DUST;
        break;
        case 42:
            nDisease = POISON_WRAITH_SPIDER_VENOM;
        break;
        case 43:
            nDisease = POISON_WYVERN_POISON;
        break;
        case 44:
            nDisease = POISON_SMALL_SPIDER_VENOM;
        break;
    }
   return nDisease;
}
int MothGetDisease()
{
    int nRand = Random(17)+1;
    int nDisease;
    switch (nRand)
    {
        case 1:
            nDisease = DISEASE_BLINDING_SICKNESS;
        break;
        case 2:
            nDisease = DISEASE_BURROW_MAGGOTS;
        break;
        case 3:
            nDisease = DISEASE_CACKLE_FEVER;
        break;
        case 4:
            nDisease = DISEASE_DEMON_FEVER;
        break;
        case 5:
            nDisease = DISEASE_DEVIL_CHILLS;
        break;
        case 6:
            nDisease = DISEASE_DREAD_BLISTERS;
        break;
        case 7:
            nDisease = DISEASE_FILTH_FEVER;
        break;
        case 8:
            nDisease = DISEASE_GHOUL_ROT;
        break;
        case 9:
            nDisease = DISEASE_MINDFIRE;
        break;
        case 10:
            nDisease = DISEASE_MUMMY_ROT;
        break;
        case 11:
            nDisease = DISEASE_RED_ACHE;
        break;
        case 12:
            nDisease = DISEASE_RED_SLAAD_EGGS;
        break;
        case 13:
            nDisease = DISEASE_SHAKES;
        break;
        case 14:
            nDisease = DISEASE_SLIMY_DOOM;
        break;
        case 15:
            nDisease = DISEASE_SOLDIER_SHAKES;
        break;
        case 16:
            nDisease = DISEASE_VERMIN_MADNESS;
        break;
        case 17:
            nDisease = DISEASE_ZOMBIE_CREEP;
        break;

    }
   return nDisease;
}
int MothGetIsFriendlyNPC(object oCaster, object oTarget)
{
   if(!GetIsPC(oTarget) && MothGetIsFortAlly(oTarget,oCaster))
   {
    return TRUE;
   }
   else return FALSE;
}
void MothRemovePolymorph(object oPC)
{
  effect eLoop=GetFirstEffect(oPC);
  while (GetIsEffectValid(eLoop))
   {
   if (GetEffectType(eLoop)==EFFECT_TYPE_POLYMORPH)
         RemoveEffect(oPC, eLoop);

   eLoop=GetNextEffect(oPC);
   }
}
int MothGetIsLocationClear(object oCaster,location lTarget, int nSphere=SHAPE_SPHERE, float fSize=4.0)
{
    object oTarget = GetFirstObjectInShape(nSphere, fSize, lTarget, TRUE);
    object oArea = GetArea(oCaster);
    if(MothGetIsNoPvPArea(oArea))
    {
    return FALSE;
    }
    while (GetIsObjectValid(oTarget))
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_ALL)
        {
           if (GetIsObjectValid(oTarget))
            {
               return FALSE;
            }
        }
        else
        {
         return TRUE;
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget, TRUE);
    }
  return TRUE;
}
void MothDislikeSecondaryFaction(object oPC)
{
    object oAxfell2 = GetObjectByTag("MOTHAXFELL2HOLDER");
    object oCleaven2 = GetObjectByTag("MOTHCLEAVEN2HOLDER");
    if(GetLocalString(oPC,"MothSetFactionInt")=="MothAxfellMember")
    {
     AdjustReputation(oPC,oCleaven2,-100);
    }
    else if(GetLocalString(oPC,"MothSetFactionInt")=="MothCleavenMember")
    {
     AdjustReputation(oPC,oAxfell2,-100);
    }
    else return;
}
void MothUnsummonMultipleSummons()
{
    object oSummon = GetFirstObjectInArea();
    while(GetIsObjectValid(oSummon))
    {
        if (GetAssociateType(oSummon)==ASSOCIATE_TYPE_SUMMONED && GetMaster(oSummon) == OBJECT_SELF)
        {
         DestroyObject(oSummon);
        }
       oSummon = GetNextObjectInArea();
    }
}
void MothOblation(object oTarget)
{
    if(GetLocalInt(oTarget,"MOTHOBLATION")==FALSE)
    {
     int nCasterLvl = MothGetCasterLevel(oTarget);
     int nDuration = nCasterLvl;
     int nValue = nCasterLvl/10;
     int nLimit = 20*nDuration;
     effect eVis1 = EffectVisualEffect(VFX_IMP_AC_BONUS);
     effect eVis2 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
     effect eVis3 = EffectVisualEffect(VFX_IMP_HOLY_AID);
     effect eVis4 = EffectVisualEffect(VFX_IMP_POLYMORPH);
     effect eVis = EffectLinkEffects(eVis1,eVis2);
     eVis = EffectLinkEffects(eVis,eVis3);
     eVis = EffectLinkEffects(eVis,eVis4);
     effect eDur = EffectVisualEffect(495);
     effect eDur2 = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
     effect eAC = EffectACIncrease(nValue, AC_DODGE_BONUS);
     effect eReduction = EffectDamageReduction(nCasterLvl, DAMAGE_POWER_PLUS_SIX, nLimit);
     effect eLink2 = EffectLinkEffects(eAC, eDur);
     eLink2 = EffectLinkEffects(eLink2, eReduction);
     eLink2 = ExtraordinaryEffect(eLink2);
     ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur2, oTarget, RoundsToSeconds(nDuration));
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, oTarget, RoundsToSeconds(nDuration));
     SetLocalInt(oTarget,"MOTHOBLATION",TRUE);
    }
}
void MothSetDomain(object oPC)
{
  if(GetHasFeat(FEAT_DEATH_DOMAIN_POWER,oPC))
  {
   SetLocalInt(oPC,"MOTHDEATHDOMAIN",TRUE);
  }
  if(GetHasFeat(FEAT_PROTECTION_DOMAIN_POWER,oPC))
  {
   SetLocalInt(oPC,"MOTHPROTECTIONDOMAIN",TRUE);
  }
  if(GetHasFeat(FEAT_STRENGTH_DOMAIN_POWER,oPC))
  {
   SetLocalInt(oPC,"MOTHSTRENGTHDOMAIN",TRUE);
  }
  if(GetHasFeat(FEAT_TRICKERY_DOMAIN_POWER,oPC))
  {
   SetLocalInt(oPC,"MOTHTRICKERYDOMAIN",TRUE);
  }
  if(GetHasFeat(FEAT_WAR_DOMAIN_POWER,oPC))
  {
   SetLocalInt(oPC,"MOTHWARDOMAIN",TRUE);
  }
}
//void main() {}

