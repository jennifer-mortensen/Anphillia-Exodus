#include "_inc_xp"
#include "_inc_subrace"

// Moth's Subrace System v0.8
// -----------------------------------------------------------------------------
// This script handles the appliance of Subrace effects to a PC.
// Effects are all increases and balanced is handled with adding ECL
// to the PC instead. if you wish to apply a decreased stat, use the
// EffectCurse() function since all scripts have been changed not to
// to remove Curse-effects that are supernatural.
// Adding decreased attacks, saves and other stats is not recommended
// unless you know how to exclude them from the Remove-effect loops
// in the various scripts.
// Since this spell-script is applied via an ExecuteScript() function
// and using a hijacked BioWare campaign-specific spell-script
// the spell ID will be invalid (-1). So before any of these effects
// are applied, the script will remove any effects on the PC applied
// with an invalid spell-ID to avoid stacking.
// The function MothSubrace() need to be called when a PC logs on, chooses
// a subrace or has died - Died meaning each time after a MothRemoveEffects()
// function has been called.
// Both of these functions can be found in moth_inc_effects.nss.
// -----------------------------------------------------------------------------

//Set the PC's xp total to their maximum xp total.  This does nothing if the PC does not have an ECL.
void AdjustToMaximumLevel(object oPC, int nECL);

