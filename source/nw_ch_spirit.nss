//::///////////////////////////////////////////////
//:: Associate: On Spawn In
//:: NW_CH_AC9
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

This must support the OC henchmen and all summoned/companion
creatures.

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 19, 2001
//:://////////////////////////////////////////////

#include "X0_INC_HENAI"

void main()
{
    effect ePer = EffectVisualEffect(VFX_DUR_GLOW_LIGHT_GREEN);
    effect ePer2 = EffectVisualEffect(VFX_DUR_PIXIEDUST);
    effect eSee = EffectSeeInvisible();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePer2,OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSee,OBJECT_SELF);

    //Sets up the special henchmen listening patterns
    SetAssociateListenPatterns();

    // Set additional henchman listening patterns
    bkSetListeningPatterns();

    // Default behavior for henchmen at start
    SetAssociateState(NW_ASC_SCALED_CASTING);
    SetAssociateState(NW_ASC_HEAL_AT_50);
    SetAssociateState(NW_ASC_RETRY_OPEN_LOCKS);
    SetAssociateState(NW_ASC_DISARM_TRAPS);
    SetAssociateState(NW_ASC_MODE_DEFEND_MASTER, FALSE);
    //Use melee weapons by default
    SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE);
    SetAssociateState(NW_FLAG_END_COMBAT_ROUND_EVENT);
    // Distance: make henchmen stick closer
    SetAssociateState(NW_ASC_DISTANCE_4_METERS);
    // Set starting location
    SetAssociateStartLocation();
}


