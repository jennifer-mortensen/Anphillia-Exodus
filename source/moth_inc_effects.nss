// Include file for adding effects to PC as they log on or after they died.
// ------------------------------------------------------------------------

#include "_inc_xp"

// * Applies cleric domains bonuses
void MothEnterDomains(object oPC, int nFeedback = TRUE);
// * Applies other fun bonuses for various classes and feats.
//Also activate rebuke funtion to Turn Undead.
//It also cleans up in the Timelocks.
void MothEnterBonus(object oPC, int nFeedback = TRUE);
// * Adds wings to a level 9 or higher RDD since my overrides remove the Dragonic_abilities feat.
//void MothRDDWings(object oPC,int nMinimumLevel);
// * Removes any permenent,supernatural effect that's been applied by an
//invalid object/invalid spell and as such returns to a (-1) as far as spell ID is concerned.
void MothRemoveSubraceEffects(object oCaster, object oTarget);
// * Removes bonuses from previous login.
void MothRemoveSubraceEffects2(object oTarget);
// * Once used for Subrace adjustment. Since I changed system this is now just
//a regular RemoveEffect() function.Too lazy to restore my changes to all the scripts...
void MothRemoveEffects(object oPC);
// * Grants any object permanent buffs. Call this command in a creatures OnSpawn script.
//nBuff is the value you wish to increase every stat with, except Temp Hp which is nBuff*10,
//and SR which is nBuff*5. Useful to boost Summons and whatnot.
void MothPermanentNPCBuff(int nBuff);
// * Removes any Player Corpses from oPC.
void MothRemoveCorpses(object oPC);
// * Returns TRUE if oPC has the wrong Orb.
int MothGetHasOldOrb(object oPC);
// * Removes the wrong orb from oPC. Handled by MothUpdateOrb().
void MothDestroyOldOrb(object oPC);
// * Gives oPC the correct Orb. Handled by MothLogin().
void MothUpdateOrb(object oPC);
// * Call on Login, Level up and Death to make sure Half-orcs have the correct special race item.
void MothGiveHalfOrcItem(object oPC);
// * Handles a series of item checks. Both replacing, removing and giving items.
//Run in OnEnter.
void MothLogin(object oPC);
// * Removes ANY disease
void MothRemoveDisease(object oTarget);
// * Adds bonuses to NPC guards. Use in OnSpawn.
void MothGuardBuff(object oTarget=OBJECT_SELF, int nElite = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothSelfConcealment(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothDirtyFighting(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothArtist(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothBlooded(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothBullheaded(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothCourteousMagocracy(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothDeneirsEye(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothLuckOfHeroes(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothSilverPalm(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothSnakeBlood(object oPC, int nFeedback = TRUE);
// * Feat enhancement. Handles via MothBonuses();
void MothStrongSoul(object oPC, int nFeedback = TRUE);
// * Skill enhancement. Handles via MothBonuses();
void MothParryConcealment(object oPC, int nFeedback = TRUE);
// * Adds bonus AB to pure fighters. Handles via MothBonuses();
void MothAB(object oPC, int nFeedback = TRUE);
// * Adds bonuses to the players as they enter the server, level up or die (delevel).
void MothBonuses(object oPC, int nFeedback = TRUE);
// * Removes Stunning Fist from oTarget
void MothRemoveSupernaturalStun(object oTarget);

void MothEnterDomains(object oPC, int nFeedback = TRUE)
{
    int nCleric = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
    int nDomainBonus;
    string sTrickeryDom, sTravelDom, sMagicDom, sHealingDom, sKnowledgeDom, sEvilDom, sGoodDom, sAirDom, sFireDom, sWaterDom, sPlantDom;
    effect eTrickeryDom, eTravelDom, eMagicDom, eKnowledgeDom, eEvilDom, eGoodDom, eAirDom, eFireDom, eWaterDom, ePlantDom;

    if(GetHasFeat(FEAT_TRICKERY_DOMAIN_POWER,oPC))
    {
        nDomainBonus = nCleric / 4;
        if(nDomainBonus > 0){
        eTrickeryDom = SupernaturalEffect(EffectSavingThrowIncrease(nDomainBonus, SAVING_THROW_ALL,SAVING_THROW_TYPE_TRAP));
        sTrickeryDom = "<c¥¥¥>[Server] Trickery Domain Detected. +" + IntToString(nDomainBonus) + " Saves versus Traps Applied.</c>";
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, eTrickeryDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sTrickeryDom)); }
    }
    if(GetHasFeat(FEAT_TRAVEL_DOMAIN_POWER,oPC))
    {
        eTravelDom = SupernaturalEffect(EffectSpellImmunity(SPELL_HOLD_MONSTER));
        eTravelDom = EffectLinkEffects(eTravelDom, SupernaturalEffect(EffectSpellImmunity(SPELL_HOLD_PERSON)));
        if(nCleric < 40)
        {
            sTravelDom = "<c¥¥¥>[Server] Travel Domain Detected. Hold Person-spell Immunity applied.</c>";
        }
        else
        {
            sTravelDom = "<c¥¥¥>[Server] Travel Domain Detected. Hold Person-spell Immunity applied.  All 'Haste' spells are cast as Mass Haste.</c>";
        }
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, eTravelDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sTravelDom));
    }
    if(GetHasFeat(FEAT_MAGIC_DOMAIN_POWER,oPC))
    {
        nDomainBonus = nCleric / 3;
        if(nDomainBonus > 0){
        eMagicDom = SupernaturalEffect(EffectSkillIncrease(SKILL_SPELLCRAFT, nDomainBonus));
        sMagicDom = "<c¥¥¥>[Server] Magic Domain Detected. You have gained a +" + IntToString(nDomainBonus) + " bonus to Spellcraft.</c>";
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, eMagicDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sMagicDom)); }
    }
    if(GetHasFeat(FEAT_HEALING_DOMAIN_POWER,oPC))
    {
        nDomainBonus = 110 + (nCleric / 10) * 10;
        sHealingDom = "<c¥¥¥>[Server] Healing Domain Detected. All 'Cure' and 'Heal' spells are now cast at " + IntToString(nDomainBonus) + "% effectiveness.</c>";
        DelayCommand(1.0, SendMessageToPC(oPC, sHealingDom));
    }
    if(GetHasFeat(FEAT_KNOWLEDGE_DOMAIN_POWER,oPC))
    {
        nDomainBonus = nCleric / 4;
        if(nDomainBonus > 0){
        eKnowledgeDom = SupernaturalEffect(EffectSkillIncrease(SKILL_LORE, nDomainBonus));
        eKnowledgeDom = EffectLinkEffects(eKnowledgeDom, SupernaturalEffect(EffectSkillIncrease(SKILL_LISTEN, nDomainBonus)));
        eKnowledgeDom = EffectLinkEffects(eKnowledgeDom, SupernaturalEffect(EffectSkillIncrease(SKILL_SEARCH, nDomainBonus)));
        eKnowledgeDom = EffectLinkEffects(eKnowledgeDom, SupernaturalEffect(EffectSkillIncrease(SKILL_SPOT, nDomainBonus)));
        sKnowledgeDom = "<c¥¥¥>[Server] Knowledge Domain Detected. You have gained a +" + IntToString(nDomainBonus) + " bonus to Lore, Listen, Search, and Spot.</c>";
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, eKnowledgeDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sKnowledgeDom));  }
    }
    if(GetHasFeat(FEAT_EVIL_DOMAIN_POWER,oPC))
    {
        if(nCleric < 40)
        {
            nDomainBonus = nCleric / 2;
        }
        else
        {
            nDomainBonus = 25;
        }
        sEvilDom = "<c¥¥¥>[Server] Evil Domain Detected. Aid and Shield of Faith Self-Targeting activated.";
        if(nDomainBonus > 0)
        {
            sEvilDom += " " + IntToString(nDomainBonus) + "% Negative Damage Immunity applied.</c>";
                    eEvilDom = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, nDomainBonus));
            ApplyEffectToObject (DURATION_TYPE_PERMANENT, eEvilDom, oPC);
        }
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sEvilDom));
    }
    if(GetHasFeat(FEAT_GOOD_DOMAIN_POWER,oPC))
    {
        if(nCleric < 40)
        {
            nDomainBonus = nCleric / 2;
        }
        else
        {
            nDomainBonus = 25;
        }
        sGoodDom = "<c¥¥¥>[Server] Good Domain Detected. Bless and Prayer Self-Targeting activated.";
        if(nDomainBonus > 0)
        {
            sGoodDom += " " + IntToString(nDomainBonus) + "% Positive Damage Immunity applied.</c>";
            eGoodDom = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, nDomainBonus));
            ApplyEffectToObject (DURATION_TYPE_PERMANENT, eGoodDom, oPC);
        }
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sGoodDom));
    }
    if(GetHasFeat(FEAT_AIR_DOMAIN_POWER,oPC))
    {
        if(nCleric < 40)
        {
            nDomainBonus = nCleric;
        }
        else
        {
            nDomainBonus = 50;
        }
        if(nDomainBonus > 0){
        eAirDom = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, nDomainBonus));
        sAirDom = "<c¥¥¥>[Server] Air Domain Detected. " + IntToString(nDomainBonus) + "% Electrical Damage Immunity applied.</c>";
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAirDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sAirDom));}
    }
    if(GetHasFeat(FEAT_FIRE_DOMAIN_POWER,oPC))
    {
        if(nCleric < 40)
        {
            nDomainBonus = nCleric;
        }
        else
        {
            nDomainBonus = 50;
        }
        if(nDomainBonus > 0){
        eFireDom = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, nDomainBonus));
        sFireDom = "<c¥¥¥>[Server] Fire Domain Detected. " + IntToString(nDomainBonus) + "% Fire Damage Immunity applied.</c>";
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, eFireDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sFireDom));}
    }
    if(GetHasFeat(FEAT_WATER_DOMAIN_POWER,oPC))
    {
        if(nCleric < 40)
        {
            nDomainBonus = nCleric / 2;
        }
        else
        {
            nDomainBonus = 25;
        }
        if(nDomainBonus > 0){
        eWaterDom = SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, nDomainBonus));
        sWaterDom = "<c¥¥¥>[Server] Water Domain Detected. " + IntToString(nDomainBonus) + "% Cold Damage Immunity applied.</c>";
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, eWaterDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sWaterDom));}
    }
    if(GetHasFeat(FEAT_PLANT_DOMAIN_POWER, oPC) && nCleric >= 10)
    {
        nDomainBonus = nCleric / 10;
        if(nCleric == 40)
            nDomainBonus++;
        if(nDomainBonus > 0){
        ePlantDom = SupernaturalEffect(EffectRegenerate(nDomainBonus, 6.0));
        sPlantDom = "<c¥¥¥>[Server] Plant Domain Detected. +" + IntToString(nDomainBonus) + " Regeneration applied.</c>";
        ApplyEffectToObject (DURATION_TYPE_PERMANENT, ePlantDom, oPC);
        if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sPlantDom));}
    }
}
// Applies other fun bonuses for various classes and feats.
// Also activate rebuke funtion to Turn Undead.
// It also cleans up in the Timelocks.
void MothEnterBonus(object oPC, int nFeedback = TRUE)
{
    int nAlign = GetAlignmentGoodEvil(oPC);
    int nDamageIncrease;
    int nFighterLvl = GetLevelByClass(CLASS_TYPE_FIGHTER,oPC);
    int nBGLvl = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
    int nCoTLvl = GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC);
    int nAssassinLevel = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
    string sPCMessage;

    if (nFighterLvl >= 15)
           {
            int nFighter = 6 + (nFighterLvl/2);
            effect eFighter1 = SupernaturalEffect(EffectSkillIncrease(SKILL_DISCIPLINE,nFighter));
            ApplyEffectToObject (DURATION_TYPE_PERMANENT, eFighter1, oPC);
            if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Dedicated Fighter Detected. Discipline Skill Bonus Activated.</c>"));
            }
    if (nBGLvl)
           {
            nDamageIncrease = 1 + (nBGLvl / 10);
            sPCMessage = "<c¥¥¥>[Server] Blackguard Level Detected. +" + IntToString(nDamageIncrease) + " Negative Damage Bonus Activated.</c>";
            if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC,"<c¥¥¥>[Server] Blackguard Level Detected. Rebuke Undead Function Activated.</c>"));
            if (nFeedback) SendMessageToPC(oPC, sPCMessage);
            switch (nDamageIncrease)
            {
            case 1:
                nDamageIncrease = DAMAGE_BONUS_1;
                break;
            case 2:
                nDamageIncrease = DAMAGE_BONUS_2;
                break;
            case 3:
                nDamageIncrease = DAMAGE_BONUS_3;
                break;
            case 4:
                nDamageIncrease = DAMAGE_BONUS_4;
                break;
            }
            effect eBG = SupernaturalEffect(EffectDamageIncrease(nDamageIncrease, DAMAGE_TYPE_NEGATIVE));
            ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBG, oPC);
            SetLocalInt(oPC,"REBUKE_UNDEAD",TRUE);

            }
    if (nAssassinLevel)
           {
            nDamageIncrease = 1 + (nAssassinLevel / 10);
            sPCMessage = "<c¥¥¥>[Server] Assassin Level Detected. +" + IntToString(nDamageIncrease) + " Acid Damage Bonus Activated.</c>";
            if (nFeedback) SendMessageToPC(oPC, sPCMessage);
            switch (nDamageIncrease)
            {
            case 1:
                nDamageIncrease = DAMAGE_BONUS_1;
                break;
            case 2:
                nDamageIncrease = DAMAGE_BONUS_2;
                break;
            case 3:
                nDamageIncrease = DAMAGE_BONUS_3;
                break;
            case 4:
                nDamageIncrease = DAMAGE_BONUS_4;
                break;
            }
            effect eAssassin = SupernaturalEffect(EffectDamageIncrease(nDamageIncrease, DAMAGE_TYPE_ACID));
            ApplyEffectToObject (DURATION_TYPE_PERMANENT, eAssassin, oPC);
            }
    if (nCoTLvl)
           {
            nDamageIncrease = 1 + (nCoTLvl / 10);
            sPCMessage = "<c¥¥¥>[Server] Champion of Torm Level Detected. +" + IntToString(nDamageIncrease) + " Divine Damage Bonus Activated.</c>";
            if (nFeedback) DelayCommand(1.0, SendMessageToPC(oPC, sPCMessage));
            switch (nDamageIncrease)
            {
            case 1:
                nDamageIncrease = DAMAGE_BONUS_1;
                break;
            case 2:
                nDamageIncrease = DAMAGE_BONUS_2;
                break;
            case 3:
                nDamageIncrease = DAMAGE_BONUS_3;
                break;
            case 4:
                nDamageIncrease = DAMAGE_BONUS_4;
                break;
            }
            effect eCoT = SupernaturalEffect(EffectDamageIncrease(nDamageIncrease, DAMAGE_TYPE_DIVINE));
            ApplyEffectToObject (DURATION_TYPE_PERMANENT, eCoT, oPC);
           }
    if(GetLevelByClass(CLASS_TYPE_CLERIC, oPC) && nAlign == ALIGNMENT_EVIL)
           {
            SetLocalInt(oPC,"REBUKE_UNDEAD",TRUE);
            if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Evil Cleric Level Detected. Rebuke Undead Function Activated.</c>"));
            }
    if(GetLevelByClass(CLASS_TYPE_CLERIC, oPC) && nAlign == ALIGNMENT_GOOD)
           {
            if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Good Cleric Level Detected. Rebuke Undead Function Deactivated.</c>"));
            }
}
// Adds wings to a level 9 or higher RDD since my overrides remove the Dragonic_abilities feat.
//
/*void MothRDDWings(object oPC,int nMinimumLevel)
{
     int nRDDLvl = GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
     if(nRDDLvl<2)
     {
     return;
     }
     if(nRDDLvl>=2)
     {
     SetCreatureWingType(CREATURE_WING_TYPE_NONE,oPC);
     SetCreatureTailType(CREATURE_WING_TYPE_NONE,oPC);
       if(nRDDLvl>=nMinimumLevel)
       {
       DelayCommand(0.1,SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,oPC));
       }
     }
}*/
// Removes any permenent,supernatural effect that's been applied by an
// invalid object/invalid spell and as such returns to a (-1) as far as spell ID is concerned.
//
void MothRemoveSubraceEffects(object oCaster, object oTarget)
{
    //Declare major variables
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(-1, oTarget))
    {
        //Search through the valid effects on the target.
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE)
        {
            if (GetEffectCreator(eAOE) == oCaster)
            {
                //If the effect was created by the spell then remove it
                if(GetEffectSpellId(eAOE) == -1 &&
                   GetEffectDurationType(eAOE) == DURATION_TYPE_PERMANENT &&
                   GetEffectSubType(eAOE) == SUBTYPE_SUPERNATURAL)
                {
                    RemoveEffect(oTarget, eAOE);
                    bValid = TRUE;
                }
            }
            //Get next effect on the target
            eAOE = GetNextEffect(oTarget);
        }
    }
}
//Removes bonuses from previous login.
void MothRemoveSubraceEffects2(object oTarget)
{
  effect eLook = GetFirstEffect(oTarget);
  while (GetIsEffectValid(eLook)) {
    if (GetEffectSpellId(eLook) == -1 &&
        GetEffectDurationType(eLook) == DURATION_TYPE_PERMANENT &&
        GetEffectSubType(eLook) == SUBTYPE_SUPERNATURAL)
      RemoveEffect(oTarget, eLook);
    eLook = GetNextEffect(oTarget);
  }
}
// Once used for Subrace adjustment. Since I changed system this is now just
// a regular RemoveEffect() function.Too lazy to restore my changes to all the scripts...
void MothRemoveEffects(object oPC)
{
    object oTarget = oPC;
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int bValid;
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
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE)
            {
                RemoveEffect(oTarget, eBad);
            }
        eBad = GetNextEffect(oTarget);
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}
// Grants any object permanent buffs. Call this command in a creatures OnSpawn script.
// nBuff is the value you wish to increase every stat with, except Temp Hp which is nBuff*10,
// and SR which is nBuff*5. Useful to boost Summons and whatnot.
void MothPermanentNPCBuff(int nBuff)
{
    object oObject = OBJECT_SELF;
    object oMaster = GetMaster(oObject);
    if(!GetIsPC(oMaster)){return;}
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nBuff);
    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, nBuff);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, nBuff);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, nBuff);
    effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE,nBuff);
    effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, nBuff);
    effect eAcc = EffectACIncrease(nBuff,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect eDmg = EffectDamageIncrease(nBuff,DAMAGE_TYPE_BLUDGEONING);
    effect eDmg2 = EffectAttackIncrease(nBuff,ATTACK_BONUS_MISC);
    effect eSki = EffectSkillIncrease(SKILL_ALL_SKILLS,nBuff);
    effect eSav = EffectSavingThrowIncrease(SAVING_THROW_ALL,nBuff,SAVING_THROW_TYPE_ALL);
    effect eSR = EffectSpellResistanceIncrease(nBuff*5);
    effect eTmp = EffectTemporaryHitpoints(nBuff*10);
            effect eLink = EffectLinkEffects(eStr, eCha);
            eLink = EffectLinkEffects(eLink, eCon);
            eLink = EffectLinkEffects(eLink, eDex);
            eLink = EffectLinkEffects(eLink, eInt);
            eLink = EffectLinkEffects(eLink, eWis);
            eLink = EffectLinkEffects(eLink, eAcc);
            eLink = EffectLinkEffects(eLink, eDmg);
            eLink = EffectLinkEffects(eLink, eDmg2);
            eLink = EffectLinkEffects(eLink, eSki);
            eLink = EffectLinkEffects(eLink, eSav);
            eLink = EffectLinkEffects(eLink, eSR);
            eLink = SupernaturalEffect(eLink);
            eTmp = ExtraordinaryEffect(eTmp);
    DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oObject));
    DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eTmp, oObject));
}
void MothConversationKickIt(object oPC)
{
   int nDice = d10();
   int nDamage = d6(5);
   effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
   FloatingTextStringOnCreature("<cðøþ>*You kick it!*</c>",oPC,FALSE);
   if(nDice==1)
   {
   DelayCommand(1.1,FloatingTextStringOnCreature("<cðøþ>*...You hurt your foot!*</c>",oPC,FALSE));
   DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));
   }
   else
   {
   DelayCommand(1.1,FloatingTextStringOnCreature("<cðøþ>*...Nothing happeneds!*</c>",oPC,FALSE));
   }
}
void MothRemoveCorpses(object oPC)
{
    object oItemCorpses = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItemCorpses))
    {
      string sResRef = GetResRef(oItemCorpses);
      if(sResRef == "playercorpse")
      {
        DestroyObject(oItemCorpses);
      }
      oItemCorpses = GetNextItemInInventory(oPC);
    }
}
//Call on Login, Level up and Death to make sure Half-orcs have the correct special race item.
void MothGiveHalfOrcItem(object oPC)
{

}
void MothLogin(object oPC)
{
if (!GetIsPC(oPC)) return;
int GiveOnce = GetLocalInt(oPC, "MothLoginOnce");
if (GiveOnce==TRUE) return;
SetLocalInt(oPC, "MothLoginOnce", TRUE);
DelayCommand(3.0,FloatingTextStringOnCreature("<cþŒ >*Overrides needed to access additions and changes to Classes, Spells, Abilities and Shapes can be downloaded from our forum at http://anphillia.forumotion.com/ (Last Updated: Feb. 23, 2010)*</c>", oPC));
MothRemoveCorpses(oPC);
object oTake6 = GetItemPossessedBy(oPC,"cleavenrelic");
object oTake7 = GetItemPossessedBy(oPC,"axfellrelic");
object oTake22 = GetItemPossessedBy(oPC,"mothtrackertool");
object oTake23 = GetItemPossessedBy(oPC,"mothdruidsear");
object oItem2 = GetItemPossessedBy(oPC,"mothsditem");
if(GetIsObjectValid(oTake6))
  {
    DestroyObject(oTake6);
  }
if(GetIsObjectValid(oTake7))
  {
    DestroyObject(oTake7);
  }
if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC) >=5)
  {
    if(!GetIsObjectValid(oItem2))
    {
    CreateItemOnObject("mothsditem", oPC);
    }
  }
