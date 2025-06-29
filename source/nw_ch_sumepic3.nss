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
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSeeInvisible(),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectSpellResistanceIncrease(42),OBJECT_SELF);
    object oMasterHP = GetMyMaster();
    int nPMhp = GetLevelByClass(CLASS_TYPE_PALE_MASTER,oMasterHP);
    int nBGhp = GetLevelByClass(CLASS_TYPE_BLACKGUARD,oMasterHP);
    int nSDhp = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oMasterHP);
    int nTempHP = nPMhp+nBGhp+nSDhp;
    effect eHpp = EffectTemporaryHitpoints(nTempHP*4+2);
    eHpp = ExtraordinaryEffect(eHpp);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHpp, OBJECT_SELF);
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

    // Distance: make henchmen stick closer
    SetAssociateState(NW_ASC_DISTANCE_4_METERS);
    if (GetAssociateType(OBJECT_SELF) == ASSOCIATE_TYPE_HENCHMAN)
    {
        SetAssociateState(NW_ASC_DISTANCE_2_METERS);
    }

    // Set starting location
    SetAssociateStartLocation();
}


