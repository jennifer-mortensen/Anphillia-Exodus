#include "_inc_db"
#include "_inc_faction"
#include "_inc_gen"

//Summon constants.
const int SUMMON_TYPE_INVALID = -1;
const int SUMMON_GROUP_DEATH = 1;
const int SUMMON_GROUP_EDK = 2;
const int SUMMON_GROUP_ELEMENTAL = 3;
const int SUMMON_GROUP_PLANAR = 4;
const int SUMMON_GROUP_UNDEAD = 5;
//Death domain summon constants.
const int DEATH_SUMMON_TYPE_RANDOM = 0;
const int DEATH_SUMMON_TYPE_GOOD = 1;
const int DEATH_SUMMON_TYPE_EVIL = 2;
//Epic Dragon Knight constants.
const int EDK_SUMMON_TYPE_RANDOM = 0;
const int EDK_SUMMON_TYPE_CHROMATIC = 1;
const int EDK_SUMMON_TYPE_METALLIC = 2;
const int EDK_SUMMON_TYPE_BLACK = 3;
const int EDK_SUMMON_TYPE_WHITE = 4;
const int EDK_SUMMON_TYPE_RED = 5;
const int EDK_SUMMON_TYPE_BLUE = 6;
const int EDK_SUMMON_TYPE_COPPER = 7;
const int EDK_SUMMON_TYPE_SILVER = 8;
const int EDK_SUMMON_TYPE_GOLD = 9;
const int EDK_SUMMON_TYPE_BRONZE = 10;
//Elemental summon constants.
const int ELEMENTAL_SUMMON_TYPE_RANDOM = 0;
const int ELEMENTAL_SUMMON_TYPE_AIR = 1;
const int ELEMENTAL_SUMMON_TYPE_EARTH = 2;
const int ELEMENTAL_SUMMON_TYPE_FIRE = 3;
const int ELEMENTAL_SUMMON_TYPE_WATER = 4;
//Planar summon constants.
const int PLANAR_SUMMON_TYPE_RANDOM = 0;
const int PLANAR_SUMMON_TYPE_GOOD = 1;
const int PLANAR_SUMMON_TYPE_EVIL = 2;
const int PLANAR_SUMMON_TYPE_LAWFUL = 3;
const int PLANAR_SUMMON_TYPE_CHAOTIC = 4;
//Undead summon constants.
const int UNDEAD_SUMMON_TYPE_RANDOM = 0;
const int UNDEAD_SUMMON_TYPE_GOOD = 1;
const int UNDEAD_SUMMON_TYPE_EVIL = 2;

//Adjusts the creature's alignment to that of its master.
void AdjustToMasterAlignment(object oCreature = OBJECT_SELF);
//Returns the type of summon that oCreature has been set to summon from nSummonGroup. Returns SUMMON_TYPE_INVALID on error.
int GetSummonType(object oCreature, int nSummonGroup);
//Set the summon type of oCreature for nSummonGroup. If nWriteToDatabase is set to TRUE, the summon type for a PC will be written to the dase immediately, instead of when
//the character is next saved. If nFeedback is TRUE, the player will be informed of the change.
void SetSummonType(object oCreature, int nSummonGroup, int nSummonType, int nFeedback = TRUE, int nWriteToDatabase = FALSE);
//Sets oCreature's default summon types to those associated with nFaction.
void SetToFactionDefaultSummonTypes(object oCreature, int nFaction, int nFeedback = FALSE, int nWriteToDatabase = FALSE);

