//::///////////////////////////////////////////////
//:: Spawn Function Library
//:: _inc_spawn
//:://////////////////////////////////////////////
/*
    Contains functions for use when a creature
    is spawned in.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 21, 2009
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"

//Adds permanent damage bonuses to oCreature; reads integer variables on the object starting at DAMAGE_BONUS_1_AMOUNT, DAMAGE_BONUS_1_TYPE, and DAMAGE_BONUS_1_SLOT
//to determine how much of which damage type to add and where.
void ApplySpawnInDamageBonuses(object oCreature = OBJECT_SELF);
//Adds permanent damage immunities to oCreature; reads integer variables on the object starting at DAMAGE_IMMUNITY_1_AMOUNT and DAMAGE_IMMUNITY_1_TYPE to determine
//which immunities -- and how much immunity to add.
void ApplySpawnInDamageImmunities(object oCreature = OBJECT_SELF);
//Instantly casts spells on oCreature; reads integer variables on the object starting at CREATURE_SPECIAL_ABILITY_1 to know which spells to cast.
void ApplySpawnInSpecialAbilities(object oCreature = OBJECT_SELF);
//Instantly applies permanent visual effects on oCreature; reads integer variables from the object starting at VFX_1 to know which effects to apply.
void ApplySpawnInVisualEffects(object oCreature = OBJECT_SELF);

//::///////////////////////////////////////////////
//:: ApplySpawnInDamageBonuses
//:://////////////////////////////////////////////
/*
    Adds permanent damage bonuses to oCreature;
    reads integer variables on the object starting
    at DAMAGE_BONUS_1_AMOUNT, DAMAGE_BONUS_1_TYPE,
    and DAMAGE_BONUS_1_SLOT to determine how
    much of which damage type to add and where.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 21, 2009
//:://////////////////////////////////////////////
void ApplySpawnInDamageBonuses(object oCreature = OBJECT_SELF)
{
    int i = 1;
    int nDamageBonusType;
    int nDamageBonusAmount = GetLocalInt(oCreature, "DAMAGE_BONUS_" + IntToString(i) + "_AMOUNT");
    int nDamageBonusSlot;

    while(nDamageBonusAmount > 0)
    {
        nDamageBonusType = GetLocalInt(oCreature, "DAMAGE_BONUS_" + IntToString(i) + "_TYPE");
        nDamageBonusSlot = GetLocalInt(oCreature, "DAMAGE_BONUS_" + IntToString(i) + "_SLOT");
        IPSafeAddItemProperty(GetItemInSlot(nDamageBonusSlot, oCreature), ItemPropertyDamageBonus(nDamageBonusType, nDamageBonusAmount));
        i++;
        nDamageBonusAmount = GetLocalInt(oCreature, "DAMAGE_BONUS_" + IntToString(i) + "_AMOUNT");
    }
}

//::///////////////////////////////////////////////
//:: ApplySpawnInDamageImmunities
//:://////////////////////////////////////////////
/*
    Adds permanent damage immunities to oCreature;
    reads integer variables on the object starting
    at DAMAGE_IMMUNITY_1_AMOUNT and
    DAMAGE_IMMUNITY_1_TYPE to determine which
    immunitues -- and how much immunity to add.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 21, 2009
//:://////////////////////////////////////////////
void ApplySpawnInDamageImmunities(object oCreature = OBJECT_SELF)
{
    int i = 1;
    int nDamageImmunityType;
    int nDamageImmunityAmount = GetLocalInt(oCreature, "DAMAGE_IMMUNITY_" + IntToString(i) + "_AMOUNT");

    while(nDamageImmunityAmount > 0)
    {
        nDamageImmunityType = GetLocalInt(oCreature, "DAMAGE_IMMUNITY_" + IntToString(i) + "_TYPE");
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamageImmunityIncrease(nDamageImmunityType, nDamageImmunityAmount), oCreature);
        i++;
        nDamageImmunityAmount = GetLocalInt(oCreature, "DAMAGE_IMMUNITY_" + IntToString(i) + "_AMOUNT");
    }
}

//::///////////////////////////////////////////////
//:: ApplySpawnInSpecialAbilities
//:://////////////////////////////////////////////
/*
    Instantly casts spells on self; reads variables
    on the object starting at
    CREATURE_SPECIAL_ABILITY_1 to know which spells
    to cast.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 21, 2009
//:://////////////////////////////////////////////
void ApplySpawnInSpecialAbilities(object oCreature = OBJECT_SELF)
{
    int i = 1;
    int nAbility = GetLocalInt(oCreature, "SPECIAL_ABILITY_" + IntToString(i));

    while(nAbility != 0)
    {
        AssignCommand(oCreature, ActionCastSpellAtObject(nAbility, oCreature, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        i++;
        nAbility = GetLocalInt(oCreature, "SPECIAL_ABILITY_" + IntToString(i));
    }
}

//::///////////////////////////////////////////////
//:: ApplySpawnInVisualEffects
//:://////////////////////////////////////////////
/*
    Instantly applies permanent visual effects on
    self; reads integer variables from the object
    starting at VFX_1 to know which effects to
    apply.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 21, 2009
//:://////////////////////////////////////////////
void ApplySpawnInVisualEffects(object oCreature = OBJECT_SELF)
{
    int i = 1;
    int nVFX = GetLocalInt(oCreature, "VFX_" + IntToString(i));

    while(nVFX != 0)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(nVFX), oCreature);
        i++;
        nVFX = GetLocalInt(oCreature, "VFX_" + IntToString(i));
    }
}
