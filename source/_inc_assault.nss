//::///////////////////////////////////////////////
//:: Assault Function Library
//:: _inc_assault
//:://////////////////////////////////////////////
/*
    Contains Anphillia Exodus functions related
    to assaults and siege equipment.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////

//Handles ladder climing for oPC.
void ActionClimbLadder(object oPC, string sLadderID);
//Applies ladder fall effects to oPC. Call this when a ladder that a PC is climbing is destroyed.
void ApplyLadderFallDamage(object oPC, float fKnockdownDuration = 3.0, string sMessage = "You have fallen from a ladder!");
//Creates an assault ladder; it will not be useable until initialized with the EnabledAssaultLadderFunction.
void CreateAssaultLadder(string sID, float fLadderLayTime);
//Initializes an assault ladder for use.
void EnableAssaultLadder(string sLadderID);
//Returns the assault object ID associated with oObject.
string GetAssaultObjectID(object oObject);
//Returns the gate guard object associated with sID.
object GetGateGuardFromID(string sID);
//Returns the ladder base object associated with sID.
object GetLadderBaseFromID(string sID);
//Returns the spawn point for the ladder base associated with sID.
object GetLadderBaseSetPointFromID(string sID);
//Returns the climb destination for the ladder associated with sID.
location GetLadderClimbPointFromID(string sID);
//Returns the amount of time oPC needs to climb a ladder.
float GetLadderClimbTime(object oPC);
//Returns the amount of time oPC needs to lay a ladder.
float GetLadderLayTime(object oPC);
//Returns the ladder top object associated with sID.
object GetLadderTopFromID(string sID);
//Returns the spawn point for the ladder top associated with sID.
object GetLadderTopSetPointFromID(string sID);
//Returns the stoney ground object associated with sID.
object GetStoneyGroundFromID(string sID);
//Sends a floating text string, color-coded for assault messages.
void SendAssaultMessage(string sMessage, object oPC);

//::///////////////////////////////////////////////
//:: ActionClimbLadder
//:://////////////////////////////////////////////
/*
    Handles ladder climbing for oPC.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
void ActionClimbLadder(object oPC, string sLadderID)
{
    object oLadder = GetLadderBaseFromID(sLadderID);

    if(!GetIsObjectValid(oLadder))
        return;

    location lLocation = GetLadderClimbPointFromID(sLadderID);

    SetCommandable(TRUE, oPC);
    DelayCommand(0.1, AssignCommand(oPC, ClearAllActions()));
    DelayCommand(0.2, AssignCommand(oPC, ActionJumpToLocation(lLocation)));
    DeleteLocalObject(oLadder, "MY_CLIMBER");
}

//::///////////////////////////////////////////////
//:: ApplyLadderFallDamage
//:://////////////////////////////////////////////
/*
    Applies ladder fall effects to oPC. Call this
    when a ladder that a PC is climbing is
    destroyed.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
void ApplyLadderFallDamage(object oPC, float fKnockdownDuration = 3.0, string sMessage = "You have fallen from a ladder!")
{
    int nHeight = GetLocalInt(oPC, "LADDER_HEIGHT");
    int nDamage = d20(nHeight*2) - GetAbilityModifier(ABILITY_DEXTERITY, oPC);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_ENERGY);
    effect eKnockdown = EffectKnockdown();

    SendAssaultMessage(sMessage, oPC);
    SetCommandable(TRUE, oPC);
    if(nHeight > 1)
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, fKnockdownDuration);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
}

//::///////////////////////////////////////////////
//:: CreateAssaultLadder
//:://////////////////////////////////////////////
/*
    Creates an assault ladder. It will not be
    useable until initialized with the
    EnabledAssaultLadder function.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
void CreateAssaultLadder(string sID, float fLadderLayTime)
{
    object oLadder = CreateObject(OBJECT_TYPE_PLACEABLE, "assault_ladder", GetLocation(GetLadderBaseSetPointFromID(sID)), FALSE, "ASSAULT_LADDER_" + sID);

    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_GLOW_GREY), oLadder, fLadderLayTime));
    DelayCommand(0.1, SetLocalInt(oLadder, "STILL_BEING_LAID", TRUE));
}

//::///////////////////////////////////////////////
//:: EnableAssaultLadder
//:://////////////////////////////////////////////
/*
    Initializes an assault ladder for use.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
void EnableAssaultLadder(string sLadderID)
{
    effect eEffect;
    object oLadder = GetLadderBaseFromID(sLadderID);
    if(!GetIsObjectValid(oLadder)) //This won't happen unless a DM did something bad.
        return;

    SetPlotFlag(oLadder, FALSE); //Defenders can now destroy the ladder.
    DeleteLocalInt(oLadder, "STILL_BEING_LAID");
    SetName(oLadder, "Assault Ladder");
    eEffect = GetFirstEffect(oLadder);
    while(GetIsEffectValid(eEffect)) //Clear effects that might have been put on the ladder while it was being laid.
    {
        RemoveEffect(oLadder, eEffect);
        eEffect = GetNextEffect(oLadder);
    }
    //"Springboard" is a bit of a misnomer; it's just a legacy name from a previous implementation; the placeable we're creating here is actually the invisible
    //ladder top which defenders on the walls can bash to cause damage to the ladder below.
    CreateObject(OBJECT_TYPE_PLACEABLE, "assaultladdersb", GetLocation(GetLadderTopSetPointFromID(sLadderID)), FALSE, "ASSAULT_LADDER_SPRINGBOARD_" + sLadderID);
}

//::///////////////////////////////////////////////
//:: GetAssaultObjectID
//:://////////////////////////////////////////////
/*
    Returns the assault object ID (from 1-10)
    associated with oObject.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
string GetAssaultObjectID(object oObject)
{
    string sID = GetStringRight(GetTag(oObject), 1);

    if(sID == "0")
        sID = "10";

    return sID;
}

//::///////////////////////////////////////////////
//:: GetGateGuardFromID
//:://////////////////////////////////////////////
/*
    Returns the gate guard associated with sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
object GetGateGuardFromID(string sID)
{
    object oGateGuard = GetObjectByTag("GATE_GUARD_" + sID);
    return oGateGuard;
}

//::///////////////////////////////////////////////
//:: GetLadderBaseFromID
//:://////////////////////////////////////////////
/*
    Returns the ladder base object associated with
    sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
object GetLadderBaseFromID(string sID)
{
    object oLadderBase = GetObjectByTag("ASSAULT_LADDER_" + sID);
    return oLadderBase;
}

//::///////////////////////////////////////////////
//:: GetLadderBaseSetPointFromID
//:://////////////////////////////////////////////
/*
    Returns the spawn point for the ladder base
    associated with sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
object GetLadderBaseSetPointFromID(string sID)
{
    object oLadderBaseSetPoint = GetWaypointByTag("WP_SPAWN_ASSAULT_LADDER_" + sID);
    return oLadderBaseSetPoint;
}

//::///////////////////////////////////////////////
//:: GetLadderClimbPointFromID
//:://////////////////////////////////////////////
/*
    Returns the climb destination for the ladder
    associated with sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
location GetLadderClimbPointFromID(string sID)
{
    object oLadderClimbPoint = GetWaypointByTag("WP_CLIMB_ASSAULT_LADDER_" + sID);
    return GetLocation(oLadderClimbPoint);
}

//::///////////////////////////////////////////////
//:: GetLadderClimbTime
//:://////////////////////////////////////////////
/*
    Returns the amount of time oPC needs to climb
    a ladder.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
float GetLadderClimbTime(object oPC)
{

    int BASE_CLIMBING_TIME = 5; // Base laying time for a ladder in rounds.
    int PRIMARY_CLASS_REDUCTION = 10; //How many levels required in primary classes for a one round reduction in laying the ladder.
    int SECONDARY_CLASS_REDUCTION = 20; //How many levels required in secondary classes for a one round reduction in laying the ladder.
    int ASSASSIN_LEVELS_REQUIRED_FOR_INSTANT_CLIMB = 20;
    int MONK_LEVELS_REQUIRED_FOR_INSTANT_CLIMB = 30;
    int RANGER_LEVELS_REQUIRED_FOR_INSTANT_CLIMB = 25;
    int ROGUE_LEVELS_REQUIRED_FOR_INSTANT_CLIMB = 30;
    int SHADOWDANCER_LEVELS_REQUIRED_FOR_INSTANT_CLIMB = 20;

    int nClimbTime;
    float fInstantClimbTime = 0.5; //The least amount of time that someone can spend climbing a ladder -- don't ever set this to zero.  It will result in a divide by zero error.

    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= ASSASSIN_LEVELS_REQUIRED_FOR_INSTANT_CLIMB)
        return fInstantClimbTime;
    else if (GetLevelByClass(CLASS_TYPE_MONK, oPC) >= MONK_LEVELS_REQUIRED_FOR_INSTANT_CLIMB)
        return fInstantClimbTime;
    else if (GetLevelByClass(CLASS_TYPE_RANGER, oPC) >= RANGER_LEVELS_REQUIRED_FOR_INSTANT_CLIMB)
        return fInstantClimbTime;
    else if (GetLevelByClass(CLASS_TYPE_ROGUE, oPC) >= ROGUE_LEVELS_REQUIRED_FOR_INSTANT_CLIMB)
        return fInstantClimbTime;
    else if (GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) >= SHADOWDANCER_LEVELS_REQUIRED_FOR_INSTANT_CLIMB)
        return fInstantClimbTime;

    int nPrimaryClassLevels =
        GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) +
        GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) +
        GetLevelByClass(CLASS_TYPE_HARPER, oPC) +
        GetLevelByClass(CLASS_TYPE_MONK, oPC) +
        GetLevelByClass(CLASS_TYPE_RANGER, oPC) +
        GetLevelByClass(CLASS_TYPE_ROGUE, oPC) +
        GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) +
        GetLevelByClass(CLASS_TYPE_SHIFTER, oPC);

    int nSecondaryClassLevels =
        GetLevelByClass(CLASS_TYPE_BARD, oPC) +
        GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) +
        GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC) +
        GetLevelByClass(CLASS_TYPE_DRUID, oPC) +
        GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC) +
        GetLevelByClass(CLASS_TYPE_FIGHTER, oPC) +
        GetLevelByClass(CLASS_TYPE_PALADIN, oPC) +
        GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC) +
        GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC);

    nClimbTime = BASE_CLIMBING_TIME - ((nPrimaryClassLevels / PRIMARY_CLASS_REDUCTION) + (nSecondaryClassLevels / SECONDARY_CLASS_REDUCTION));

    return RoundsToSeconds(nClimbTime);
}

//::///////////////////////////////////////////////
//:: GetLadderLayTime
//:://////////////////////////////////////////////
/*
    Returns the amount of time oPC needs to lay
    a ladder.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
float GetLadderLayTime(object oPC)
{
    int BASE_LAYING_TIME = 5;  // Base laying time for a ladder in rounds.
    int PRIMARY_CLASS_REDUCTION = 10;  //How many levels required in primary classes for a one round reduction in laying the ladder.
    int SECONDARY_CLASS_REDUCTION = 20; //How many levels required in secondary classes for a one round reduction in laying the ladder.

    int nLayingTime;

    int nPrimaryLayingClassLevels =
        GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) +
        GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC) +
        GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION, oPC) +
        GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC) +
        GetLevelByClass(CLASS_TYPE_FIGHTER, oPC) +
        GetLevelByClass(CLASS_TYPE_HARPER, oPC) +
        GetLevelByClass(CLASS_TYPE_PALADIN, oPC) +
        GetLevelByClass(CLASS_TYPE_RANGER, oPC) +
        GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC);

    int nSecondaryLayingClassLevels =
        GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) +
        GetLevelByClass(CLASS_TYPE_BARD, oPC) +
        GetLevelByClass(CLASS_TYPE_DRUID, oPC) +
        GetLevelByClass(CLASS_TYPE_MONK, oPC) +
        GetLevelByClass(CLASS_TYPE_ROGUE, oPC) +
        GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC);

    nLayingTime = BASE_LAYING_TIME - ((nPrimaryLayingClassLevels / PRIMARY_CLASS_REDUCTION) + (nSecondaryLayingClassLevels / SECONDARY_CLASS_REDUCTION));

    return RoundsToSeconds(nLayingTime);
}

//::///////////////////////////////////////////////
//:: GetLadderTopFromID
//:://////////////////////////////////////////////
/*
    Returns the ladder top object associated with
    sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
object GetLadderTopFromID(string sID)
{
    object oLadderTop = GetObjectByTag("ASSAULT_LADDER_SPRINGBOARD_" + sID);
    return oLadderTop;
}

//::///////////////////////////////////////////////
//:: GetLadderTopSetPointFromID
//:://////////////////////////////////////////////
/*
    Returns the spawn point for the ladder top
    associated with sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
object GetLadderTopSetPointFromID(string sID)
{
    object oLadderTopSetPoint = GetWaypointByTag("WP_SPAWN_ASSAULT_SPRINGBOARD_" + sID);
    return oLadderTopSetPoint;
}

//::///////////////////////////////////////////////
//:: GetStoneyGroundFromID
//:://////////////////////////////////////////////
/*
    Returns the stoney ground object associated
    with sID.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
object GetStoneyGroundFromID(string sID)
{
    object oStoneyGround = GetObjectByTag("LADDER_PLACEMENT_" + sID);
    return oStoneyGround;
}

//::///////////////////////////////////////////////
//:: SendAssaultMessage
//:://////////////////////////////////////////////
/*
    Sends a floating text string, color-coded
    for assault messages.
*/
//:://////////////////////////////////////////////
//:: Created By: J. Persinne
//:: Created On: May 25, 2009
//:://////////////////////////////////////////////
void SendAssaultMessage(string sMessage, object oPC)
{
    FloatingTextStringOnCreature("<cþŒ >" + sMessage + "</c>", oPC, FALSE);
}