//Adjusts the creature's alignment to that of its master.
void AdjustToMasterAlignment(object oCreature = OBJECT_SELF)
{
    object oMaster = GetTrueMaster(oCreature);
    if(!GetIsObjectValid(oMaster))
        return;

    int nGoodEvilAlignment = GetAlignmentGoodEvil(oMaster);
    int nLawfulChaoticAlignment = GetAlignmentLawChaos(oMaster);

    if(nGoodEvilAlignment == ALIGNMENT_GOOD)
    {
        AdjustAlignment(oCreature, ALIGNMENT_GOOD, 100, FALSE);
    }
    else if(nGoodEvilAlignment == ALIGNMENT_EVIL)
    {
        AdjustAlignment(oCreature, ALIGNMENT_EVIL, 100, FALSE);
    }
    if(nLawfulChaoticAlignment == ALIGNMENT_LAWFUL)
    {
        AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, 100, FALSE);
    }
    else if(nLawfulChaoticAlignment == ALIGNMENT_CHAOTIC)
    {
        AdjustAlignment(oCreature, ALIGNMENT_CHAOTIC, 100, FALSE);
    }
}

//Returns the type of summon that oCreature has been set to summon from nSummonGroup. Returns SUMMON_TYPE_INVALID on error.
int GetSummonType(object oCreature, int nSummonGroup)
{
    int nSummonType = SUMMON_TYPE_INVALID;
    switch (nSummonGroup)
    {
        case SUMMON_GROUP_DEATH:
            nSummonType = GetLocalInt(oCreature, "DEATH_SUMMON_TYPE");
            break;
        case SUMMON_GROUP_EDK:
            nSummonType = GetLocalInt(oCreature, "EDK_SUMMON_TYPE");
            break;
        case SUMMON_GROUP_ELEMENTAL:
            nSummonType = GetLocalInt(oCreature, "ELEMENTAL_SUMMON_TYPE");
            break;
        case SUMMON_GROUP_PLANAR:
            nSummonType = GetLocalInt(oCreature, "PLANAR_SUMMON_TYPE");
            break;
        case SUMMON_GROUP_UNDEAD:
            nSummonType = GetLocalInt(oCreature, "UNDEAD_SUMMON_TYPE");
            break;
    }
    return nSummonType;
}

