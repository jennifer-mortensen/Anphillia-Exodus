//::///////////////////////////////////////////////
//:: Death Function Library
//:: _inc_death
//:://////////////////////////////////////////////
/*
    Contains Anphillia Exodus functions related
    to death and dying.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////

#include "_inc_xp"

//These constants are included to make code more legible. Do not alter them!
const int DEATH_PVP_DEATH = 1;
const int DEATH_NON_PVP_DEATH = 2;

//Returns oPC's experience loss on death and respawn.
int CalculateXPLoss (object oPC, int nPvPDeath = FALSE, int nRespawn = FALSE);
//Applies experience loss to oPC. Call this on death and respawn.
void DoXPLoss (object oPC, int nPvPDeath = FALSE, int nRespawn = FALSE);
//Transfers all of oPC's gold into a player backpack.
void DropGold(object oPC);

//::///////////////////////////////////////////////
//:: CalculateXPLoss
//:://////////////////////////////////////////////
/*
    Returns oPC's experience loss on death and
    respawn.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
int CalculateXPLoss (object oPC, int nPvPDeath = FALSE, int nRespawn = FALSE)
{
    int nLevel = GetECLAdjustedLevelFromXP(oPC);
    int nXPLoss;

    if(nLevel >= 21)
        nXPLoss = nLevel * 200;
    else if(nLevel >= 16)
        nXPLoss = nLevel * 130;
    else if(nLevel >= 11)
        nXPLoss = nLevel * 110;
    else if(nLevel >= 6)
        nXPLoss = nLevel * 55;
    else
        nXPLoss = nLevel * 35;

    if(!nRespawn)
    {
        if(nLevel <= 10)
            nXPLoss /= 4;
        else if(nLevel <= 20)
            nXPLoss /= 2;
    }

    if(nPvPDeath == DEATH_PVP_DEATH)
        nXPLoss /= 2;

    return nXPLoss;
}

//::///////////////////////////////////////////////
//:: DoXPLoss
//:://////////////////////////////////////////////
/*
    Applies experience loss to oPC. Call this on
    death and respawn.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
void DoXPLoss (object oPC, int nPvPDeath = FALSE, int nRespawn = FALSE)
{
    int nXPLoss = CalculateXPLoss(oPC, nPvPDeath, nRespawn);

    GiveVirtualXPToCreature(oPC, -nXPLoss);
}

//::///////////////////////////////////////////////
//:: DropGold
//:://////////////////////////////////////////////
/*
    Transfers all of oPC's gold into a player
    backpack.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
void DropGold(object oPC)
{
    int nGold = GetGold(oPC);
    object oBackpack;

    if(!nGold)
        return;

    oBackpack = CreateObject(OBJECT_TYPE_PLACEABLE, "playerbackpack", GetLocation(oPC));
    AssignCommand(oBackpack, TakeGoldFromCreature(nGold, oPC));
}




