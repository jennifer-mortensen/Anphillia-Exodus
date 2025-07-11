//::///////////////////////////////////////////////
//:: Associate: On Spawn In
//:: NW_CH_AC9
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////
#include "anph_treas_gen"
#include "NW_I0_GENERIC"

void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectRegenerate(1,6.0),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(), OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(38), OBJECT_SELF);
    SetAssociateListenPatterns();//Sets up the special henchmen listening patterns
    SetListeningPatterns();      // Goes through and sets up which shouts the NPC will listen to.

    SetAssociateState(NW_ASC_SCALED_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE); //User ranged weapons by default if true.
    SetAssociateState(NW_ASC_DISTANCE_2_METERS);

    // April 2002: Summoned monsters, associates and familiars need to stay
    // further back due to their size.
    if (GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_DOMINATED, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_FAMILIAR, GetMaster()) == OBJECT_SELF  ||
        GetAssociate(ASSOCIATE_TYPE_SUMMONED, GetMaster()) == OBJECT_SELF)
    {
            SetAssociateState(NW_ASC_DISTANCE_4_METERS);

    }


    //SetAssociateState(NW_ASC_MODE_DEFEND_MASTER);
    SetAssociateStartLocation();
    // SPECIAL CONVERSATION SETTTINGS
    //SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);
    //SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);
            // This causes the creature to say a special greeting in their conversation file
            // upon Perceiving the player. Attach the [NW_D2_GenCheck.nss] script to the desired
            // greeting in order to designate it. As the creature is actually saying this to
            // himself, don't attach any player responses to the greeting.


// CUSTOM USER DEFINED EVENTS
/*
    The following settings will allow the user to fire one of the blank user defined events in the NW_D2_DefaultD.  Like the
    On Spawn In script this script is meant to be customized by the end user to allow for unique behaviors.  The user defined
    events user 1000 - 1010
*/
    //SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);         //OPTIONAL BEHAVIOR - Fire User Defined Event 1002
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);           //OPTIONAL BEHAVIOR - Fire User Defined Event 1005
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);          //OPTIONAL BEHAVIOR - Fire User Defined Event 1006
    //SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);        //OPTIONAL BEHAVIOR - Fire User Defined Event 1008
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT); //OPTIONAL BEHAVIOR - Fire User Defined Event 1003
    //SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);      //OPTIONAL BEHAVIOR - Fire User Defined Event 1004
    //SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007

    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
    //GenerateNPCTreasure();     //* Use this to create a small amount of treasure on the creature
}