//Set the summon type of oCreature for nSummonGroup. If nWriteToDatabase is set to TRUE, the summon type for a PC will be written to the dase immediately, instead of when
//the character is next saved. If nFeedback is TRUE, the player will be informed of the change.
void SetSummonType(object oCreature, int nSummonGroup, int nSummonType, int nFeedback = TRUE, int nWriteToDatabase = FALSE)
{
    int nIsPC = GetIsPC(oCreature);
    string sServerMessage1 = "<cеее>[Server] You are now summoning ";
    string sServerMessage2;
    string sServerMessage3 = ".</c>";
    string sSummonVariableName;

    switch (nSummonGroup)
    {
        case SUMMON_GROUP_DEATH:
            sSummonVariableName = "DEATH_SUMMON_TYPE";
            //Determine what information to send to the player.
            switch (nSummonType)
            {
                case DEATH_SUMMON_TYPE_RANDOM:
                    sServerMessage2 = "randomly-aligned death domain summons";
                    break;
                case DEATH_SUMMON_TYPE_GOOD:
                    sServerMessage2 = "good-aligned death domain summons";
                    break;
                case DEATH_SUMMON_TYPE_EVIL:
                    sServerMessage2 = "evil-aligned death domain summons";
                    break;
            }
            break;
        case SUMMON_GROUP_EDK:
            sSummonVariableName = "EDK_SUMMON_TYPE";
            //Determine what information to send to the player.
            switch (nSummonType)
            {
                case EDK_SUMMON_TYPE_RANDOM:
                    sServerMessage2 = "randomly selected epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_CHROMATIC:
                    sServerMessage2 = "chromatic epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_METALLIC:
                    sServerMessage2 = "metallic epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_BLACK:
                    sServerMessage2 = "black epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_WHITE:
                    sServerMessage2 = "white epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_RED:
                    sServerMessage2 = "red epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_BLUE:
                    sServerMessage2 = "blue epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_COPPER:
                    sServerMessage2 = "copper epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_SILVER:
                    sServerMessage2 = "silver epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_GOLD:
                    sServerMessage2 = "gold epic dragon knight summons";
                    break;
                case EDK_SUMMON_TYPE_BRONZE:
                    sServerMessage2 = "bronze epic dragon knight summons";
                    break;
            }
            break;
        case SUMMON_GROUP_ELEMENTAL:
            sSummonVariableName = "ELEMENTAL_SUMMON_TYPE";
            //Determine what information to send to the player.
            switch (nSummonType)
            {
                case ELEMENTAL_SUMMON_TYPE_RANDOM:
                    sServerMessage2 = "randomly selected elemental summons";
                    break;
                case ELEMENTAL_SUMMON_TYPE_AIR:
                    sServerMessage2 = "air elemental summons";
                    break;
                case ELEMENTAL_SUMMON_TYPE_EARTH:
                    sServerMessage2 = "earth elemental summons";
                    break;
                case ELEMENTAL_SUMMON_TYPE_FIRE:
                    sServerMessage2 = "fire elemental summons";
                    break;
                case ELEMENTAL_SUMMON_TYPE_WATER:
                    sServerMessage2 = "water elemental summons";
                    break;
            }
            break;
        case SUMMON_GROUP_PLANAR:
            sSummonVariableName = "PLANAR_SUMMON_TYPE";
            //Determine what information to send to the player.
            switch (nSummonType)
            {
                case PLANAR_SUMMON_TYPE_RANDOM:
                    sServerMessage2 = "randomly selected planar summons";
                    break;
                case PLANAR_SUMMON_TYPE_GOOD:
                    sServerMessage2 = "good-aligned planar summons";
                    break;
                case PLANAR_SUMMON_TYPE_EVIL:
                    sServerMessage2 = "evil-aligned planar summons";
                    break;
                case PLANAR_SUMMON_TYPE_LAWFUL:
                    sServerMessage2 = "lawful-aligned planar summons";
                    break;
                case PLANAR_SUMMON_TYPE_CHAOTIC:
                    sServerMessage2 = "chaotic-aligned planar summons";
                    break;
            }
            break;
        case SUMMON_GROUP_UNDEAD:
            sSummonVariableName = "UNDEAD_SUMMON_TYPE";
            //Determine what information to send to the player.
            switch (nSummonType)
            {
                case UNDEAD_SUMMON_TYPE_RANDOM:
                    sServerMessage2 = "randomly selected undead summons";
                    break;
                case UNDEAD_SUMMON_TYPE_GOOD:
                    sServerMessage2 = "good-aligned undead summons";
                    break;
                case UNDEAD_SUMMON_TYPE_EVIL:
                    sServerMessage2 = "evil-aligned undead summons";
                    break;
            }
            break;
    }

    //Set the summon type.
    SetLocalInt(oCreature, sSummonVariableName, nSummonType);
    if(nIsPC)
    {
        if(nFeedback)
        {
            SendMessageToPC(oCreature, sServerMessage1 + sServerMessage2 + sServerMessage3);
        }
        if(!nWriteToDatabase)
        {
            SetLocalInt(oCreature, sSummonVariableName + "_ALTERED", TRUE);
        }
        else
        {
            SetCampaignInt(GetPlayerDatabaseName(oCreature), sSummonVariableName, nSummonType, oCreature);
        }
    }
}

//Sets oCreature's default summon types to those associated with nFaction.
void SetToFactionDefaultSummonTypes(object oCreature, int nFaction, int nFeedback = FALSE, int nWriteToDatabase = FALSE)
{
    switch(nFaction)
    {
        case FACTION_AXFELL:
            SetSummonType(oCreature, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_CHROMATIC, nFeedback, nWriteToDatabase);
            SetSummonType(oCreature, SUMMON_GROUP_UNDEAD, UNDEAD_SUMMON_TYPE_EVIL, nFeedback, nWriteToDatabase);
            break;
        case FACTION_CLEAVEN:
            SetSummonType(oCreature, SUMMON_GROUP_EDK, EDK_SUMMON_TYPE_METALLIC, nFeedback, nWriteToDatabase);
            SetSummonType(oCreature, SUMMON_GROUP_UNDEAD, UNDEAD_SUMMON_TYPE_GOOD, nFeedback, nWriteToDatabase);
            break;
    }
}
