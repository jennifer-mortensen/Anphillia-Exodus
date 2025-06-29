//::///////////////////////////////////////////////
//:: Quest Function Library
//:: _inc_quest
//:://////////////////////////////////////////////
/*
    Contains functions for handling quests on
    Anphillia Exodus.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////

#include "_inc_xp"

//Returns TRUE if oPC 1) has the quest item for the quest, 2) has initialized the quest, and 3) has not finished the quest.
int GetCanFinishQuest(object oPC, string sQuestIdentifier);
//Returns TRUE if oPC can start the specified quest.
int GetCanStartQuest(object oPC, string sQuestIdentifier);
//Returns TRUE if oPC has the quest item for the specified quest.
int GetHasQuestItem(object oPC, string sQuestIdentifier);
//Returns TRUE if the specified quest has been completed for oPC.
int GetIsQuestComplete(object oPC, string sQuestIdentifier);
//Returns TRUE if the specified quest has been initialized for oPC.
int GetIsQuestInitialized(object oPC, string sQuestIdentifier);
//Return the quest ID for the specified quest. This function should be called from the questgiver.
string GetQuestID(string sQuestIdentifier);
//Initializes the specified quest for oPC.
void InitializeQuest(object oPC, string sQuestIdentifier);
//Issues the quest reward to oPC.
void IssueQuestReward(object oPC, string sQuestIdentifier);

//::///////////////////////////////////////////////
//:: GetCanFinishQuest
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC 1) has the quest items
    for the quest, 2) has initialized the quest,
    and 3) has not finished the quest.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
int GetCanFinishQuest(object oPC, string sQuestIdentifier)
{
    if(GetHasQuestItem(oPC, sQuestIdentifier) && GetIsQuestInitialized(oPC, sQuestIdentifier) && !GetIsQuestComplete(oPC, sQuestIdentifier))
        return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
//:: GetCanStartQuest
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC can start the specified
    quest.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
int GetCanStartQuest(object oPC, string sQuestIdentifier)
{
    int nInitializationVariable;
    int nLevel;
    int nQuestMaximumLevel;
    int nQuestMinimumLevel;
    int nRequiresInitializationVariable;
    string sInitializationVariable;
    string sUniqueQuestID = GetQuestID(sQuestIdentifier);

    //Check to see whether this quest has been initialized.
    if(GetIsQuestInitialized(oPC, sQuestIdentifier))
        return FALSE; // ... if so, return FALSE, as we can not initialize a quest that we've already initialized.

    //Read variables from the NPC that determine quest initialization prerequisites.
    nQuestMaximumLevel = GetLocalInt(OBJECT_SELF, sQuestIdentifier + "_MAXIMUM_LEVEL");
    nQuestMinimumLevel = GetLocalInt(OBJECT_SELF, sQuestIdentifier + "_MINIMUM_LEVEL");
    nRequiresInitializationVariable = GetLocalInt(OBJECT_SELF, sQuestIdentifier + "_REQUIRES_INITIALIZATION_VARIABLE");
    sInitializationVariable = GetLocalString(OBJECT_SELF, sQuestIdentifier + "_INITIALIZATION_VARIABLE");
    //If this quest requires an intialization variable, check for that variable on the PC.  These variables are most often used for quest chains involving multiple NPCs.
    if(nRequiresInitializationVariable)
    {
        nInitializationVariable = GetLocalInt(oPC, sInitializationVariable);
        if(!nInitializationVariable) //If we required an initialization variable that has not been initialized, then of course we return FALSE.
            return FALSE;
    }
    //Now check to see whether the PC is within the proper level range if level range variables have been set.
    if(nQuestMinimumLevel || nQuestMaximumLevel)
    {
        nLevel = GetECLAdjustedLevelFromXP(oPC);
        if(nLevel < nQuestMinimumLevel)
            return FALSE;
        if(nLevel > nQuestMaximumLevel)
            return FALSE;
    }

    //All things check out. Allow the PC to initialize the quest.
    return TRUE;
}

//::///////////////////////////////////////////////
//:: GetHasQuestItem
//:://////////////////////////////////////////////
/*
    Returns TRUE if oPC has the quest item for
    the specified quest.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
int GetHasQuestItem(object oPC, string sQuestIdentifier)
{
    //We read the required quest item from the quest giver.
    string sQuestItem = GetLocalString(OBJECT_SELF, sQuestIdentifier + "_QUEST_ITEM");
    object oQuestItem;

    //If we haven't specified a quest item for this quest, then of course the PC has all the items he needs.
    if(sQuestItem == "")
        return TRUE;

    //Check for the item.
    oQuestItem = GetItemPossessedBy(oPC, sQuestItem);

    if(!GetIsObjectValid(oQuestItem))
        return FALSE;

    return TRUE;
}

//::///////////////////////////////////////////////
//:: GetIsQuestComplete
//:://////////////////////////////////////////////
/*
    Returns TRUE if the specified quest has been
    completed for oPC.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
int GetIsQuestComplete(object oPC, string sQuestIdentifier)
{
    string sUniqueQuestID = GetQuestID(sQuestIdentifier); //Get this quest's ID.
    int nQuestComplete = GetLocalInt(oPC, sUniqueQuestID + "QUEST_COMPLETE"); //Now check the PC for a quest complete variable.

    return nQuestComplete;
}

//::///////////////////////////////////////////////
//:: GetIsQuestInitialized
//:://////////////////////////////////////////////
/*
    Returns TRUE if the specified quest has been
    initialized for oPC.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
int GetIsQuestInitialized(object oPC, string sQuestIdentifier)
{
    string sUniqueQuestID = GetQuestID(sQuestIdentifier); //Get this quest's ID.
    int nQuestInitialized = GetLocalInt(oPC, sUniqueQuestID + "QUEST_INITIALIZED"); //Read information from the PC.

    return nQuestInitialized;
}

//::///////////////////////////////////////////////
//:: GetQuestID
//:://////////////////////////////////////////////
/*
    Returns the quest ID for the specified
    quest. This function should be called from
    the questgiver.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
string GetQuestID(string sQuestIdentifier)
{
    //Create a unique ID for this quest, from this NPC, that all unique variables set on the PC will use as a prefix.
    string sName = GetName(OBJECT_SELF);
    string sTag = GetTag(OBJECT_SELF);
    string sUniqueQuestID = sName + sTag + "_" + sQuestIdentifier + "_";

    return sUniqueQuestID;
}

//::///////////////////////////////////////////////
//:: InitializeQuest
//:://////////////////////////////////////////////
/*
    Initializes the specified quest for oPC.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
void InitializeQuest(object oPC, string sQuestIdentifier)
{
    //Get this quest's ID.
    string sUniqueQuestID = GetQuestID(sQuestIdentifier);

    //Initialize the quest.
    SetLocalInt(oPC, sUniqueQuestID + "QUEST_INITIALIZED", TRUE);
}

//::///////////////////////////////////////////////
//:: IssueQuestReward
//:://////////////////////////////////////////////
/*
    Issques the quest reward to oPC.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 4, 2009
//:://////////////////////////////////////////////
void IssueQuestReward(object oPC, string sQuestIdentifier)
{
    int nGoldToReward;
    int nXPToReward;
    object oItem;
    string sQuestCompleteVariable;
    string sQuestItem;
    string sUniqueQuestID;

    //Get this quest's ID.
    sUniqueQuestID = GetQuestID(sQuestIdentifier);

    //Take the quest item.
    sQuestItem = GetLocalString(OBJECT_SELF, sQuestIdentifier + "_QUEST_ITEM");
    oItem = GetItemPossessedBy(oPC, sQuestItem);
    SetPlotFlag(oItem, FALSE);
    DestroyObject(oItem);

    //Read the quest reward from information on the NPC.
    nXPToReward = GetLocalInt(OBJECT_SELF, sQuestIdentifier + "_XP_REWARD");
    nGoldToReward = GetLocalInt(OBJECT_SELF, sQuestIdentifier + "_GOLD_REWARD");

    //Hand out the reward.
    if(nXPToReward)
        GiveVirtualXPToCreature(oPC, nXPToReward);
    if(nGoldToReward)
        GiveGoldToCreature(oPC, nGoldToReward);

    //Flag this quest as complete on the PC, and initialize optional initialization variables for quest chains involving multiple NPCs.
    SetLocalInt(oPC, sUniqueQuestID + "QUEST_COMPLETE", TRUE);
    sQuestCompleteVariable = GetLocalString(OBJECT_SELF, sQuestIdentifier + "_COMPLETION_VARIABLE");
    SetLocalInt(oPC, sQuestCompleteVariable, TRUE);
}