//Rewritten by J. Persinne April 15, 2009
void main()
{

    //Modify these variables to alter the spell resistance calculation for all spell resistance subraces
    int SPELL_RESISTANCE_BASE = 10; //Base spell resistance
    float SPELL_RESISTANCE_PER_LEVEL = 0.8; //Spell resistance per character level

    object oPC = OBJECT_SELF;
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    int nCharacterLevel;
    int nSubraceEffectsInitialized = GetLocalInt(oPC, "SUBRACE_EFFECTS_INITIALIZED"); //Checks whether subrace effects have been applied this reboot.  Currently used to
    int nECL; //Subrace ECL (Effective Character Level)                               //determine whether to refresh subrace castable spells.
    int nSpecialAbilityCastingsPerDay;
    int nSpellResistance;
    string sSubrace = GetSubRace(oPC);
    effect eEffect1, eEffect2, eEffect3, eEffect4, eEffect5, eEffect6, eEffect7;
    effect eLinkedSubraceEffects;
    object oSubraceApplier = GetObjectByTag("MothSubraceApplier");
    DeleteLocalInt(oPC, "SUFFERS_FROM_LIGHT_BLINDNESS");

    //Exit if the PC has no  subrace.
    if(sSubrace == "")
    {
        return;
    }

    int nRace = GetLocalInt(oPC, "BASE_RACIAL_TYPE") - 1;   //Attempt to read racial information from a variable on the PC.  We do this in order to avoid issues
    if(nRace == -1)                                         //with subraced PCs logging in while polymorphed.
    {
        nRace = GetRacialType(oPC);                         //If we can't find a racial type variable, get the PCs racial data from their character, and then set a racial
        SetLocalInt(oPC, "BASE_RACIAL_TYPE", nRace + 1);    //type variable.  We must use an offset of '1' because the constant value of RACIAL_TYPE_DWARF = 0 --
    }                                                       //in other words, if we didn't use an offset, we couldn't tell whether the PC had no racial variable
                                                            //set or if they were a dwarf.
    //Determine subrace effects based on race and subrace.
    switch (nRace)
    {
        case RACIAL_TYPE_DWARF:
            if(sSubrace == "Arctic Dwarf")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
                eEffect2 = EffectSkillIncrease(SKILL_CONCENTRATION, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
            }
            else if(sSubrace == "Duergar")
            {
                nECL = 1; //2
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                    nCharacterLevel = GetHitDice(oPC);
                    nCharacterLevel += nECL; //Factor ECL into character level for purposes of calculating spell resistance.
                }
                nCharacterLevel = GetHitDice(oPC);
                nSpellResistance =  SPELL_RESISTANCE_BASE + FloatToInt(IntToFloat(nCharacterLevel) * SPELL_RESISTANCE_PER_LEVEL);
                //eEffect1 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
                //eEffect2 = EffectCurse(0, 0, 0, 0, 0, 2); <- execute a penalties script on the SubraceApplier object instead so that penalties can not be removed.
                eEffect3 = EffectSpellResistanceIncrease(nSpellResistance);
                eEffect4 = EffectSkillIncrease(SKILL_HIDE, 4);
                eEffect5 = EffectSkillIncrease(SKILL_LISTEN, 1);
                eEffect6 = EffectSkillIncrease(SKILL_SPOT, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect3, eEffect4);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect5);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect5);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect6);
                SetLocalObject(oSubraceApplier, "OBJECT_TO_AFFECT", oPC);
                ExecuteScript("exe_srpenalties", oSubraceApplier);
            }
            else if(sSubrace == "Wild Dwarf")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_STRENGTH, 3);
                eEffect2 = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
                //eEffect3 = EffectCurse(0, 0, 0, 2, 0, 0); <- execute a penalties script on the SubraceApplier object instead so that penalties can not be removed.
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                //eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
                SetLocalObject(oSubraceApplier, "OBJECT_TO_AFFECT", oPC);
                ExecuteScript("exe_srpenalties", oSubraceApplier);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
            break;
        case RACIAL_TYPE_ELF:
            if(sSubrace == "Drow")
            {
                nECL = 1; //2
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                    nCharacterLevel = GetHitDice(oPC);
                    nCharacterLevel += nECL; //Factor ECL into character level for purposes of calculating spell resistance.
                }
                nSpellResistance = SPELL_RESISTANCE_BASE + FloatToInt(IntToFloat(nCharacterLevel) * SPELL_RESISTANCE_PER_LEVEL);
                //eEffect1 = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2);
                //eEffect2 = EffectAbilityIncrease(ABILITY_CHARISMA, 2);
                //eEffect3 = EffectCurse(0, 2, 0, 0, 0, 0);
                //eEffect4 = EffectSpellResistanceIncrease(nSpellResistance);
                //eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                //eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
                eLinkedSubraceEffects = EffectSpellResistanceIncrease(nSpellResistance);

                nSpecialAbilityCastingsPerDay = 1; //Drow can cast 'Darkness' once per day from the chat console.
                SetLocalInt(oPC, "DARKNESS_CASTINGS_PER_DAY", nSpecialAbilityCastingsPerDay);
                if(nSubraceEffectsInitialized == FALSE)
                    SetLocalInt(oPC, "CURRENT_DARKNESS_CASTINGS", nSpecialAbilityCastingsPerDay);
                //DelayCommand(1.0, AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(55), oHide));
                //DelayCommand(1.0, AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide)); //Drow have darkvision.
                SetLocalInt(oPC, "SUFFERS_FROM_LIGHT_BLINDNESS", TRUE);
            }
            else if(sSubrace == "Sun Elf")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 4);
                eEffect2 = EffectSkillIncrease(SKILL_LORE, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
            }
            else if(sSubrace == "Wood Elf")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_STRENGTH, 3);
                eEffect2 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
                //eEffect3 = EffectCurse(0, 0, 0, 0, 0, 2); <- execute a penalties script on the SubraceApplier object instead so that penalties can not be removed.
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                //eLinkedSubraceEffects = EffectLinkEffects(eEffect2, eEffect3);
                SetLocalObject(oSubraceApplier, "OBJECT_TO_AFFECT", oPC);
                ExecuteScript("exe_srpenalties", oSubraceApplier);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
            break;
        case RACIAL_TYPE_GNOME:
            if(sSubrace == "Arcane Gnome")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                    nCharacterLevel = GetHitDice(oPC);
                    nCharacterLevel += nECL; //Factor ECL into character level for purposes of calculating spell resistance.
                }
                nSpellResistance = SPELL_RESISTANCE_BASE + FloatToInt(IntToFloat(nCharacterLevel) * SPELL_RESISTANCE_PER_LEVEL);
                eEffect1 = EffectSpellResistanceIncrease(nSpellResistance);
                eLinkedSubraceEffects = eEffect1;
            }
            else if(sSubrace == "Isle Gnome")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_CHARISMA, 4);
                eEffect2 = EffectSkillIncrease(SKILL_ANIMAL_EMPATHY, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
            }
            else if(sSubrace == "Whisper Gnome")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_DEXTERITY, 3);
                eEffect2 = EffectAbilityIncrease(ABILITY_WISDOM, 2);
                //eEffect3 = EffectCurse(0, 0, 0, 0, 0, 2); <- execute a penalties script on the SubraceApplier object instead so that penalties can not be removed.
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                //eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
                SetLocalObject(oSubraceApplier, "OBJECT_TO_AFFECT", oPC);
                ExecuteScript("exe_srpenalties", oSubraceApplier);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
            break;
        case RACIAL_TYPE_HALFELF:
            if(sSubrace == "Half-Drow")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                    nCharacterLevel = GetHitDice(oPC);
                    nCharacterLevel += nECL; //Factor ECL into character level for purposes of calculating spell resistance.
                }
                nSpellResistance = SPELL_RESISTANCE_BASE + FloatToInt(IntToFloat(nCharacterLevel) * SPELL_RESISTANCE_PER_LEVEL);
                eEffect1 = EffectSpellResistanceIncrease(nSpellResistance);
                eLinkedSubraceEffects = eEffect1;
                //DelayCommand(1.0, AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDarkvision(), oHide)); //Half-Drow have darkvision.
            }
            else if(sSubrace == "Half Sun Elf")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2);
                eEffect2 = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
            }
            else if(sSubrace == "Half Wood Elf")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
                eEffect2 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
            break;
        case RACIAL_TYPE_HALFORC:
            if(sSubrace == "Half Gray Orc")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                    nCharacterLevel = GetHitDice(oPC);
                    nCharacterLevel += nECL; //Factor ECL into character level for purposes of calculating spell resistance.
                }
                nSpellResistance = SPELL_RESISTANCE_BASE + FloatToInt(IntToFloat(nCharacterLevel) * SPELL_RESISTANCE_PER_LEVEL);
                eEffect1 = EffectSpellResistanceIncrease(nSpellResistance);
                eEffect2 = EffectAbilityIncrease(ABILITY_STRENGTH, 1);
                eEffect3 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
            }
            else if(sSubrace == "Half Mountain Orc")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
                eEffect2 = EffectSkillIncrease(SKILL_CONCENTRATION, 1);
                eEffect3 = EffectAbilityIncrease(ABILITY_STRENGTH, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
            }
            else if(sSubrace == "Half-Orog")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_STRENGTH, 4);
                eEffect2 = EffectSkillIncrease(SKILL_DISCIPLINE, 1);
                eEffect3 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
            break;
        case RACIAL_TYPE_HALFLING:
            if(sSubrace == "Strongheart Halfling")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_STRENGTH, 3);
                eEffect2 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
                //eEffect3 = EffectCurse(0, 0, 0, 0, 0, 2);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                //eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
            }
            else if(sSubrace == "Deep Halfling")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                    nCharacterLevel = GetHitDice(oPC);
                    nCharacterLevel += nECL; //Factor ECL into character level for purposes of calculating spell resistance.
                }
                nSpellResistance = SPELL_RESISTANCE_BASE + FloatToInt(IntToFloat(nCharacterLevel) * SPELL_RESISTANCE_PER_LEVEL);
                eEffect1 = EffectSpellResistanceIncrease(nSpellResistance);
                eLinkedSubraceEffects = eEffect1;
            }
            else if(sSubrace == "Furchin")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
                eEffect2 = EffectSavingThrowIncrease(SAVING_THROW_FORT, 1);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
            break;
        case RACIAL_TYPE_HUMAN:
            if(sSubrace == "Aasimar")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_WISDOM, 2);
                eEffect2 = EffectAbilityIncrease(ABILITY_CHARISMA, 2);
                eEffect3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 5);
                eEffect4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 5);
                eEffect5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 5);
                eEffect6 = EffectSkillIncrease(SKILL_SPOT, 2);
                eEffect7 = EffectSkillIncrease(SKILL_LISTEN, 2);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect4);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect5);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect6);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect7);

                nSpecialAbilityCastingsPerDay = 1; //Aasimar can cast 'Light' once per day from the chat console.
                SetLocalInt(oPC, "LIGHT_CASTINGS_PER_DAY", nSpecialAbilityCastingsPerDay);
                if(nSubraceEffectsInitialized == FALSE)
                    SetLocalInt(oPC, "CURRENT_LIGHT_CASTINGS", nSpecialAbilityCastingsPerDay);
            }
            else if(sSubrace == "Tiefling")
            {
                nECL = 1;
                if(ECL_LEVEL_CAP == TRUE)
                {
                    AdjustToMaximumLevel(oPC, nECL);
                }
                eEffect1 = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
                eEffect2 = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2);
                eEffect3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 5);
                eEffect4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 5);
                eEffect5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 5);
                eEffect6 = EffectSkillIncrease(SKILL_SPOT, 2);
                eEffect7 = EffectSkillIncrease(SKILL_LISTEN, 2);
                eLinkedSubraceEffects = EffectLinkEffects(eEffect1, eEffect2);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect3);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect4);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect5);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect6);
                eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eEffect7);

                nSpecialAbilityCastingsPerDay = 1; //Tieflings can cast 'Darkness' once per day from the chat console.
                SetLocalInt(oPC, "DARKNESS_CASTINGS_PER_DAY", nSpecialAbilityCastingsPerDay);
                if(nSubraceEffectsInitialized == FALSE)
                    SetLocalInt(oPC, "CURRENT_DARKNESS_CASTINGS", nSpecialAbilityCastingsPerDay);
            }
            else
            {
                SetSubRace(oPC, ""); //If the PC does not have a valid subrace, we set it to nothing.  This optimizes performance on future subrace checks
                                     //and ensures that the player does not unintentionally end up with a scripted subrace if we add more later.
            }
    }
    if(!nECL) //Quick patch to prevent characters that enter with an invalid subrace from receiving a bonus; we'll alter this to use a value of its own later.
        return;

    //J. Persinne, Feb. 11 2010; all subraces now gain +1 to all skills and +1 to all saves.
    effect eUniversalSkillBoost = EffectSkillIncrease(SKILL_ALL_SKILLS, 1);
    effect eUniversalSaveBoost = EffectSavingThrowIncrease(SAVING_THROW_ALL, 1);
    eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eUniversalSkillBoost);
    eLinkedSubraceEffects = EffectLinkEffects(eLinkedSubraceEffects, eUniversalSaveBoost);

    //Apply subrace effects.
    DelayCommand(0.5, ApplySubraceFeats(oPC));
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, -1, FALSE));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eLinkedSubraceEffects), oPC);
    HandleLightBlindness(oPC);
    SetLocalInt(oPC, "ECL", nECL);
    SetLocalInt(oPC, "SUBRACE_EFFECTS_INITIALIZED", TRUE);
}

void AdjustToMaximumLevel(object oPC, int nECL)
{
    if(nECL < 1) //Exit if the PC does not have an ECL.
        return;

    int nMaximumLevel = 40 - nECL;
    int nMaximumXP = GetXPRequiredForLevel(nMaximumLevel);
    int nCurrentXP = GetXP(oPC);

    if(nCurrentXP <= nMaximumXP) //Exit if the PC has less XP than his maximum total.
        return;

    SetLocalInt(oPC, "ECL", nECL); //Set the ECL here in case the PC does not have an ECL yet.

    int nLevel = GetHitDice(oPC);

    if(nLevel > nMaximumLevel)
        DelayCommand(1.0, SendMessageToPC(oPC, "<cеее>[Server] You have been deleveled because you exceeded the maximum level allowed by your subrace.</c>"));
    int nXPToRefund = nCurrentXP - nMaximumXP;
    SetXP(oPC, nMaximumXP);
    GiveVirtualXPToCreature(oPC, nXPToRefund, FALSE);
}
