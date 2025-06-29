//::///////////////////////////////////////////////
//:: Items Function Library
//:: _inc_items
//:://////////////////////////////////////////////
/*
    Contains functions for handling items.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////

//Controls the maximum percentage that item immunities can stack to.
const int DAMAGE_IMMUNITY_CAP = 35;

//Applies damage immunities to oPC; note that before this is called, the immunities must be calculated first.
void ApplyDamageImmunities(object oPC);
//Clears all immunity application flags from all equipped items on oPC. Call this the first time a PC enters the mod.
void ClearImmunityApplicationFlags(object oPC);
//Removes all gold and all objects from oCreature's inventory with the exception of its hide.
void ClearInventory(object oPC);
//Returns oPC's combined barbarian and fighter levels (harper scout levels are also included).
int GetBarbarianFighterLevels(object oPC);
//Returns oPC's total caster class levels (harper scout levels are also included). Do NOT use this in place of GetCasterLevel(); the function names are similar, but they're otherwise entirely different.
int GetCasterLevels(object oPC);
//Returns oPC's total melee class levels (harper scout levels are also included).
int GetMeleeLevels(object oPC);
//Returns oPC's total sneaker class levels (harper scout levels are also included).
int GetSneakerLevels(object oPC);
//Forces oPC to unequip oItem if its DM Note requirements are not met.
void HandleDMNoteRequirements(object oPC, object oItem);
//Handles DM Note requirements for all equipped items on oPC.
void HandleDMNoteRequirementsForAllItems(object oPC);
//Calculates and applies item damage immunities to oPC; respects the module damage immunity cap.
void HandleItemDamageImmunities(object oPC, object oItem, int nItemIsBeingEquipped, int nApplyDamageImmunities = TRUE);
//Returns TRUE if oPC meets oItem's DM Note level prohibition.
int MeetsDMNoteLevelProhibition(object oPC, object oItem);
//Returns TRUE if oPC meets oItem's DM Note level requirement.
int MeetsDMNoteLevelRequirement(object oPC, object oItem);
//Returns TRUE if oPC meets oItem's DM Note prohibition requirements.
int MeetsDMNoteProhibitions(object oPC, object oItem);
//Returns TRUE if oPC meets oItem's DM Note requirements.
int MeetsDMNoteRequirements(object oPC, object oItem);

//::///////////////////////////////////////////////
//:: ApplyDamageImmunities
//:://////////////////////////////////////////////
/*
    Applies damage immunities to oPC; note that
    before this is called, the immunities must be
    calculated first.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
void ApplyDamageImmunities(object oPC)
{
    object oImmunityApplier = GetObjectByTag("IMMUNITY_APPLIER");
    SetLocalObject(oImmunityApplier, "CREATURE_TO_APPLY_IMMUNTIES_TO", oPC);
    ExecuteScript("exe_immunities", oImmunityApplier); //Call an external script so that the IMMUNITY_APPLIER object will return as the effect creator for these effects.
}

//::///////////////////////////////////////////////
//:: ClearImmunityApplicationFlags
//:://////////////////////////////////////////////
/*
    Clears all immunity application flags from all
    equipped items on oPC. Call this the first
    time a PC enters the mod.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
void ClearImmunityApplicationFlags(object oPC)
{
    int i;

    for(i = 0; i < NUM_INVENTORY_SLOTS; i++)
    {
        DeleteLocalInt(GetItemInSlot(i, oPC), "ITEM_IMMUNITIES_APPLIED");
    }

    SetLocalInt(oPC, "IMMUNITY_APPLICATION_FLAGS_CLEARED", TRUE);
}

//::///////////////////////////////////////////////
//:: ClearInventory
//:://////////////////////////////////////////////
/*
    Removes all gold and all objects from
    oCreature's inventory with the exception of
    its hide.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 27, 2009
//:://////////////////////////////////////////////
void ClearInventory(object oPC)
{
    int i;
    object oItem;

    TakeGoldFromCreature(GetGold(oPC), oPC, TRUE);
    oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(oPC);
    }
    for(i = 0; i < NUM_INVENTORY_SLOTS; i++)
    {
        if(i == INVENTORY_SLOT_CARMOUR)
            continue;
        DestroyObject(GetItemInSlot(i, oPC));
    }
}

//::///////////////////////////////////////////////
//:: GetBarbarianFighterLevels
//:://////////////////////////////////////////////
/*
    Returns oPC's combined barbarian and fighter
    levels (harper scout levels are also included).
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int GetBarbarianFighterLevels(object oPC)
{
    int nBarbarianFighterLevels;

    nBarbarianFighterLevels += GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC);
    nBarbarianFighterLevels += GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
    nBarbarianFighterLevels += GetLevelByClass(CLASS_TYPE_HARPER, oPC);

    return nBarbarianFighterLevels;
}

//::///////////////////////////////////////////////
//:: GetCasterLevels
//:://////////////////////////////////////////////
/*
    Returns oPC's total caster class levels
    (harper scouts are also included). Do NOT use
    this in place of GetCasterLevel(); the
    function names are similar, but they're
    otherwise entirely different.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int GetCasterLevels(object oPC)
{
    int nCasterLevels;

    nCasterLevels += GetLevelByClass(CLASS_TYPE_BARD, oPC);
    nCasterLevels += GetLevelByClass(CLASS_TYPE_CLERIC, oPC);
    nCasterLevels += GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    nCasterLevels += GetLevelByClass(CLASS_TYPE_HARPER, oPC);
    nCasterLevels += GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC);
    nCasterLevels += GetLevelByClass(CLASS_TYPE_SORCERER, oPC);
    nCasterLevels += GetLevelByClass(CLASS_TYPE_WIZARD, oPC);

    return nCasterLevels;
}

//::///////////////////////////////////////////////
//:: GetMeleeLevels
//:://////////////////////////////////////////////
/*
    Returns oPC's total melee class levels (harper
    scout levels are also included).
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int GetMeleeLevels(object oPC)
{
    int nMeleeLevels;

    nMeleeLevels += GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_BARD, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_FIGHTER, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_HARPER, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_MONK, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    nMeleeLevels += GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC);

    return nMeleeLevels;
}

//::///////////////////////////////////////////////
//:: GetSneakerLevels
//:://////////////////////////////////////////////
/*
    Returns oPC's total sneaker class levels
    (harper scout levels are also included).
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int GetSneakerLevels(object oPC)
{
    int nSneakerLevels;

    nSneakerLevels += GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
    nSneakerLevels += GetLevelByClass(CLASS_TYPE_HARPER, oPC);
    nSneakerLevels += GetLevelByClass(CLASS_TYPE_MONK, oPC);
    nSneakerLevels += GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    nSneakerLevels += GetLevelByClass(CLASS_TYPE_ROGUE, oPC);
    nSneakerLevels += GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC);

    return nSneakerLevels;
}

//::///////////////////////////////////////////////
//:: HandleDMNoteRequirements
//:://////////////////////////////////////////////
/*
    Forces oPC to unequip oItem if its DM note
    requirements are not met.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
void HandleDMNoteRequirements(object oPC, object oItem)
{
    if(!GetIsObjectValid(oItem))
        return;
    if(!MeetsDMNoteRequirements(oPC, oItem) || !MeetsDMNoteLevelRequirement(oPC, oItem) || MeetsDMNoteProhibitions(oPC, oItem) || MeetsDMNoteLevelProhibition(oPC, oItem))
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionDoCommand(ActionUnequipItem(oItem)));
        SendMessageToPC(oPC, "You cannot equip that item.");
    }
}

//::///////////////////////////////////////////////
//:: HandleDMNoteRequirementsForAllItems
//:://////////////////////////////////////////////
/*
    Handles DM Note requirements for all equipped
    items on oPC.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
void HandleDMNoteRequirementsForAllItems(object oPC)
{
    int i;

    for(i = 0; i < NUM_INVENTORY_SLOTS; i++)
    {
        HandleDMNoteRequirements(oPC, GetItemInSlot(i, oPC));
    }
}

//::///////////////////////////////////////////////
//:: HandleItemDamageImmunities
//:://////////////////////////////////////////////
/*
    Calculates and applies item damage immunities
    to oPC; respects the module damage immunity
    cap.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
void HandleItemDamageImmunities(object oPC, object oItem, int nItemIsBeingEquipped, int nApplyDamageImmunities = TRUE)
{
    if(!GetIsObjectValid(oItem))
        return;
    if(GetAppearanceType(oPC) > 6) //Do not update immunities if the PC is polymorphed; that could lead to all sorts of problems.
        return;

    //Variable declarations.
    string sItemResistanceType;
    int nItemResistanceAmount;
    int i = 1;
    int nImmunity;

    int nResistancesApplied = GetLocalInt(oItem, "ITEM_IMMUNITIES_APPLIED");
    if(nResistancesApplied == TRUE && nItemIsBeingEquipped == TRUE) //Exit if we've applied this item's resistances and it is being equipped;
        return;

    sItemResistanceType = GetStringUpperCase(GetLocalString(oItem, "IMMUNITY_" + IntToString(i) + "_TYPE"));
    nItemResistanceAmount = GetLocalInt(oItem, "IMMUNITY_" + IntToString(i) + "_AMOUNT");

    //Cycle through and recalculate immunities.
    while(sItemResistanceType != "")
    {
        nImmunity = GetLocalInt(oPC, sItemResistanceType + "_IMMUNITY");
        if(nItemIsBeingEquipped == TRUE)
            nImmunity += nItemResistanceAmount;
        else
            nImmunity -= nItemResistanceAmount;
        if(nImmunity < 0)
            nImmunity = 0;
        SetLocalInt(oPC, sItemResistanceType + "_IMMUNITY", nImmunity);
        i++;
        sItemResistanceType = GetStringUpperCase(GetLocalString(oItem, "IMMUNITY_" + IntToString(i) + "_TYPE"));
        nItemResistanceAmount = GetLocalInt(oItem, "IMMUNITY_" + IntToString(i) + "_AMOUNT");
    }
    //Apply immunities with new data.
    if(nApplyDamageImmunities)
        ApplyDamageImmunities(oPC);
    //Update item resistance application status.
    if(nItemIsBeingEquipped == TRUE)
        SetLocalInt(oItem, "ITEM_IMMUNITIES_APPLIED", TRUE);
    else
        DeleteLocalInt(oItem, "ITEM_IMMUNITIES_APPLIED");
}

//::///////////////////////////////////////////////
//:: MeetsDMNoteProhibition
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC meets oItem's DM Note
    level prohibition.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int MeetsDMNoteLevelProhibition(object oPC, object oItem)
{
    int nCharacterLevel = GetHitDice(oPC);
    int nLevelProhibition = GetLocalInt(oItem, "DMN_LEVEL_PROHIBITION");

    if(nCharacterLevel >= nLevelProhibition && nLevelProhibition != 0)
        return TRUE;
    else
        return FALSE;
}

//::///////////////////////////////////////////////
//:: MeetsDMNoteRequirements
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC meets oItem's DM Note
    level requirement.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int MeetsDMNoteLevelRequirement(object oPC, object oItem)
{
    int nCharacterLevel = GetHitDice(oPC);
    int nLevelRequirement = GetLocalInt(oItem, "DMN_LEVEL_REQUIREMENT");

    if(nCharacterLevel >= nLevelRequirement)
        return TRUE;
    else

        return FALSE;
}

//::///////////////////////////////////////////////
//:: MeetsDMNoteProhibitions
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC meets oItem's DM Note
    prohibitions requirements.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int MeetsDMNoteProhibitions(object oPC, object oItem)
{
    int i = 1;
    int nMeetsDMNoteProhibitions = FALSE;
    int nDMNoteProhibition = GetLocalInt(oItem, "DMN_P_" + IntToString(i) + "_TYPE");
    int nDMNoteLevel = GetLocalInt(oItem, "DMN_P_" + IntToString(i) + "_LEVEL");
    int nClassLevels;
    int nHarperLevels = GetLevelByClass(CLASS_TYPE_HARPER, oPC);

    while(nDMNoteProhibition)
    {
        switch (nDMNoteProhibition)
        {
            case 1: //Total Character Level
                nClassLevels = GetHitDice(oPC);
                break;
            case 2: //Caster Class Levels
                nClassLevels = GetCasterLevels(oPC);
                nClassLevels -= nHarperLevels;
                break;
            case 3: //Melee Class Levels
                nClassLevels = GetMeleeLevels(oPC);
                nClassLevels -= nHarperLevels;
                break;
            case 4: //Sneaker Class Levels
                nClassLevels = GetSneakerLevels(oPC);
                nClassLevels -= nHarperLevels;
                break;
            case 5: //Fighter and/or Barbarian Class Levels
                nClassLevels = GetBarbarianFighterLevels(oPC);
                nClassLevels -= nHarperLevels;
                break;
            default:
                nDMNoteProhibition -= 100;
                nClassLevels = GetLevelByClass(nDMNoteProhibition, oPC);
        }
        if(nClassLevels >= nDMNoteLevel)
        {
            return TRUE;
        }
        i++;
        nDMNoteProhibition = GetLocalInt(oItem, "DMN_P_" + IntToString(i) + "_TYPE");
        nDMNoteLevel = GetLocalInt(oItem, "DMN_P_" + IntToString(i) + "_LEVEL");
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: MeetsDMNoteRequirements
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC meets oItem's DM note
    requirements.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 17, 2009
//:://////////////////////////////////////////////
int MeetsDMNoteRequirements(object oPC, object oItem)
{
    int i = 1;
    int nDMNoteRequirement = GetLocalInt(oItem, "DMN_R_" + IntToString(i) + "_TYPE");
    int nDMNoteLevel = GetLocalInt(oItem, "DMN_R_" + IntToString(i) + "_LEVEL");
    int nRequirementsInclusive = GetLocalInt(oItem, "DMN_R_INCLUSIVE"); //If the inclusive value is true, the PC must meet ALL of the requirements.
    int nClassLevels;                                                   //Otherwise, they need only meet one of them.
    int nMeetsDMNoteRequirements = TRUE;

    while(nDMNoteRequirement)
    {
        nMeetsDMNoteRequirements = FALSE;
        switch (nDMNoteRequirement)
        {
            case 1: //Total Character Level
                nClassLevels = GetHitDice(oPC);
                break;
            case 2: //Caster Class Levels
                nClassLevels = GetCasterLevels(oPC);
                break;
            case 3: //Melee Class Levels
                nClassLevels = GetMeleeLevels(oPC);
                break;
            case 4: //Sneaker Class Levels
                nClassLevels = GetSneakerLevels(oPC);
                break;
            case 5: //Fighter and/or Barbarian Class Levels
                nClassLevels = GetBarbarianFighterLevels(oPC);
                break;
            default:
                nDMNoteRequirement -= 100;
                nClassLevels = GetLevelByClass(nDMNoteRequirement, oPC);
                if(nDMNoteRequirement != CLASS_TYPE_HARPER) //Harper Scouts count for all class types.
                {
                    nClassLevels += GetLevelByClass(CLASS_TYPE_HARPER, oPC);
                }
        }
        if(nClassLevels >= nDMNoteLevel && nRequirementsInclusive != TRUE)
        {
            return TRUE;
        }
        else if(nClassLevels < nDMNoteLevel && nRequirementsInclusive == TRUE)
        {
            return FALSE;
        }
        i++;
        nDMNoteRequirement = GetLocalInt(oItem, "DMN_R_" + IntToString(i) + "_TYPE");
        nDMNoteLevel = GetLocalInt(oItem, "DMN_R_" + IntToString(i) + "_LEVEL");
    }

    return nMeetsDMNoteRequirements;
}
