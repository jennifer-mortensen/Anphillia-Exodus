//::///////////////////////////////////////////////
//:: Database Function Library
//:: _inc_db
//:://////////////////////////////////////////////
/*
    Contains functions related to Anphillia
    Exodus' database.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////

#include "_inc_time"

//Returns oPC's unique identifier.
string GetPCUniqueID(object oPC);
//Returns oPC's database name.
string GetPlayerDatabaseName(object oPC);
//Initialize PC Database variables. Call this the first time a PC enters the module.
void InitializePCDatabaseVariables(object oPC);
//Initializes a unique identifier for oPC. This is used in database read/writes to prevent problematic behavior if a character is deleted from the server vault, and also to handle database writes when
//the character object is not present. Note that if the character is removed from the vault, the character's specific database would have to be deleted as well.
void InitializePCUniqueID(object oPC);
//Saves variables into oPC's database.
void SavePCDatabaseVariables(object oPC);
//Saves virtual experience to oPC's database.
void SaveVirtualExperience(object oPC);
//Initializes oPC's database name.
void SetPlayerDatabaseName(object oPC);

//::///////////////////////////////////////////////
//:: GetPCUniqueID
//:://////////////////////////////////////////////
/*
    Returns oPC's unique identifier.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
string GetPCUniqueID(object oPC)
{
    string sPCUniqueID = GetLocalString(oPC, "PC_UNIQUE_ID");

    return sPCUniqueID;
}

//::///////////////////////////////////////////////
//:: GetPlayerDatabaseName
//:://////////////////////////////////////////////
/*
    Returns oPC's database name.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
string GetPlayerDatabaseName(object oPC)
{
    string sPCDatabaseName = GetLocalString(oPC, "PLAYER_DATABASE_NAME");

    return sPCDatabaseName;
}

//::///////////////////////////////////////////////
//:: InitializePCDatabaseVariables
//:://////////////////////////////////////////////
/*
    Initializes oPC's database variables. Call
    this the first time a PC enters the module.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
void InitializePCDatabaseVariables(object oPC)
{
    string sPlayerName = GetPCPlayerName(oPC);
    string sPCUniqueID;

    InitializePCUniqueID(oPC); //Load all of the PC's database variables on to the module for quick retrieval.
    SetPlayerDatabaseName(oPC); //Store the player's database name for retrieval OnClientExit.
    sPCUniqueID = GetPCUniqueID(oPC); //Now that we've initialized player data, we can retrieve their unique ID.

    //Begin loading variables from the database on to the player.
    int nDefaultAppearance = GetCampaignInt(sPlayerName, "DEFAULT_APPEARANCE", oPC);
    if(nDefaultAppearance == 0) //This character has not had their appearance stored.  Let's do that now.
    {
        int nAppearance = GetAppearanceType(oPC);
        SetCampaignInt(sPlayerName, "DEFAULT_APPEARANCE", nAppearance + 100, oPC);
        SetLocalInt(oPC, "DEFAULT_APPEARANCE", nAppearance);
    }
    else
    {
        SetLocalInt(oPC, "DEFAULT_APPEARANCE", nDefaultAppearance - 100);
    }

    int nVirtualExperience = GetCampaignInt(sPlayerName, sPCUniqueID + "VXP");
    int nEDKSummonType = GetCampaignInt(sPlayerName, "EDK_SUMMON_TYPE", oPC);
    int nUndeadSummonType = GetCampaignInt(sPlayerName, "UNDEAD_SUMMON_TYPE", oPC);

    SetLocalInt(oPC, "VIRTUAL_EXPERIENCE", nVirtualExperience);
    SetLocalInt(oPC, "EDK_SUMMON_TYPE", nEDKSummonType);
    SetLocalInt(oPC, "UNDEAD_SUMMON_TYPE", nUndeadSummonType);
}

//::///////////////////////////////////////////////
//:: InitializePCUniqueID
//:://////////////////////////////////////////////
/*
    Initializes a unique identifier for oPC.  This
    is used in database read/writes to prevent
    problematic behavior if a character is deleted
    from the server vault, and also to handle
    database writes when the character object is
    not present. Note that if the character is
    removed from the vault, the character's
    specific database would have to be deleted
    as well.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
void InitializePCUniqueID(object oPC)
{
    if(GetIsDM(oPC))
        return;

    string sPlayerName = GetPCPlayerName(oPC);
    string sDeity = GetDeity(oPC); //Deity is used as part of the unique identifier.  If we haven't initialized it yet, we'll do so below.
    string sPCIdentifier = GetStringLeft(sDeity, 8);
    int nGetIsValidDatabaseIdentifier = GetCampaignInt(sPlayerName, sPCIdentifier);
    int nCurrentYear;
    int nCurrentMonth;
    int nCurrentDay;
    int nCurrentTime;
    string sCreationDate;
    string sNewID;

    if(nGetIsValidDatabaseIdentifier == FALSE || GetXP(oPC) == 0)
    {
        //We've not created a unique identifier for this character yet.  Let's do so.
        //Get the current date to use as part of the unique identifier.
        nCurrentYear = GetCalendarYear();
        nCurrentMonth = GetCalendarMonth();
        nCurrentDay = GetCalendarDay();
        nCurrentTime = GetSecondsSinceServerBoot();
        sCreationDate = IntToString(nCurrentYear) + IntToString(nCurrentMonth) + IntToString(nCurrentDay) + IntToString(nCurrentTime);
        sCreationDate = GetStringLeft(sCreationDate, 8);
        //The deity field is a convenient field to access when a character's specific database is unavailable.
        SetDeity(oPC, sCreationDate);
        sNewID = sCreationDate;
        //Now that we've initialized a unique identifier, let's ensure that we remember the fact.
        SetCampaignInt(sPlayerName, sPCIdentifier, TRUE);
        SetCampaignString(sPlayerName, "DEITY", sDeity, oPC); //Store the player's original deity in the campaign database in case we need that later.
        SetLocalString(oPC, "PC_UNIQUE_ID", sNewID + GetStringLeft(GetName(oPC), 20)); //Store the ID on the PC for retrieval later.
    }
    else
    {
        //We've initialized the PC unique ID before, so let's just store it on the player.
        SetLocalString(oPC, "PC_UNIQUE_ID", sPCIdentifier + GetStringLeft(GetName(oPC), 20));
    }
}

//::///////////////////////////////////////////////
//:: SavePCDatabaseVariables
//:://////////////////////////////////////////////
/*
    Saves variables into oPC's database.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
void SavePCDatabaseVariables(object oPC)
{
    string sPlayerDatabaseName = GetPlayerDatabaseName(oPC);
    int nInt;
    int nEDKSummonTypeAltered = GetLocalInt(oPC, "EDK_SUMMON_TYPE_ALTERED");
    int nUndeadSummonTypeAltered = GetLocalInt(oPC, "UNDEAD_SUMMON_TYPE_ALTERED");
    int nAppearanceAltered = GetLocalInt(oPC, "DEFAULT_APPEARANCE_ALTERED");

    SaveVirtualExperience(oPC);

    //We don't write these variables unless they've been altered from their previous values.
    if(nEDKSummonTypeAltered == TRUE)
    {
        DeleteLocalInt(oPC, "EDK_SUMMON_TYPE_ALTERED");
        nInt = GetLocalInt(oPC, "EDK_SUMMON_TYPE");
        SetCampaignInt(sPlayerDatabaseName, "EDK_SUMMON_TYPE", nInt, oPC);
    }
    if(nUndeadSummonTypeAltered == TRUE)
    {
        DeleteLocalInt(oPC, "UNDEAD_SUMMON_TYPE_ALTERED");
        nInt = GetLocalInt(oPC, "UNDEAD_SUMMON_TYPE");
        SetCampaignInt(sPlayerDatabaseName, "UNDEAD_SUMMON_TYPE", nInt, oPC);
    }
    if(nAppearanceAltered == TRUE) //This will never happen unless a DM manually sets these variables in order to alter a character's default appearance.
    {
        DeleteLocalInt(oPC, "DEFAULT_APPEARANCE_ALTERED");
        nInt = GetLocalInt(oPC, "DEFAULT_APPEARANCE");
        SetCampaignInt(sPlayerDatabaseName, "DEFAULT_APPEARANCE", nInt + 100, oPC);
    }
}


//::///////////////////////////////////////////////
//:: SaveVirtualExperience
//:://////////////////////////////////////////////
/*
    Saves virtual experience to oPC's database.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
void SaveVirtualExperience(object oPC)
{
    string sPCID = GetPCUniqueID(oPC);
    int nVirtualExperienceAltered = GetLocalInt(oPC, "VIRTUAL_EXPERIENCE_ALTERED");
    int nInt;

    if(nVirtualExperienceAltered == TRUE)
    {
        DeleteLocalInt(oPC, "VIRTUAL_EXPERIENCE_ALTERED"); //Delete this integer so that we won't write again later unless the value changes.
        nInt = GetLocalInt(oPC, "VIRTUAL_EXPERIENCE");
        SetCampaignInt(GetPlayerDatabaseName(oPC), sPCID + "VXP", nInt);
    }
}

//::///////////////////////////////////////////////
//:: SetPlayerDatabaseName
//:://////////////////////////////////////////////
/*
    Initializes oPC's database name.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: April 19, 2009
//:://////////////////////////////////////////////
void SetPlayerDatabaseName(object oPC)
{
    string sPCPlayerName = GetPCPlayerName(oPC);

    SetLocalString(oPC, "PLAYER_DATABASE_NAME", sPCPlayerName);
}


