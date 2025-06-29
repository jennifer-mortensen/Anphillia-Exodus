//MOTHAURACOURAGEHBINC
#include "anph_inc"
#include "moth_inc_tracker"
#include "_inc_xp"
#include "_inc_const"
// * Handles the Aura effect applied to ally. Sisterfunction to MothApplyAuraOfCourage().
void MothApplyAuraOfCourageToAllies(int nCasterLvl, object oTarget, float fDuration, object oCaster);
// * Handles the Aura effect applied to enemy. Sisterfunction to MothApplyAuraOfCourage().
void MothApplyAuraOfCourageToEnemies(int nCasterLvl, object oTarget, float fDuration);
// * Handles the Aura effect applied to self. Sisterfunction to MothApplyAuraOfCourage().
void MothApplyAuraOfCourageToSelf(int nCasterLvl, object oCaster, float fDuration);
// * Handles the Aura effect that fire with gobal HB's.
void MothApplyAuraOfCourage(object oCaster);
// * Handles the Aura effect that fire with gobal HB's.
void MothApplyCorrectAuraOfCourage(object oPlayer, object oTarget);
// * Handles the Tim XP that fire with gobal HB's.
void MothGiveTimeXP(object oPC, object oMod, int nHourOfDay);
// * oNod fires a Ray of Frost on oTarget
void MothAxfellNodAttack(object oNod, object oTarget);
// * oNod fires a Ray of Frost on oTarget
void MothCleavenNodAttack(object oNod, object oTarget);