if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>14)
  {
    if(!GetIsObjectValid(oTake22))
      {
      CreateItemOnObject("mothtrackertool", oPC);
      }
  }
if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)>20)
  {
    if(!GetIsObjectValid(oTake23))
      {
      CreateItemOnObject("mothdruidsear", oPC);
      }
  }
}

//Removes ANY disease
void MothRemoveDisease(object oTarget)
{
         effect eBad = GetFirstEffect(oTarget);
         while(GetIsEffectValid(eBad))
         {
            if (GetEffectType(eBad) == EFFECT_TYPE_DISEASE)
            {
                    RemoveEffect(oTarget, eBad);
            }
            eBad = GetNextEffect(oTarget);
           }
}
void MothGuardBuff(object oTarget=OBJECT_SELF, int nElite = TRUE)
{
     int nDamageIncrease;
     if(nElite == TRUE)
        nDamageIncrease = 3;
     else
        nDamageIncrease = 1;

     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectUltravision(),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamageIncrease + 2,DAMAGE_TYPE_POSITIVE),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamageIncrease,DAMAGE_TYPE_ACID),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamageIncrease,DAMAGE_TYPE_COLD),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamageIncrease,DAMAGE_TYPE_ELECTRICAL),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamageIncrease,DAMAGE_TYPE_FIRE),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamageIncrease,DAMAGE_TYPE_SONIC),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSeeInvisible(),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillIncrease(SKILL_DISCIPLINE,6),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSkillIncrease(SKILL_CONCENTRATION,12),oTarget);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellResistanceIncrease(34),oTarget);
}
void MothSelfConcealment(object oPC, int nFeedback = TRUE)
{

    if(GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_50,oPC)||
       GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_40,oPC)||
       GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_30,oPC)||
       GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_20,oPC)||
       GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_10,oPC)
    )
    {
        int nConceal = 53;
        if(FEAT_EPIC_SELF_CONCEALMENT_20){nConceal=56;}
        if(FEAT_EPIC_SELF_CONCEALMENT_30){nConceal=59;}
        if(FEAT_EPIC_SELF_CONCEALMENT_40){nConceal=62;}
        if(FEAT_EPIC_SELF_CONCEALMENT_50){nConceal=65;}
        effect eConcealment = EffectConcealment(nConceal);
        eConcealment = SupernaturalEffect(eConcealment);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eConcealment, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Self Concealment Feat detected. A bonus Concealment of "+IntToString(nConceal)+"% has been applied.</c>"));
        }
    }
    else return;
}
void MothDirtyFighting(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_DIRTY_FIGHTING,oPC) == TRUE)
    {
        int nMeleeLvl = GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)+
                 GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)+
                 GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC)+
                 GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)+
                 GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oPC)+
                 GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)+
                 GetLevelByClass(CLASS_TYPE_MONK,oPC)+
                 GetLevelByClass(CLASS_TYPE_PALADIN,oPC)+
                 GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC)+
                 GetLevelByClass(CLASS_TYPE_RANGER,oPC)+
                 GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC)+
                 GetLevelByClass(CLASS_TYPE_HARPER,oPC);
        int nMeleeDmg;
        if(nMeleeLvl <=24){nMeleeDmg = DAMAGE_BONUS_1;}
        else if(nMeleeLvl <=34){nMeleeDmg = DAMAGE_BONUS_2;}
        else if(nMeleeLvl <=39){nMeleeDmg = DAMAGE_BONUS_3;}
        else if(nMeleeLvl ==40){nMeleeDmg = DAMAGE_BONUS_4;}
        effect eDirtyFighting = EffectDamageIncrease(nMeleeDmg,DAMAGE_TYPE_BLUDGEONING);
        eDirtyFighting = SupernaturalEffect(eDirtyFighting);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eDirtyFighting, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Dirty Fighting Feat Detected. Damage Bonus Activated.</c>"));
        }
    }
    else return;
}
void MothArtist(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_ARTIST,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=9){return;}
        else if(nLvl <=19){nBonus = 1;}
        else if(nLvl <=29){nBonus = 2;}
        else if(nLvl <=39){nBonus = 3;}
        else if(nLvl ==40){nBonus = 4;}
        effect eBonus1 = EffectSkillIncrease(SKILL_PERFORM,nBonus);
        effect eBonus2 = EffectSkillIncrease(SKILL_PERSUADE,nBonus);
        effect eBonus3 = EffectSkillIncrease(SKILL_SPOT,nBonus);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus  = EffectLinkEffects(eBonus,eBonus3);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Artist Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothBlooded(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_BLOODED,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=9){return;}
        else if(nLvl <=19){nBonus = 1;}
        else if(nLvl <=29){nBonus = 2;}
        else if(nLvl <=39){nBonus = 3;}
        else if(nLvl ==40){nBonus = 4;}
        nBonus = nBonus*2;
        effect eBonus1 = EffectSkillIncrease(SKILL_SPOT,nBonus);
        effect eBonus2 = EffectSkillIncrease(SKILL_LISTEN,nBonus);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Blooded Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothBullheaded(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_BULLHEADED,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=9){return;}
        else if(nLvl <=19){nBonus = 1;}
        else if(nLvl <=29){nBonus = 2;}
        else if(nLvl <=39){nBonus = 3;}
        else if(nLvl ==40){nBonus = 4;}
        effect eBonus1 = EffectSavingThrowIncrease(SAVING_THROW_WILL,nBonus,SAVING_THROW_TYPE_ALL);
        nBonus = nBonus*2;
        effect eBonus2 = EffectSkillIncrease(SKILL_CONCENTRATION,nBonus);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Bullheaded Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothCourteousMagocracy(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_COURTLY_MAGOCRACY,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=9){return;}
        else if(nLvl <=19){nBonus = 1;}
        else if(nLvl <=29){nBonus = 2;}
        else if(nLvl <=39){nBonus = 3;}
        else if(nLvl ==40){nBonus = 4;}
        nBonus = nBonus*2;
        effect eBonus1 = EffectSkillIncrease(SKILL_LORE,nBonus);
        effect eBonus2 = EffectSkillIncrease(SKILL_SPELLCRAFT,nBonus);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Courteous Magocracy Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothDeneirsEye(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_DENEIRS_EYE,oPC)==TRUE)
    {
        int nLvl = GetLevelByClass(CLASS_TYPE_HARPER,oPC);
        effect eBonus1 = EffectSkillIncrease(SKILL_DISABLE_TRAP,nLvl);
        effect eBonus2 = EffectSkillIncrease(SKILL_SEARCH,nLvl);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Deneir's Eye Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothLuckOfHeroes(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_LUCK_OF_HEROES,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=19){return;}
        else if(nLvl <=39){nBonus = 1;}
        else {nBonus = 2;}
        effect eBonus = EffectSavingThrowIncrease(SAVING_THROW_ALL,nBonus,SAVING_THROW_TYPE_ALL);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Luck of Heroes Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothSilverPalm(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_SILVER_PALM,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=9){return;}
        else if(nLvl <=19){nBonus = 1;}
        else if(nLvl <=29){nBonus = 2;}
        else if(nLvl <=39){nBonus = 3;}
        else if(nLvl ==40){nBonus = 4;}
        nBonus = nBonus*2;
        effect eBonus1 = EffectSkillIncrease(SKILL_APPRAISE,nBonus);
        effect eBonus2 = EffectSkillIncrease(SKILL_PERSUADE,nBonus);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Silver Palm Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothSnakeBlood(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_SNAKEBLOOD,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=9){return;}
        else if(nLvl <=19){nBonus = 1;}
        else if(nLvl <=29){nBonus = 2;}
        else if(nLvl <=39){nBonus = 3;}
        else if(nLvl ==40){nBonus = 4;}
        effect eBonus1 = EffectSavingThrowIncrease(SAVING_THROW_REFLEX,nBonus,SAVING_THROW_TYPE_ALL);
        nBonus = nBonus*2;
        effect eBonus2 = EffectSavingThrowIncrease(SAVING_THROW_FORT,nBonus,SAVING_THROW_TYPE_POISON);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Snake Blood Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothStrongSoul(object oPC, int nFeedback = TRUE)
{
    if(GetHasFeat(FEAT_STRONGSOUL,oPC)==TRUE)
    {
        int nLvl = GetECLAdjustedHitDice(oPC);
        int nBonus;
        if(nLvl <=19){return;}
        else if(nLvl <=39){nBonus = 1;}
        else {nBonus = 2;}
        effect eBonus1 = EffectSavingThrowIncrease(SAVING_THROW_WILL,nBonus,SAVING_THROW_TYPE_ALL);
        effect eBonus2 = EffectSavingThrowIncrease(SAVING_THROW_FORT,nBonus,SAVING_THROW_TYPE_ALL);
        effect eBonus3 = EffectSavingThrowIncrease(SAVING_THROW_ALL,nBonus,SAVING_THROW_TYPE_DEATH);
        effect eBonus  = EffectLinkEffects(eBonus1,eBonus2);
        eBonus  = EffectLinkEffects(eBonus,eBonus3);
        eBonus = SupernaturalEffect(eBonus);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eBonus, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Strong Soul Feat Detected. Bonuses Activated.</c>"));
        }
    }
    else return;
}
void MothParryConcealment(object oPC, int nFeedback = TRUE)
{
    if(GetSkillRank(SKILL_PARRY,oPC, TRUE)>24)
    {
        int nParry = GetSkillRank(SKILL_PARRY,oPC,TRUE);
        effect eConcealment = EffectConcealment(15+nParry, MISS_CHANCE_TYPE_VS_RANGED);
        eConcealment = SupernaturalEffect(eConcealment);
        {
         ApplyEffectToObject (DURATION_TYPE_PERMANENT, eConcealment, oPC);
         if (nFeedback) DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Epic Parry Skills Detected. Concealment Versus Ranged Attacks Activated.</c>"));
        }
    }
    else return;
}
void MothAB(object oPC, int nFeedback = TRUE)
{
   int nFighter = GetLevelByClass(CLASS_TYPE_FIGHTER,oPC);
   if(nFighter>9)
   {
     int nHitDice = GetHitDice(oPC);
     int nBonus;
     int nWM = GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC);
     int nFighterWM = nFighter+nWM;
     if(nHitDice>nFighterWM){return;}
     if(nFighter <=9){return;}
     else if(nFighter <=19){nBonus = 1;}
     else if(nFighter <=29){nBonus = 2;}
     else if(nFighter <=39){nBonus = 3;}
     else if(nFighter ==40){nBonus = 5;}
     effect eAB = EffectAttackIncrease(nBonus,ATTACK_BONUS_MISC);
     eAB = SupernaturalEffect(eAB);
     ApplyEffectToObject (DURATION_TYPE_PERMANENT, eAB, oPC);
     DelayCommand(1.0,SendMessageToPC(oPC,"<c¥¥¥>[Server] Dedicated Fighter Detected. Extra Attack Bonus Activated.</c>"));
   }
}
// Adds bonuses to the players as they enter the server, level up or die (delevel).
void MothBonuses(object oPC, int nFeedback = TRUE)
{
    MothRemoveSubraceEffects(OBJECT_SELF,oPC);//removes all old bonuses.
    MothRemoveSubraceEffects2(oPC);//removes all old bonuses.
    ExecuteScript("x0_s3_portal",oPC);//Fires Subraces and Domain Powers.
    MothEnterDomains(oPC, nFeedback);
    MothEnterBonus(oPC, nFeedback);
    //MothRDDWings(oPC,9);
    MothSelfConcealment(oPC, nFeedback);
    MothDirtyFighting(oPC, nFeedback);
    MothArtist(oPC, nFeedback);
    MothBlooded(oPC, nFeedback);
    MothBullheaded(oPC, nFeedback);
    MothCourteousMagocracy(oPC, nFeedback);
    MothDeneirsEye(oPC, nFeedback);
    MothLuckOfHeroes(oPC, nFeedback);
    MothSilverPalm(oPC, nFeedback);
    MothSnakeBlood(oPC, nFeedback);
    MothStrongSoul(oPC, nFeedback);
    MothParryConcealment(oPC, nFeedback);
    MothAB(oPC, nFeedback);
}
//Removes Stunning Fist from oTarget
void MothRemoveSupernaturalStun(object oTarget)
{
    effect eBad = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_STUNNED)
        {
         RemoveEffect(oTarget, eBad);
        }
        eBad = GetNextEffect(oTarget);
    }
}
//void main(){}


