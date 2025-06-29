#include "moth_inc"
#include "NW_I0_SPELLS"
#include "x2_I0_SPELLS"
#include "moth_inc_spells"
#include "moth_inc_effects"
// * Returns TRUE if oTarget should be given a Haste effect.
int MothHasteCheck(object oTarget);
// * Run before applying Haste effect to ensure reappliance.
void MothPreHaste(object oTarget);
// * Removes any Bard song (good or bad) from oTarget with fDelay delay.
void MothRemoveAnySong(object oTarget, float fDelay=0.0);
// * Handles RDD Instant Spell One.
void MothRDDSpellOne(object oCaster, object oTarget);
// * Handles RDD Instant Spell Two.
void MothRDDSpellTwo(object oCaster, object oTarget);
// * Handles RDD Instant Spell Three.
void MothRDDSpellThree(object oCaster, object oTarget);
// * Returns TRUE if oTarget has any hasting effects.
int MothGetIsHasted(object oTarget);
// * The name says it all
void MothSuicideBomber(object oBoomer,object oOwner, int nDC=25);
// * Spawns a Ritual Zombie.
void MothRitualZombie(object oCaster, location lSpawn, int nDC=25);
// * Lowers saves on oTarget
void MothCharmPenalty(object oTarget, object oCaster, int nSpell);
// * Paralyze wrapper.
void MothImmobilize(object oTarget, object oCaster, int nSpell, int nDuration);
// * Applies a bloody visual effect to oTarget
void MothBloodyVisual(object oTarget);
// * Spawns an Oak as an combat ally
void MothSpawnGreatOak(object oCaster,location lLocation);
// * On Hit hook to make On Hit: Spell have only a 15% chance of firing, instead of 100%.
// This is to remove strain on the server, especially with On Hit dispels.
// The exception here if the oSpellTarget is a PC.
// This will also affect Weapons that casts offensive spells as Item Property: Cast Spell. :(
// This is because scanning for On Hit property on oItem would be costly and defeat the purpose of this hook.
// Uses MothGetIsSpellHostile to make sure friendly spells cast from weapons works all the time.
// By Default only used in Dispel/Breach scripts.
int MothDecreaseOnHitSpellChance();
int MothGetIsHasted(object oTarget)
{
    if (GetHasSpellEffect(78, oTarget)||
        GetHasSpellEffect(113, oTarget)||
        GetHasSpellEffect(563, oTarget)||
        GetHasSpellEffect(7, oTarget)||
        GetHasSpellEffect(647, oTarget)

    )
    {
        return TRUE;
    }
    return FALSE;
}
//Returns TRUE if oTarget should be given a Haste effect.
int MothHasteCheck(object oTarget)
{
    if (GetHasSpellEffect(647, oTarget) == TRUE)
    {
        return TRUE;
    }
    return FALSE;
}
//Run before applying Haste effect.
void MothPreHaste(object oTarget)
{
    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_EXPEDITIOUS_RETREAT, oTarget, oTarget);
    }
    if (GetHasSpellEffect(SPELL_HASTE, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_HASTE, oTarget, oTarget);
    }
    if (GetHasSpellEffect(SPELL_MASS_HASTE, oTarget) == TRUE)
    {
        RemoveSpellEffects(SPELL_MASS_HASTE, oTarget, oTarget);
    }
}
void MothRemoveAnySong(object oTarget, float fDelay=0.0)
{
  DelayCommand(fDelay,RemoveEffectsFromSpell(oTarget,411));
  DelayCommand(fDelay,RemoveEffectsFromSpell(oTarget,644));
  DelayCommand(fDelay,RemoveEffectsFromSpell(oTarget,686));
}
void RunRDDSpellOneImpact(object oTarget, object oCaster)
{
    if (GZGetDelayedSpellEffectsExpired(832,oTarget,oCaster))
    {
        return;
    }
    if (GetIsDead(oTarget) == FALSE)
    {
       AssignCommand(oTarget, PlaySound("sca_dragfire"));
       int nDC = GetSkillRank(SKILL_SPELLCRAFT,oCaster)/2 +15;
       int nLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oCaster) + GetLevelByClass(CLASS_TYPE_SORCERER,oCaster) ;
       int nDice =  nLevel/2;
       int nDamage = d3(nDice) +10;
       effect eDam      = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
       effect eDur      = EffectVisualEffect(498);
       eDur = ExtraordinaryEffect(eDur);
       if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_NONE,oCaster))
       {
       MothFireLink(oCaster,oTarget,nDamage);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
       DelayCommand(6.0, RunRDDSpellOneImpact(oTarget,oCaster));
       }
   }
}
void MothRDDSpellOne(object oCaster, object oTarget)
{
       AssignCommand(oCaster, PlaySound("sca_dragfire"));
       AssignCommand(oTarget, PlaySound("sca_dragfire"));
       int nDC = GetSkillRank(SKILL_SPELLCRAFT,oCaster)/2 +15;
       int nLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oCaster) + GetLevelByClass(CLASS_TYPE_SORCERER,oCaster) ;
       int nDice =  nLevel/2;
       int nDamage = d3(nDice) +15;
       effect eDam      = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
       effect eDur      = EffectVisualEffect(498);
       eDur = ExtraordinaryEffect(eDur);
       if(GetHasSpellEffect(518,oTarget) || GetHasSpellEffect(832,oTarget))
         {
          FloatingTextStringOnCreature("<cðøþ>*Target already has a burning Effect!*</c>",oCaster,FALSE);
          return;
         }
       if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_NONE,oCaster))
       {
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget,60.0);
       MothFireLink(oCaster,oTarget,nDamage);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
       DelayCommand(6.0, RunRDDSpellOneImpact(oTarget,oCaster));
       }
}
void MothRDDSpellTwo(object oCaster, object oTarget)
{
        AssignCommand(oCaster, PlaySound("sca_dragmind"));
        int nDC = GetSkillRank(SKILL_SPELLCRAFT,oCaster)/2+ 15;
        int nLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oCaster) + GetLevelByClass(CLASS_TYPE_SORCERER,oCaster) ;
        int nDice =  nLevel/2;
        int nDamage = d4(nDice)+nDice+15;
        effect eVisa = EffectVisualEffect(VFX_IMP_FLAME_S);
        effect eVisb = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        effect eVis = EffectLinkEffects(eVisa,eVisb);
        effect eVis2 = EffectVisualEffect(670);
        MothFireLink(oCaster,oTarget,nDamage);
        if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_NONE,oCaster))
          {
           effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
           DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget,1.0));
           DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
           DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
          }
}
void MothRDDSpellThree(object oCaster, object oTarget)
{
        AssignCommand(oCaster, PlaySound("sca_dragodd"));
        int nPersuade = GetSkillRank(SKILL_PERSUADE,oCaster)/8;
        int nLevel = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oCaster) + GetLevelByClass(CLASS_TYPE_SORCERER,oCaster) ;
        effect vSR1 = EffectVisualEffect(VFX_IMP_HEAD_FIRE);
        effect vSR2 = EffectVisualEffect(VFX_IMP_BREACH);
        effect vSR3 = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        effect vSR  = EffectLinkEffects(vSR1,vSR2);
        vSR  = EffectLinkEffects(vSR,vSR3);
        effect eSR  = EffectSpellResistanceDecrease(5+nPersuade);
        eSR  = SupernaturalEffect(eSR);
        int nDamage = 85+nLevel+d20();
        if(!GetHasSpellEffect(834,oTarget))
          {
           MothFireLink(oCaster,oTarget,nDamage);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, vSR, oTarget);
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSR, oTarget, 18.0);
          }
        else
          {
           FloatingTextStringOnCreature("<cðøþ>*Target already has this Effect!*</c>",oCaster,FALSE);
          }
}
void MothSpiderAttack(object oTarget, int nLevel)
{
    int nDamage1 = nLevel+d6(8)-5;
    int nDamage2 = nLevel+d6(8)-5;
    effect eImpact = EffectVisualEffect(VFX_IMP_DISEASE_S);
    float fDelay1 = GetRandomDelay();
    float fDelay2 = GetRandomDelay();
    effect eDamage1 = EffectDamage(nDamage1,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_FIVE);
    effect eDamage2 = EffectDamage(nDamage2,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_FIVE);
    DelayCommand(fDelay1+fDelay2,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage1,oTarget));
    DelayCommand(fDelay2+fDelay1,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage2,oTarget));
    DelayCommand(fDelay2+fDelay1,ApplyEffectToObject(DURATION_TYPE_INSTANT,eImpact,oTarget));
}
void MothBugsAttack(object oTarget, int nLevel)
{
    int nDamage1 = nLevel+d6(9)-5;
    int nDamage2 = nLevel+d6(9)-5;
    effect eImpact = EffectVisualEffect(VFX_IMP_DISEASE_S);
    float fDelay1 = GetRandomDelay();
    float fDelay2 = GetRandomDelay();
    effect eDamage1 = EffectDamage(nDamage1,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_SIX);
    effect eDamage2 = EffectDamage(nDamage2,DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_SIX);
    DelayCommand(fDelay1+fDelay2,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage1,oTarget));
    DelayCommand(fDelay2+fDelay1,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage2,oTarget));
    DelayCommand(fDelay2+fDelay1,ApplyEffectToObject(DURATION_TYPE_INSTANT,eImpact,oTarget));
}
void MothSuicideBomber(object oBoomer,object oOwner, int nDC=25)
{
    int nDamage;
    int nCasterLvl = MothGetCasterLevel(oOwner);
    effect eExplode1 = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_IMPLOSION);
    effect eExplode3 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eExplode = EffectLinkEffects(eExplode1,eExplode2);
    eExplode = EffectLinkEffects(eExplode3,eExplode);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    location lTarget = GetLocation(oBoomer);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFriendlyNPC(oOwner,oTarget))
        {
        SignalEvent(oTarget, EventSpellCastAt(oOwner, 325));
        nDamage = d8(nCasterLvl);
        if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_TRAP, oBoomer))
        {
         nDamage = nDamage/2;
        }
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
    DelayCommand(0.1,DestroyObject(oBoomer));
    DelayCommand(1.1,DestroyObject(oBoomer));
}
void MothRitualZombie(object oCaster, location lSpawn, int nDC=25)
{
    int nLevel = MothGetCasterLevel(oCaster);
    string sLevel = IntToString(nLevel);
    object oZombie = CreateObject(OBJECT_TYPE_CREATURE,"mothkegzombie",lSpawn);
    SetLocalObject(oZombie, "MY_MASTER", oCaster);
    DelayCommand(9.0,MothSuicideBomber(oZombie,oCaster,nDC));
}
void MothCharmPenalty(object oTarget, object oCaster, int nSpell)
{
    int nLvl = MothGetCasterLevel(oCaster)/10;
    effect ePenalty1 = EffectSavingThrowDecrease(SAVING_THROW_ALL,1+nLvl,SAVING_THROW_TYPE_SPELL);
    effect eDuration = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(ePenalty1,eDuration);
    if(!GetHasSpellEffect(nSpell,oTarget))
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(1+nLvl));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_CHARM), oTarget);
    }
}
void MothImmobilize(object oTarget, object oCaster, int nSpell, int nDuration)
{
    if(!GetIsDM(oTarget)){
       int nLvl = MothGetCasterLevel(oCaster)/4;
       effect ePenalty1 = EffectCutsceneImmobilize();
       if(!GetIsImmune(oTarget,IMMUNITY_TYPE_PARALYSIS,oCaster))
       {
          ePenalty1 = EffectParalyze();
          nLvl = nDuration;
       }
       if(nLvl<1){nLvl=1;}
       effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
       effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
       effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
       effect eLink = EffectLinkEffects(eDur2, eDur);
       eLink = EffectLinkEffects(eLink, eDur3);
       eLink = EffectLinkEffects(eLink, ePenalty1);
       if(!GetHasSpellEffect(nSpell,oTarget))
       {
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(nLvl));
       }
    }
}
void MothBloodyVisual(object oTarget)
{
    effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
    effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eVis3 = EffectVisualEffect(VFX_COM_BLOOD_CRT_WIMP);
    effect eVis4 = EffectVisualEffect(VFX_COM_BLOOD_REG_WIMP);
    effect eLink = EffectLinkEffects(eVis1,eVis2);
    eLink = EffectLinkEffects(eVis3,eLink);
    eLink = EffectLinkEffects(eVis4,eLink);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
}
void MothGreatOak(object oCaster,location lLocation)
{
    int nDuration = GetLevelByClass(CLASS_TYPE_DRUID,oCaster);
    string sCDKEY = GetPCPublicCDKey(oCaster);
    string sSpawn = "mothgreatoaka";
    string sFaction = GetLocalString(oCaster,"MothSetFactionInt");
    if(sFaction == "MothCleavenMember")
    {
      sSpawn = "mothgreatoakc";
    }
    object oOak = CreateObject(OBJECT_TYPE_CREATURE,sSpawn,lLocation,TRUE,sCDKEY);
    SetLocalObject(oOak, "MY_MASTER", oCaster);
    DelayCommand(0.5,SetLocalInt(oOak,"MOTHOAKLVL",nDuration));
    DelayCommand(RoundsToSeconds(nDuration*20),DestroyObject(oOak));
}
void MothSpawnGreatOak(object oCaster,location lLocation)
{
    effect eVis1 = EffectVisualEffect(460);
    effect eVis2 = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eLink = EffectLinkEffects(eVis1,eVis2);
    effect eGate = EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL);
    effect eLeaf = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
    location lTarget1 = GenerateNewLocationFromLocation(lLocation,3.0,0.0,10.0);
    location lTarget2 = GenerateNewLocationFromLocation(lLocation,3.0,75.0,75.0);
    location lTarget3 = GenerateNewLocationFromLocation(lLocation,1.0,150.0,150.0);
    location lTarget4 = GenerateNewLocationFromLocation(lLocation,3.0,175.0,175.0);
    location lTarget5 = GenerateNewLocationFromLocation(lLocation,3.0,250.0,250.0);
    location lTarget6 = GenerateNewLocationFromLocation(lLocation,3.0,40.0,40.0);
    location lTarget7 = GenerateNewLocationFromLocation(lLocation,3.0,100.0,100.0);
    location lTarget8 = GenerateNewLocationFromLocation(lLocation,3.0,150.0,150.0);
    location lTarget9 = GenerateNewLocationFromLocation(lLocation,3.0,200.0,200.0);
    DelayCommand(0.6,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget1));
    DelayCommand(1.2,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget2));
    DelayCommand(1.8,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget3));
    DelayCommand(2.4,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget4));
    DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget5));
    DelayCommand(3.6,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget6));
    DelayCommand(3.9,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget7));
    DelayCommand(4.2,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget8));
    DelayCommand(4.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLink,lTarget9));
    DelayCommand(2.5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eGate,lLocation));
    DelayCommand(5.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLeaf,lLocation));
    DelayCommand(5.0,MothGreatOak(oCaster,lLocation));
}
void MothLastWords(object oDeadman, location lLocation)
{
    object oCaster = oDeadman;
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nDamage;
    effect eExplode = EffectVisualEffect(VFX_FNF_HORRID_WILTING);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDam;
    if (nCasterLvl > 40)
    {
        nCasterLvl = 40;
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lLocation);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLocation);
    while (GetIsObjectValid(oTarget))
    {
            SignalEvent(oTarget,EventSpellCastAt(oDeadman,331));
            /*if(!MyResistSpell(oDeadman, oTarget))
            {*/
                    nDamage = d4(nCasterLvl);
                    /*if(MySavingThrow(SAVING_THROW_FORT, oTarget, nCasterLvl+4, SAVING_THROW_TYPE_SPELL, oDeadman))
                    {
                        nDamage = nDamage/2;
                    }*/
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
          /*  } */
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLocation);
    }
}
void MothRemoveDurationSpells(object oTarget)
{
  RemoveEffectsFromSpell(oTarget, 518); //Combust
  RemoveEffectsFromSpell(oTarget, 513); //Infestation of Maggots
  //RemoveEffectsFromSpell(oTarget, 832); //J. Persinne; removing RDD warlock effects no longer necessary.
  RemoveEffectsFromSpell(oTarget, 57); //J. Persinne; Added line to restore new combust effect of Fire Storm.
}
void MothImmobilizeOak(object oTarget, object oCaster, int nSpell, int nDuration)
{
    int nLvl = MothGetCasterLevel(oCaster)/2;
    effect ePenalty1 = EffectCutsceneImmobilize();
    if(!GetIsImmune(oTarget,IMMUNITY_TYPE_PARALYSIS,oCaster))
    {
     ePenalty1 = EffectParalyze();
     nLvl = nDuration*2;
    }
    if(nLvl<1){nLvl=1;}
    effect eDur = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur2 = EffectVisualEffect(VFX_DUR_ENTANGLE);
    effect eDur3 = EffectVisualEffect(VFX_DUR_TENTACLE);
    effect eLink = EffectLinkEffects(eDur2, eDur);
    eLink = EffectLinkEffects(eLink, eDur3);
    eLink = EffectLinkEffects(eLink, ePenalty1);
    if(!GetHasSpellEffect(nSpell,oTarget))
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(nLvl));
    }
}
void MothHoldGreatOak(object oTarget, object oCaster, int nSpell)
{
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(oCaster);
    int nDuration = nCasterLvl/4;
    if(!MothGetIsFortAlly(oTarget,oCaster))
    {
       SignalEvent(oTarget, EventSpellCastAt(oCaster, nSpell));
       if (!MyResistSpell(oCaster, oTarget))
       {
            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC()))
            {
                MothImmobilizeOak(oTarget,oCaster,nSpell,nDuration);
            }
        }
    }
}
void MothSummonShadow(location lSpawn,int nSpell, int nMeta)
{
    string sShadow;
    int nRounds;
    if(nSpell== 344)
    {
     sShadow="mothsummonshadow";
     nRounds=2;
    }
    else if(nSpell== 349)
    {
     sShadow="mothsummonshado2";
     nRounds=4;
    }
    else if(nSpell== 324)
    {
     sShadow="mothsummonshado3";
     nRounds=8;
    }
    if(nMeta==TRUE)
    {
     nRounds = nRounds*2;
    }
    effect eSummon = EffectSummonCreature(sShadow,VFX_FNF_SUMMON_UNDEAD,0.5,1);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lSpawn, RoundsToSeconds(nRounds));
}
int MothGetFavoredAberration(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredAnimal(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredBeast(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_BEAST,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredConstruct(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredDragon(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredDwarf(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_DWARF,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredElemental(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredElf(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_ELF,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredFey(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_FEY,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredGiant(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_GIANT,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredGnome(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_GNOME,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredGoblinoid(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredHalfelf(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredHalfling(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredHalforc(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredHuman(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredMagicalBeast(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredMonstrous(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredOrc(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_ORC,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredOutsider(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredReptilian(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredShapechanger(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredUndead(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
int MothGetFavoredVermin(object oCaster=OBJECT_SELF)
{
   if(GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN,oCaster))
   {
    return TRUE;
   }
   return FALSE;
}
void MothSetFavoredDamage(int nDuration, effect eDamage, object oCaster=OBJECT_SELF)
{
    if(MothGetFavoredAberration(oCaster))
    {
    effect eAberration = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_ABERRATION);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAberration, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredAnimal(oCaster))
    {
    effect eAnimal = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_ANIMAL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAnimal, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredBeast(oCaster))
    {
    effect eBeast = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_BEAST);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeast, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredConstruct(oCaster))
    {
    effect eConstruct = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_CONSTRUCT);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eConstruct, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredDragon(oCaster))
    {
    effect eDragon = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_DRAGON);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDragon, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredDwarf(oCaster))
    {
    effect eDwarf = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_DWARF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDwarf, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredElemental(oCaster))
    {
    effect eElemental = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_ELEMENTAL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElemental, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredElf(oCaster))
    {
    effect eElf = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_ELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eElf, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredFey(oCaster))
    {
    effect eFey = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_FEY);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFey, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredGiant(oCaster))
    {
    effect eGiant = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_GIANT);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGiant, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredGnome(oCaster))
    {
    effect eGnome = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_GNOME);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGnome, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredGoblinoid(oCaster))
    {
    effect eGoblinoid = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HUMANOID_GOBLINOID);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGoblinoid, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredHalfelf(oCaster))
    {
    effect eHalfelf = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HALFELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHalfelf, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredHalfling(oCaster))
    {
    effect eHalfling = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HALFLING);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHalfling, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredHalforc(oCaster))
    {
    effect eHalforc = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HALFORC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHalforc, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredHuman(oCaster))
    {
    effect eHuman = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HUMAN);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHuman, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredMagicalBeast(oCaster))
    {
    effect eMagicalBeast = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_MAGICAL_BEAST);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMagicalBeast, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredMonstrous(oCaster))
    {
    effect eMonstrous = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HUMANOID_MONSTROUS);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMonstrous, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredOrc(oCaster))
    {
    effect eOrc = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HUMANOID_ORC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOrc, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredOutsider(oCaster))
    {
    effect eOutsider = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_OUTSIDER);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOutsider, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredReptilian(oCaster))
    {
    effect eReptilian = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_HUMANOID_REPTILIAN);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eReptilian, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredShapechanger(oCaster))
    {
    effect eShapechanger = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_SHAPECHANGER);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShapechanger, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredUndead(oCaster))
    {
    effect eUndead = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_UNDEAD);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUndead, oCaster, RoundsToSeconds(nDuration+5));
    }
    if(MothGetFavoredVermin(oCaster))
    {
    effect eVermin = VersusRacialTypeEffect(eDamage,RACIAL_TYPE_VERMIN);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVermin, oCaster, RoundsToSeconds(nDuration+5));
    }
}
// *  return TRUE if oItem is an Armor. Includes Creature Armor (Hides).
int MothGetIsArmor(object oItem)
{
    int nItem = GetBaseItemType(oItem);
    if(nItem == BASE_ITEM_ARMOR ||
       nItem == BASE_ITEM_CREATUREITEM)
   {
        return TRUE;
   }
   return FALSE;
}
int MothDecreaseOnHitSpellChance()
{
   object oItem          = GetSpellCastItem();
   object oSpellTarget   = GetSpellTargetObject();
   if(GetIsObjectValid(oItem))
   {
   if(GetIsObjectValid(oSpellTarget))
   {
    if(IPGetIsMeleeWeapon(oItem) || GetWeaponRanged(oItem) || IPGetIsProjectile(oItem))
     {
     if(!GetIsPC(oSpellTarget))
       {
       if(MothGetIsSpellHostile(GetSpellId()))
        {
        int nDice = d100();
        if(nDice<85)
        {
         return FALSE;
        }
       }
      }
     }
    }
   }
  return TRUE;
}
int MothDecreaseOnHitSpellChancePC()
{
   object oItem          = GetSpellCastItem();
   object oSpellTarget   = GetSpellTargetObject();
   if(GetIsObjectValid(oItem))
   {
   if(GetIsObjectValid(oSpellTarget))
   {
    if( IPGetIsMeleeWeapon(oItem) ||
        GetWeaponRanged(oItem) ||
        IPGetIsProjectile(oItem) ||
        MatchShield(oItem) ||
        MothGetIsArmor(oItem)
     )
     {
       if(MothGetIsSpellHostile(GetSpellId()))
        {
        int nDice = d100();
        if(nDice<75)
        {
         return FALSE;
        }
       }
     }
    }
   }
  return TRUE;
}
int MothCheckIsDagger(object oDagger)
{
   if(GetResRef(oDagger)=="x2_s_faerie001")
   {
   return TRUE;
   }
  return FALSE;
}
void MothSetDaggerBuff(object oDagger, int nLevel)
{
    int nBonus = nLevel/5;
    int nDamage = IPGetDamageBonusConstantFromNumber(nBonus);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(1,9.0),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillIncrease(SKILL_DISCIPLINE,11),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillIncrease(SKILL_LISTEN,5+nLevel),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSkillIncrease(SKILL_SPOT,5+nLevel),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageIncrease(nDamage,DAMAGE_TYPE_SLASHING),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAttackIncrease(nBonus),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectACIncrease(nBonus,AC_NATURAL_BONUS),oDagger);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAbilityIncrease(ABILITY_CONSTITUTION,nBonus),oDagger);
}
void MothGiveDaggerBonus(int nLevel)
{
    object oDagger = GetFirstObjectInArea();
    while(GetIsObjectValid(oDagger))
    {
        if (GetAssociateType(oDagger)==ASSOCIATE_TYPE_SUMMONED && GetMaster(oDagger) == OBJECT_SELF)
        {
           if(MothCheckIsDagger(oDagger))
           {
            MothSetDaggerBuff(oDagger,nLevel);
           }
        }
       oDagger = GetNextObjectInArea();
    }
}
void MothGreaterRestoration(object oTarget)
{
    MothRemoveSupernaturalStun(oTarget);
    MothRemoveDurationSpells(oTarget);
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_PETRIFY ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED ||
            GetEffectType(eBad) == EFFECT_TYPE_MISS_CHANCE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_FAILURE ||
            GetEffectType(eBad) == EFFECT_TYPE_CUTSCENEIMMOBILIZE)
        {
            if(GetEffectSubType(eBad)!=SUBTYPE_SUPERNATURAL)
                RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
    MothRemoveSupernaturalPermanentAbilityDecrease(oTarget);
    MothRemovePetrify(oTarget);
}
void MothSetFreedom(object oTarget)
{
    effect eLook = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLook))
    {
        if(GetEffectType(eLook) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eLook) == EFFECT_TYPE_ENTANGLE ||
            GetEffectType(eLook) == EFFECT_TYPE_SLOW ||
            GetEffectType(eLook) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
        {
            RemoveEffect(oTarget, eLook);
        }
        eLook = GetNextEffect(oTarget);
    }
}
int MothStopRacialSpellCheck(object oTarget)
{
   int nSpell = GetSpellId();
   if(nSpell==633)
   {
       if (GetIsPlayableRacialType(oTarget) ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_ORC ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN)
       {
        return TRUE;
       }
       else
       {
        return FALSE;
       }
      return FALSE;
   }
   else if(nSpell==634)
   {
       if (GetIsPlayableRacialType(oTarget) ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_ORC ||
           GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN)
       {
        return FALSE;
       }
       else if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
       {
        return FALSE;
       }
       else
       {
        return TRUE;
       }
      return FALSE;
   }
   else if(nSpell==635)
   {
         if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
         {
          return TRUE;
         }
         else
         {
          return FALSE;
         }
   }
  return FALSE;
}