void MothGiveTimeXP(object oPC, object oMod, int nHourOfDay)
{
       int nHourToGive1 = GetLocalInt(oMod,"MothXPHour1");
       int nHourToGive2 = GetLocalInt(oMod,"MothXPHour2");
       int nHourToGive3 = GetLocalInt(oMod,"MothXPHour3");
       int nHourToGive4 = GetLocalInt(oMod,"MothXPHour4");
          if(nHourOfDay == nHourToGive1 ||
             nHourOfDay == nHourToGive2 ||
             nHourOfDay == nHourToGive3 ||
             nHourOfDay == nHourToGive4 )
            {
              if(MothGetIsOrbWorld(oPC)==TRUE)
              {
                return;
              }
              int nXPAmount = GetLocalInt(oMod,"MothXpAmount");
              int nGPAmount = 400;
              //J. Persinne; subraces now have their experience adjusted downward 5% per ECL if the level cap is turned on.
              int nECL = GetECL(oPC);
              if(ECL_LEVEL_CAP == TRUE && nECL > 0)
              {
                  //float fECLAdjustment = 1.0 - (0.05 * IntToFloat(nECL));
                  nXPAmount = 190;
              }
              else
              {
                nXPAmount = 200;
              }

              string sArea = GetTag(GetArea(oPC));
              string sExcludedArea1 = GetLocalString(oMod,"MothXpArea1");
              string sExcludedArea2 = GetLocalString(oMod,"MothXpArea2");
              string sExcludedArea3 = GetLocalString(oMod,"MothXpArea3");
              string sExcludedArea4 = GetLocalString(oMod,"MothXpArea4");
              string sExcludedArea5 = GetLocalString(oMod,"MothXpArea5");
              if(sArea == sExcludedArea1||
                 sArea == sExcludedArea2||
                 sArea == sExcludedArea3||
                 sArea == sExcludedArea4||
                 sArea == sExcludedArea5)
                 {
                  return;
                 }

               //If Cleavens have the relic give them 50 extra
               if(GetLocalInt(oMod,"Relic_Status") == 4 || GetLocalInt(oMod,"Relic_Status") == 6)
               {
                  if(GetLocalString(oPC,"MothSetFactionInt")=="MothCleavenMember")
                  {
                        GiveVirtualXPToCreature(oPC, nXPAmount + 50, FALSE);
                        GiveGoldToCreature(oPC, nGPAmount + 600);
                  }
                  else
                  {
                        GiveVirtualXPToCreature(oPC, nXPAmount, FALSE);
                        GiveGoldToCreature(oPC, nGPAmount);
                  }
               }
               //If Axfells have the relic give them 50 extra
               else if(GetLocalInt(oMod,"Relic_Status") == 3 || GetLocalInt(oMod,"Relic_Status") == 5)
               {
                    if(GetLocalString(oPC,"MothSetFactionInt")=="MothAxfellMember")
                    {
                        GiveVirtualXPToCreature(oPC, nXPAmount + 50, FALSE);
                        GiveGoldToCreature(oPC, nGPAmount + 600);
                    }
                    else
                    {
                        GiveVirtualXPToCreature(oPC, nXPAmount, FALSE);
                        GiveGoldToCreature(oPC, nGPAmount);
                    }
               }
               //If relics are where they should be give standard XP
               else
               {
                  if(GetLocalString(oPC,"MothSetFactionInt")=="MothCleavenMember")
                  {
                    GiveVirtualXPToCreature(oPC, nXPAmount, FALSE);
                    GiveGoldToCreature(oPC, nGPAmount);
                  }
                  else if(GetLocalString(oPC,"MothSetFactionInt")=="MothAxfellMember")
                  {
                    GiveVirtualXPToCreature(oPC, nXPAmount, FALSE);
                    GiveGoldToCreature(oPC, nGPAmount);
                  }
               }
               SendMessageToPC(oPC,"<cеее>[Server] Here are your wages. Keep it up!</c>");
            }
}
void MothApplyAuraOfCourageToAllies(int nCasterLvl, object oTarget, float fDuration, object oCaster)
{
    if(oTarget == oCaster){return;}
    effect eBuffAllyVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eBuff = EffectImmunity(IMMUNITY_TYPE_FEAR);
    effect eBuff1 = EffectImmunity(IMMUNITY_TYPE_DAZED);
    effect eBuff2 = EffectImmunity(IMMUNITY_TYPE_CURSED);
    effect eBuff3 = EffectImmunity(IMMUNITY_TYPE_STUN);
    effect eBuffAlly = EffectLinkEffects(eBuff,eBuff1);
    if(nCasterLvl>20)
    {
    eBuffAlly = EffectLinkEffects(eBuffAlly,eBuff2);
    }
    if(nCasterLvl>30)
    {
    eBuffAlly = EffectLinkEffects(eBuffAlly,eBuff2);
    eBuffAlly = EffectLinkEffects(eBuffAlly,eBuff3);
    }
    SetLocalInt(oTarget,"MOTHHASGOODCOURAGE",TRUE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuffAlly, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBuffAllyVis, oTarget);
    DelayCommand(fDuration,DeleteLocalInt(oTarget,"MOTHHASGOODCOURAGE"));
}
void MothApplyAuraOfCourageToEnemies(int nCasterLvl, object oTarget, float fDuration)
{
    int nPenalty = nCasterLvl/10;
    effect ePenaltyVis = EffectVisualEffect(VFX_IMP_DOOM);
    effect ePenalty1 = EffectACDecrease(nPenalty,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect ePenalty2 = EffectAttackDecrease(nPenalty,ATTACK_BONUS_MISC);
    effect ePenalty3 = EffectSkillDecrease(SKILL_ALL_SKILLS,nPenalty);
    effect ePenaltyEnemy = ePenalty1;
    if(nCasterLvl>20)
    {
    ePenaltyEnemy = EffectLinkEffects(ePenalty1,ePenalty2);
    }
    if(nCasterLvl>30)
    {
    ePenaltyEnemy = EffectLinkEffects(ePenalty1,ePenalty2);
    ePenaltyEnemy = EffectLinkEffects(ePenaltyEnemy,ePenalty3);
    }
    SetLocalInt(oTarget,"MOTHHASEVILCOURAGE",TRUE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePenaltyEnemy, oTarget, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePenaltyVis, oTarget);
    DelayCommand(fDuration,DeleteLocalInt(oTarget,"MOTHHASEVILCOURAGE"));
}
void MothApplyAuraOfCourageToSelf(int nCasterLvl, object oCaster, float fDuration)
{
    int nBuff = nCasterLvl/10;
    effect eBuffSelfVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eBuffSelfVis2 = EffectVisualEffect(VFX_IMP_TORNADO);
    effect eBuffSelfVis3 = EffectVisualEffect(VFX_IMP_AC_BONUS);
    effect eBuffSelfVis = EffectLinkEffects(eBuffSelfVis1,eBuffSelfVis2);
    eBuffSelfVis = EffectLinkEffects(eBuffSelfVis,eBuffSelfVis3);
    effect eBuff1 = EffectSavingThrowIncrease(SAVING_THROW_REFLEX,nBuff,SAVING_THROW_TYPE_ALL);
    effect eBuff2 = EffectACIncrease(nBuff,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect eBuff3 = EffectDamageIncrease(nCasterLvl,DAMAGE_TYPE_DIVINE);
    effect eBuff4 = EffectDamageResistance(DAMAGE_TYPE_MAGICAL,nBuff);
    effect eBuffSelf = EffectLinkEffects(eBuff1,eBuff2);
    eBuffSelf = EffectLinkEffects(eBuffSelf,eBuff3);
    eBuffSelf = EffectLinkEffects(eBuffSelf,eBuff4);
    eBuffSelf = ExtraordinaryEffect(eBuffSelf);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuffSelf, oCaster, fDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eBuffSelfVis, oCaster);
}
void MothApplyCorrectAuraOfCourage(object oCaster, object oTarget)
{
        int nCasterLvl = GetLevelByClass(CLASS_TYPE_CLERIC,oCaster);
        if(nCasterLvl>30)
        {
        ExecuteScript("mothcourageaura3",oTarget);
        return;
        }
        else if(nCasterLvl>20)
        {
        ExecuteScript("mothcourageaura2",oTarget);
        return;
        }
        else
        {
        ExecuteScript("mothcourageaura1",oTarget);
        return;
        }
}
void MothApplyAuraOfCourage(object oCaster)
{
      int nLevel = GetLevelByClass(CLASS_TYPE_CLERIC, oCaster);
      float fRadius = 10.9;
      location lLocation = GetLocation(oCaster);
      object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius,lLocation);
      while(GetIsObjectValid(oTarget))
      {
        if(MothGetIsFortAlly(oTarget,oCaster) && oTarget != oCaster)
          {
            MothApplyCorrectAuraOfCourage(oCaster,oTarget);
          }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lLocation);
     }
}
void MothAuraOfCourageHeartbeat()
{
      object oPC = GetFirstPC();
      while(GetIsObjectValid(oPC))
      {
       if(GetHasSpellEffect(314,oPC))
         {
          MothApplyAuraOfCourage(oPC);
         }
        oPC = GetNextPC();
      }
}
void MothNodAttack(object oNod, object oTarget)
{
    int nSpell;
    switch (Random(4))
           {
            case 0: nSpell = SPELL_RAY_OF_FROST; break;
            case 1: nSpell = SPELL_ACID_SPLASH; break;
            case 2: nSpell = SPELL_ELECTRIC_JOLT; break;
            case 3: nSpell = 326; break;
           }
    AssignCommand(oNod,ActionCastSpellAtObject(nSpell,oTarget,METAMAGIC_EMPOWER,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
}
void MothAxfellNodStart()
{
    object oNod1 = GetObjectByTag("mothaxfellnod1");
    object oNod2 = GetObjectByTag("mothaxfellnod2");
    object oNod3 = GetObjectByTag("mothaxfellnod3");
    object oNod4 = GetObjectByTag("mothaxfellnod4");
    object oPC1 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod1);
    object oPC2 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod2);
    object oPC3 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod3);
    object oPC4 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod4);
    if(GetIsObjectValid(oPC1))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod1,oPC1));
    }
    if(GetIsObjectValid(oPC2))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod2,oPC2));
    }
    if(GetIsObjectValid(oPC3))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod3,oPC3));
    }
    if(GetIsObjectValid(oPC4))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod4,oPC4));
    }
}
void MothCleavenNodStart()
{
    object oNod1 = GetObjectByTag("mothcleavennod1");
    object oNod2 = GetObjectByTag("mothcleavennod2");
    object oNod3 = GetObjectByTag("mothcleavennod3");
    object oNod4 = GetObjectByTag("mothcleavennod4");
    object oPC1 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod1);
    object oPC2 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod2);
    object oPC3 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod3);
    object oPC4 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod4);
    if(GetIsObjectValid(oPC1))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod1,oPC1));
    }
    if(GetIsObjectValid(oPC2))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod2,oPC2));
    }
    if(GetIsObjectValid(oPC3))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod3,oPC3));
    }
    if(GetIsObjectValid(oPC4))
    {
    float fDelay = IntToFloat(d6());
    DelayCommand(fDelay,MothNodAttack(oNod4,oPC4));
    }
}
void MothAmberAttack(object oNod, object oTarget)
{
    int nSpell;
    AssignCommand(oNod,ActionCastSpellAtObject(SPELL_SCINTILLATING_SPHERE,oTarget,METAMAGIC_EMPOWER,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
}
void MothAmberStart()
{
    object oNod1 = GetObjectByTag("mothrangaramber");
    object oPC1 = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY,oNod1);
    if(GetIsObjectValid(oPC1))
    {
    float fDelay = IntToFloat(d2());
    DelayCommand(fDelay,MothAmberAttack(oNod1,oPC1));
    }
}
void MothChargerAttack(object oNod, object oTarget)
{
    int nSpell;
    AssignCommand(oNod,ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING,oTarget,METAMAGIC_EMPOWER,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
}
void MothAmberChager()
{
    object oNod1 = GetObjectByTag("mothragnarcharger1");
    object oNod2 = GetObjectByTag("mothragnarcharger2");
    object oNod3 = GetObjectByTag("mothragnarcharger3");
    object oNod4 = GetObjectByTag("mothragnarcharger4");
    object oAmber1 = GetObjectByTag("mothrangaramber");
    if(GetIsObjectValid(oAmber1))
    {
    MothChargerAttack(oNod1,oAmber1);
    }
    if(GetIsObjectValid(oAmber1))
    {
    MothChargerAttack(oNod2,oAmber1);
    }
    if(GetIsObjectValid(oAmber1))
    {
    MothChargerAttack(oNod3,oAmber1);
    }
    if(GetIsObjectValid(oAmber1))
    {
    MothChargerAttack(oNod4,oAmber1);
    }
}
//void main() {}
