//::///////////////////////////////////////////////
//:: Faction Function Library
//:: _inc_faction
//:://////////////////////////////////////////////
/*
    Contain Anphillia Exodus faction-related
    (that is, Axfell and Cleaven related)
    functions.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 26, 2010
//:://////////////////////////////////////////////

//These constants are included to make code more legible. Do not alter them!
const int FACTION_NONE = 0;
const int FACTION_AXFELL = 1;
const int FACTION_CLEAVEN = 2;

//Returns the fort affiliation of oCreature. Returns FACTION_NONE (0) if it has none.
int GetFaction(object oCreature);
//Returns the fort name associated with nFaction value.
string GetFactionNameFromValue(int nFaction);
//Returns TRUE if both objects belong to the same fort.
int GetIsFortAlly(object oFirstObject, object oSecondObject = OBJECT_SELF);
//Returns TRUE if both objects belong to opposing forts.
int GetIsFortEnemy(object oFirstObject, object oSecondObject = OBJECT_SELF);
//Returns TRUE if oCreature belongs to nFaction.
int GetIsOfFaction(object oCreature, int nFaction);
//Gives oPC the starter gear for nFaction.
void GiveStarterGear(object oPC, int nFaction);
//Handles all relic loss behavior. This should be called whenever a PC loses a faction relic.
void HandleRelicLoss(object oPC);

//::///////////////////////////////////////////////
//:: GetFaction
//:://////////////////////////////////////////////
/*
    Returns the fort affiliation of oCreature.
    Returns FACTION_NONE (0) if it has none.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
int GetFaction(object oCreature)
{
    if(GetIsPC(oCreature))
    {
        string sFactionInt = GetLocalString(oCreature, "MothSetFactionInt");
        if(sFactionInt == "MothAxfellMember")
            return FACTION_AXFELL;
        else if(sFactionInt == "MothCleavenMember")
            return FACTION_CLEAVEN;
    }
    else
    {
        if(GetFactionEqual(oCreature, GetObjectByTag("MOTHAXFELLHOLDER")) || GetFactionEqual(oCreature, GetObjectByTag("MOTHAXFELL2HOLDER")))
            return FACTION_AXFELL;
        else if(GetFactionEqual(oCreature, GetObjectByTag("MOTHCLEAVENHOLDER")) || GetFactionEqual(oCreature, GetObjectByTag("MOTHCLEAVEN2HOLDER")))
            return FACTION_CLEAVEN;
    }
    return FACTION_NONE;
}

//::///////////////////////////////////////////////
//:: GetFactionNameFromValue
//:://////////////////////////////////////////////
/*
    Returns the fort name associated with
    nFactionValue.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: February 23, 2010
//:://////////////////////////////////////////////
string GetFactionNameFromValue(int nFaction)
{
    switch(nFaction)
    {
        case FACTION_AXFELL: return "Axfell";
        case FACTION_CLEAVEN: return "Cleaven";
    }
    return "";
}

//::///////////////////////////////////////////////
//:: GetIsFortAlly
//:://////////////////////////////////////////////
/*
    Returns TRUE if both objects belong to the
    same fort.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: ??/??/2009
//:://////////////////////////////////////////////
int GetIsFortAlly(object oFirstObject, object oSecondObject = OBJECT_SELF)
{
    int nFactionValue = GetFaction(oFirstObject) + GetFaction(oSecondObject);

    if(nFactionValue == FACTION_AXFELL + FACTION_AXFELL || nFactionValue == FACTION_CLEAVEN + FACTION_CLEAVEN)
        return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
//:: GetIsFortEnemy
//:://////////////////////////////////////////////
/*
    Returns TRUE if both objects belong to
    opposing forts.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: ??/??/2009
//:://////////////////////////////////////////////
int GetIsFortEnemy(object oFirstObject, object oSecondObject = OBJECT_SELF)
{
    if(GetFaction(oFirstObject) + GetFaction(oSecondObject) == FACTION_AXFELL + FACTION_CLEAVEN)
        return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
//:: GetIsOfFaction
//:://////////////////////////////////////////////
/*
    Returns TRUE if oCreature belongs to nFaction.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: ??/??/2009
//:://////////////////////////////////////////////
int GetIsOfFaction(object oCreature, int nFaction)
{
    if(GetFaction(oCreature) == nFaction)
        return TRUE;
    return FALSE;
}

//::///////////////////////////////////////////////
//:: GiveStarterGear
//:://////////////////////////////////////////////
/*
    Gives oPC the starter gear for nFaction.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: ??/??/2009
//:://////////////////////////////////////////////
void GiveStarterGear(object oPC, int nFaction)
{
    if(nFaction != FACTION_AXFELL && nFaction != FACTION_CLEAVEN)
        return;

    object oItem;

    GiveGoldToCreature(oPC, 5000);
    oItem = CreateItemOnObject("itm_rootkit", oPC);
    SetPlotFlag(oItem, TRUE);
    AssignCommand(oPC, ActionDoCommand(ActionEquipItem(oItem, INVENTORY_SLOT_BELT)));
    oItem = CreateItemOnObject("mindisappeardust", oPC);
    SetPlotFlag(oItem, TRUE);
    oItem = CreateItemOnObject("mindisappeardust", oPC);
    SetPlotFlag(oItem, TRUE);
    oItem = CreateItemOnObject("mindisappeardust", oPC);
    SetPlotFlag(oItem, TRUE);
    oItem = CreateItemOnObject("mothsummondog", oPC);
    SetPlotFlag(oItem, TRUE);
    oItem = CreateItemOnObject("nw_it_medkit001", oPC, 10);
    SetPlotFlag(oItem, TRUE);
    oItem = CreateItemOnObject("starterboots", oPC);
    SetPlotFlag(oItem, TRUE);
    AssignCommand(oPC, ActionDoCommand(ActionEquipItem(oItem, INVENTORY_SLOT_BOOTS)));
    switch(nFaction)
    {
        case FACTION_AXFELL:
            SetName(oItem, "Axfell Militia Boots");
            oItem = CreateItemOnObject("axfellhelmet005", oPC);
            SetPlotFlag(oItem, TRUE);
            oItem = CreateItemOnObject("axfelloutfit", oPC);
            SetPlotFlag(oItem, TRUE);
            AssignCommand(oPC, ActionDoCommand(ActionEquipItem(oItem, INVENTORY_SLOT_CHEST)));
            break;
        case FACTION_CLEAVEN:
            SetName(oItem, "Cleaven Militia Boots");
            oItem = CreateItemOnObject("cleavenmiliti001", oPC);
            SetPlotFlag(oItem, TRUE);
            oItem = CreateItemOnObject("cleavenoutfit", oPC);
            SetPlotFlag(oItem, TRUE);
            AssignCommand(oPC, ActionDoCommand(ActionEquipItem(oItem, INVENTORY_SLOT_CHEST)));
            break;
    }
}

//::///////////////////////////////////////////////
//:: HandleRelicLoss
//:://////////////////////////////////////////////
/*
    Handles all relic loss behavior. This should
    be called whenever a PC loses a faction relic.
*/
//:://////////////////////////////////////////////
//:: Created By: ??
//:: Created On: ??/??/????
//:://////////////////////////////////////////////
void HandleRelicLoss(object oPC)
{
    int nRelicStatus = GetLocalInt(GetModule(),"Relic_Status");
    object oAxfellRelic = GetItemPossessedBy(oPC, "axfellrelic");
    object oCleavenRelic = GetItemPossessedBy(oPC, "cleavenrelic");
    object oMod = GetModule();

    switch(nRelicStatus)
    {
        case 1:
            if (GetIsObjectValid (oAxfellRelic)){
                SendMessageToPC (oPC, "You have failed, and lost the Axfell Relic.");
                DestroyObject (oAxfellRelic);
                SetLocalInt(oMod, "Relic_Status", 0);
                SetCustomToken(901, "<c þ >Safe"); // Axfell green is safe
                DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Axfell has recovered their relic!</c>");
                    aPC = GetNextPC();
                }
            }
        case 2:
            if (GetIsObjectValid (oCleavenRelic)){
                SendMessageToPC (oPC, "You have failed, and lost the Cleaven Relic.");
                DestroyObject (oCleavenRelic);
                SetLocalInt(oMod, "Relic_Status", 0);
                SetCustomToken(900, "<c þ >Safe"); // Cleaven green is safe
                DeleteLocalInt(GetModule(), "MOTHCLVRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Cleaven has recovered their relic!</c>");
                    aPC = GetNextPC();
                }
            }
            break;

        case 5:
            if (GetIsObjectValid (oAxfellRelic)){
                SendMessageToPC (oPC, "You have failed, and lost the Axfell Relic.");
                DestroyObject (oAxfellRelic);
                SetLocalInt(oMod, "Relic_Status", 3);
                SetCustomToken(901, "<c þ >Safe"); // Axfell green is safe
                SetCustomToken(900, "<cþ  >Stolen"); // Cleaven red is stolen
                DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
                DeleteLocalInt(GetModule(), "MOTHCLVRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Axfell has recovered both relics!</c>");
                    aPC = GetNextPC();
                }
            }
            if (GetIsObjectValid (oCleavenRelic)){
                SendMessageToPC (oPC, "You have failed, and lost the Cleaven Relic.");
                SetCustomToken(901, "<c þ >Safe"); // Axfell green is safe
                SetCustomToken(900, "<cþ  >Stolen"); // Cleaven red is stolen
                DestroyObject (oCleavenRelic);
                SetLocalInt(oMod, "Relic_Status", 3);
            }
            break;
        case 6:
            if (GetIsObjectValid (oAxfellRelic)){
                SendMessageToPC (oPC, "You have failed, and lost the Axfell Relic.");
                DestroyObject (oAxfellRelic);
                SetLocalInt(oMod, "Relic_Status", 4);
                SetCustomToken(901, "<cþ  >Stolen"); // Axfell green is stolen
                SetCustomToken(900, "<c þ >Safe"); // Cleaven red is safe
                DeleteLocalInt(GetModule(), "MOTHAXFRELIC");
                DeleteLocalInt(GetModule(), "MOTHCLVRELIC");
                object aPC = GetFirstPC();
                while (GetIsObjectValid(aPC))
                {
                    SendMessageToPC(aPC, "<c  þ>[Faction] Cleaven has recovered both relics!</c>");
                    aPC = GetNextPC();
                }
            }
            if (GetIsObjectValid (oCleavenRelic)){
                SendMessageToPC (oPC, "You have failed, and lost the Cleaven Relic.");
                DestroyObject (oCleavenRelic);
                SetLocalInt(oMod, "Relic_Status", 4);
                SetCustomToken(901, "<cþ  >Stolen"); // Axfell green is stolen
                SetCustomToken(900, "<c þ >Safe"); // Cleaven red is safe
            }
            break;
    }
}
