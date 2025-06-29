//::///////////////////////////////////////////////
//:: General Function Library
//:: _inc_gen
//:://////////////////////////////////////////////
/*
    Contains functions specific Anphillia Exodus.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: ??//??/???/
//:://////////////////////////////////////////////

//Polymorph constants; these values must correspond to the line numbers in polymorph.2da.
const int ANPH_POLYMORPH_TYPE_WYRMLING_WHITE_EPIC = 127;
const int ANPH_POLYMORPH_TYPE_WYRMLING_BLUE_EPIC = 128;
const int ANPH_POLYMORPH_TYPE_WYRMLING_RED_EPIC = 129;
const int ANPH_POLYMORPH_TYPE_WYRMLING_GREEN_EPIC = 130;
const int ANPH_POLYMORPH_TYPE_WYRMLING_BLACK_EPIC = 131;
const int ANPH_POLYMORPH_TYPE_DRIDER_MALE = 62;
const int ANPH_POLYMORPH_TYPE_DRIDER_FEMALE = 121;
const int ANPH_POLYMORPH_TYPE_DRIDER_MALE_EPIC = 100;
const int ANPH_POLYMORPH_TYPE_DRIDER_FEMALE_EPIC = 122;
const int ANPH_POLYMORPH_TYPE_DROW_FEMALE = 70;
const int ANPH_POLYMORPH_TYPE_DROW_MALE = 59;
const int ANPH_POLYMORPH_TYPE_DROW_FEMALE_EPIC = 106;
const int ANPH_POLYMORPH_TYPE_DROW_MALE_EPIC = 105;
const int ANPH_POLYMORPH_TYPE_HARPY_EPIC = 97;
const int ANPH_POLYMORPH_TYPE_MANTICORE_EPIC = 101;
const int ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE_EPIC = 103;
const int ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE_EPIC = 126;
const int ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE = 83;
const int ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE = 125;
const int ANPH_POLYMORPH_TYPE_MINDFLAYER_EPIC = 108;
const int ANPH_POLYMORPH_TYPE_LIZARDFOLK_MALE_EPIC = 104;
const int ANPH_POLYMORPH_TYPE_LIZARDFOLK_FEMALE_EPIC = 124;
const int ANPH_POLYMORPH_TYPE_SPECTRE = 76;
const int ANPH_POLYMORPH_TYPE_RAKSHASA_MALE = 88;
const int ANPH_POLYMORPH_TYPE_RAKSHASA_FEMALE = 89;
const int ANPH_POLYMORPH_TYPE_DEATH_SLAAD = 87;
const int ANPH_POLYMORPH_TYPE_VAMPIRE_MALE = 74;
const int ANPH_POLYMORPH_TYPE_VAMPIRE_FEMALE = 77;
const int ANPH_POLYMORPH_TYPE_CHICKEN = 132;

//Returns TRUE if oPC is polymorphed; since this function checks appearance for efficiency's sake, it only works for PCs. For NPCs, use GetHasEffect(EFFECT_TYPE_POLYMORPH) instead.
int GetIsPolymorphed(object oPC);
//Returns TRUE if oPC has the appearance of the specified polymorph type. Always returns FALSE for NPCs.
int GetIsPolymorphType(object oPC, int nPolymorphType);
//Returns TRUE if oCreature is a PC and not a DM.
int GetIsTruePC(object oCreature);
//Returns oVictim's killer; checks GetLastHostileActor(), GetGoingToBeAttackedBy(), and GetLastKiller(). Returns OBJECT_INVALID if none is found.
object GetTrueKiller(object oVictim, int nReturnMasterOfKiller = FALSE);
//Returns the true master of oCreature; respects hierarchial associates, ents, and ritual zombies.
object GetTrueMaster(object oCreature);

//::///////////////////////////////////////////////
//:: GetIsPolymorphed
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC is polymorphed; since
    this function checks appearance for
    efficiency's sake, it only works for PCs. For
    NPCs, use GetHasEffect(EFFECT_TYPE_POLYMORPH)
    instead.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 7, 2010
//:://////////////////////////////////////////////
int GetIsPolymorphed(object oPC)
{
    if(!GetIsPC(oPC))
        return FALSE;
    if(GetAppearanceType(oPC) > 6)
        return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
//:: GetIsPolymorphType
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC has the appearance of
    the specified polymorph type. Always returns
    FALSE for NPCs.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On:
//:://////////////////////////////////////////////
int GetIsPolymorphType(object oPC, int nPolymorphType)
{
    if(!GetIsPC(oPC))
        return FALSE;

    int nCreatureAppearance = GetAppearanceType(oPC);
    if(nCreatureAppearance >= 0 && nCreatureAppearance <= 6)
        return FALSE;

    int nPolymorphTypeAppearance = StringToInt(Get2DAString("polymorph", "AppearanceType", nPolymorphType));
    if(nCreatureAppearance == nPolymorphTypeAppearance)
        return TRUE;

    return FALSE;
}

//::///////////////////////////////////////////////
//:: GetIsTruePC
//:://////////////////////////////////////////////
/*
    Retirms TRUE if oCreature is a PC and not
    a DM.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 26, 2010
//:://////////////////////////////////////////////
int GetIsTruePC(object oCreature)
{
    if(!GetIsPC(oCreature))
        return FALSE;
    if(GetIsDM(oCreature))
        return FALSE;
    return TRUE;
}

//::///////////////////////////////////////////////
//:: GetTrueKiller
//:://////////////////////////////////////////////
/*
    Returns oVictim's last killer; checks
    GetLastHostileActor(), GetGoingToBeAttackedBy(),
    and GetLastKiller(). Returns OBJECT_INVALID
    if none is found.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
object GetTrueKiller(object oVictim, int nReturnMasterOfKiller = FALSE)
{
    int i;
    object oKiller;

    for(i = 0; i < 3; i++)
    {
        switch(i)
        {
            case 0:
                oKiller = GetLastHostileActor(oVictim);
                break;
            case 1:
                oKiller = GetGoingToBeAttackedBy(oVictim);
                break;
            case 2:
                oKiller = GetLastKiller();
                break;
        }
        if(GetIsObjectValid(oKiller))
        {
            if(nReturnMasterOfKiller)
                oKiller = GetTrueMaster(oKiller);
            return oKiller;
        }
    }
    return OBJECT_INVALID;
}


//::///////////////////////////////////////////////
//:: GetTrueMaster
//:://////////////////////////////////////////////
/*
    Returns the true master of oCreature; respects
    hierarchial associates, ents, and ritual
    zombies.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
object GetTrueMaster(object oCreature)
{
    object oMaster;
    object oTrueMaster = oCreature;

    oMaster = GetLocalObject(oCreature, "MY_MASTER"); //Ents and Ritual Zombies have their master stored in this value.
    if(oMaster == OBJECT_INVALID)
    {
        oMaster = GetMaster(oCreature);
        while(oMaster != OBJECT_INVALID)
        {
            if(oMaster != OBJECT_INVALID)
                oTrueMaster = oMaster;
            oMaster = GetMaster(oTrueMaster);
        }
    }
    else
        oTrueMaster = oMaster;

    if(GetIsObjectValid(oTrueMaster))
        return oTrueMaster;
    else
        return oCreature;
}




