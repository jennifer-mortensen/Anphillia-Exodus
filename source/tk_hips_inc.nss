#include "zep_inc_phenos2"
#include "x3_inc_horse"
#include "moth_inc_spells"
#include "_inc_gen"
//::///////////////////////////////////////////////
//:: HIPS restrictions
//:: tk_hips_inc.nss
//::
//:: Created By: The_Krit
//:: Created On: 10/03/06
//::
//:: Based on: sf_hips_inc.nss by scarface.
//:://////////////////////////////////////////////
// Forces a character out of stealth if they were in stealth and combat in the
// past HIPS_DELAY seconds.
//
// For greater efficiency, you can skip the combat check. Comment out the
// entire TK_HiPS_PseudoHeartbeat() function at the top of this file, and
// uncomment the one at the bottom.
//:://////////////////////////////////////////////
// Number of seconds a HiPSter must be visible before re-entering stealth.
const int HIPS_DELAY = 8;   // 1 1/2 round.
// Flags to indicate the status of the PC one second ago.
const int HIPS_OK = 0;          // The PC may act freely.
const int HIPS_INSTEALTH = 1;   // The PC is in stealth mode.
const int HIPS_NEWLYSEEN = 2;   // The PC becomes restricted by combat.
const int HIPS_RESTRICTED = 3;  // The PC may not enter stealth mode.
// Pseudo heartbeat function to enforce delay before re-entering stealth.
// nMode is one of the above constants.
// nTimer is the number of seconds the PC must wait before re-entering stealth.
//     As with nMode, nTimer is current as of one second ago.
//     (So nTimer == 1 indicates that stealth will be permitted as soon as the
//     current function call ends, but not before.)
// nTimer is only used when the mode is HIPS_NEWLYSEEN or HIPS_RESTRICTED.



void ApplyHiPS (object oPC) //J. Persinne; we now apply and remove HiPS from the character's hide.
{
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    if(!GetIsObjectValid(oHide))
    {
        MothAddNewSkin(oPC);
        DelayCommand(1.1, ApplyHiPS(oPC));
    }
    else
    {
        FloatingTextStringOnCreature("<cÝ¡Ý>*Hide in Plain Sight Mode Available!*</c>",oPC, FALSE);
        AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(31), oHide);
    }
}

void RemoveHiPS(object oPC)
{
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    if(!GetIsObjectValid(oHide))
        return;

    itemproperty iProperty = GetFirstItemProperty(oHide);
    int nPropertyType = GetItemPropertyType(iProperty);
    int nPropertySubType = GetItemPropertySubType(iProperty);

    while(GetIsItemPropertyValid(iProperty))
    {
        if(nPropertyType == ITEM_PROPERTY_BONUS_FEAT && nPropertySubType == 31)
            RemoveItemProperty(oHide, iProperty);
        iProperty = GetNextItemProperty(oHide);
        nPropertyType = GetItemPropertyType(iProperty);
        nPropertySubType = GetItemPropertySubType(iProperty);
    }
}


void TK_HiPS_PseudoHeartbeat(object oPC, int nMode, int nTimer)
{
    // If the PC no longer exists, cancel the recursion.
    if (!GetIsObjectValid(oPC) || !GetLocalInt(oPC, "HIPS_PSEUDOBEAT_RUNNING") )
        return;
    // See if the PC is currently in stealth.
    int bInStealth = GetActionMode(oPC, ACTION_MODE_STEALTH);
    effect eHide = EffectSkillDecrease(SKILL_HIDE,127);
    effect eMove = EffectSkillDecrease(SKILL_MOVE_SILENTLY, 127);
    effect eLink = EffectLinkEffects(eHide, eMove);
    eLink = SupernaturalEffect(eLink);
    // Set the new state of the PC based on the previous state.
    switch ( nMode )
    {
        case HIPS_OK:           // May enter stealth.
            // Check current stealth mode.
            if ( bInStealth )
                // For the recursion, the PC will have been in stealth mode.
                nMode = HIPS_INSTEALTH;
            break;

        case HIPS_INSTEALTH:    // Might leave stealth.
            // Check current stealth mode.
            if(GetLocalInt(oPC,"HasMountExp")== TRUE)
            {
            zep_Dismount(oPC);
            }
            if(HorseGetIsMounted(oPC)== TRUE)
            {
            int bAnim=!GetLocalInt(oPC,"bDismountFast");
            AssignCommand(oPC,HORSE_SupportDismountWrapper(bAnim,TRUE));
            }
            SetLocalInt(oPC,"MothLeftStealth",FALSE);
            if ( !bInStealth )
            {
                // Left stealth.
                if(GetLocalInt(oPC,"MothLeftStealth")==FALSE)
                    {
                    //DelayCommand(9.0,FloatingTextStringOnCreature("<cÂ† >*Stealth Mode Available!*</c>",oPC));
                    SetLocalInt(oPC,"MothLeftStealth",TRUE);
                    }
                // For the recursion, the PC will be restricted.
                nMode = HIPS_RESTRICTED;
                RemoveHiPS(oPC);
                // Reset the timer.
                nTimer = HIPS_DELAY;
            }
            break;

        case HIPS_NEWLYSEEN:    // Becomes restricted if in combat.
            // Check current stealth mode.
            if ( bInStealth )
                // For the recursion, the PC will have been in stealth mode.
                nMode = HIPS_INSTEALTH;
            else
            {
                // Decrement the timer.
                --nTimer;

                // Did the timer run out?
                if ( nTimer == 0 )
                {    //FloatingTextStringOnCreature("*Stealth Focus Regained!*",oPC);
                    nMode = HIPS_OK;
                    ApplyHiPS(oPC); }
                else if ( GetIsPC(oPC) )
                {    // For the recursion, the PC will be restricted.
                    nMode = HIPS_RESTRICTED;
                    RemoveHiPS(oPC); }
            }
            break;

        case HIPS_RESTRICTED:   // May not enter stealth.
            // Check current stealth mode.
            if ( bInStealth )
            {
                // Pull the PC out of stealth.
                //SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
                // Provide some feedback.
                //SendMessageToPC(oPC,
                //    "<c¥¥¥>[Server] You may not enter stealth mode for another 9 seconds.</c>");
                // The following line will anger your players if you uncomment it. :)
                //DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
                nTimer = HIPS_DELAY;

                //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 2.4);
                // The following line will add unnecessary pizazz if you uncomment it. :)
                //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST), oPC, 1.5);
            }

            // Decrement the timer.
            --nTimer;

            // Did the timer run out?
            if ( nTimer == 0 )
                // End the restriction.
                {nMode = HIPS_OK;
                ApplyHiPS(oPC);}
            break;
    }//switch(nMode)

    // Recursion call in one second.
    DelayCommand(1.0, TK_HiPS_PseudoHeartbeat(oPC, nMode, nTimer));
}
// Call this OnClientEnter.
// oPC should be the entering object, as given by GetEnteringObject().
void TK_HiPS_OnClientEnter(object oPC)
{
    // See if the PC is a HiPSter.
    //if ( GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT, oPC) )
    if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) >= 1 || GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) >= 22) //J. Persinne; shadowdancers no longer have HiPS, so we just check for shadowdancer levels instead.
    {
        // Flag this PC and start the pseudo heartbeat.
        ApplyHiPS(oPC);
        SetLocalInt(oPC, "HIPS_PSEUDOBEAT_RUNNING", TRUE);
        TK_HiPS_PseudoHeartbeat(oPC, HIPS_OK, 0);
        SetLocalInt(oPC,"MothLeftStealth",FALSE);
        SendMessageToPC(oPC,"<c¥¥¥>[Server] Hide in Plain Sight Feats detected. Timer activated.</c>");
    }

}

// Call this when a PC might have gained a feat.
// (e.g., OnPlayerLevelUp and OnEquipItem.)
// If the feat is from an item, the pseudo heartbeat will
// continue after the item is unequipped.
void TK_HiPS_OnFeatChange(object oPC)
{
    int nShadowdancer = GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC);
    int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    int nAssassin = GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC);
    int nNaturalArea = GetIsAreaNatural(GetArea(oPC));
    int nHiPS = GetLocalInt(oPC, "HIPS_PSEUDOBEAT_RUNNING");

    // See if the PC just became a HiPSter.
    if(!nHiPS)
    {
        if(nShadowdancer ||
           nAssassin >= 22 ||
           GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE_EPIC) ||
           GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE_EPIC) ||
           GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE) ||
           GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE) ||
           GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_SPECTRE) ||
           (nRanger >= 35 && nNaturalArea == AREA_NATURAL))
        {
            // Flag this PC and start the pseudo heartbeat.
            ApplyHiPS(oPC);
            SetLocalInt(oPC, "HIPS_PSEUDOBEAT_RUNNING", TRUE);
            TK_HiPS_PseudoHeartbeat(oPC, HIPS_OK, 0);
            SetLocalInt(oPC,"MothLeftStealth",FALSE);
            SendMessageToPC(oPC,"<c¥¥¥>[Server] Hide in Plain Sight Feats detected. Timer activated.</c>");
        }
    }
    else
    {
        if(!nShadowdancer &&
           !nAssassin >= 22 &&
           !GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE_EPIC) &&
           !GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE_EPIC) &&
           !GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE) &&
           !GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE) &&
           !GetIsPolymorphType(oPC, ANPH_POLYMORPH_TYPE_SPECTRE) &&
           !(nRanger >= 35 && nNaturalArea == AREA_NATURAL))
           {
                DeleteLocalInt(oPC, "HIPS_PSEUDOBEAT_RUNNING");
                DeleteLocalInt(oPC,"MothLeftStealth");
                RemoveHiPS(oPC);
                SendMessageToPC(oPC,"<c¥¥¥>[Server] You no longer have Hide in Plain Sight. Timer deactivated.</c>");
           }
    }
}
// Pseudo heartbeat function to enforce delay before re-entering stealth.
// Smaller version -- use if efficiency is of utmost importance.
// nMode is one of the above constants (but not HIPS_NEWLYSEEN).
// nTimer is the number of seconds the PC must wait before re-entering stealth.
//     As with nMode, nTimer is current as of one second ago.
//     (So nTimer == 1 indicates that stealth will be permitted as soon as the
//     current function call ends, but not before.)
// nTimer is only used when the mode is HIPS_RESTRICTED.
/* -- begin comment
void TK_HiPS_PseudoHeartbeat(object oPC, int nMode, int nTimer)
{
    // If the PC no longer exists, cancel the recursion.
    if (!GetIsObjectValid(oPC))
        return;

    // See if the PC is currently in stealth.
    int bInStealth = GetActionMode(oPC, ACTION_MODE_STEALTH);

    // Set the new state of the PC based on the previous state.
    switch ( nMode )
    {
        case HIPS_OK:           // May enter stealth.
            // Check current stealth mode.
            if ( bInStealth )
                // For the recursion, the PC will have been in stealth mode.
                nMode = HIPS_INSTEALTH;
            break;

        case HIPS_INSTEALTH:    // Might leave stealth.
            // Check current stealth mode.
            if ( !bInStealth )
            {
                // For the recursion, the PC will be restricted.
                nMode = HIPS_RESTRICTED;
                // Reset the timer.
                nTimer = HIPS_DELAY;
            }
            break;

        case HIPS_RESTRICTED:   // May not enter stealth.
            // Check current stealth mode.
            if ( bInStealth )
            {
                // Pull the PC out of stealth.
                SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE);
                // Provide some feedback.
                SendMessageToPC(oPC,
                    "You may not enter stealth mode for another " +
                    IntToString(nTimer) + " seconds.");
                // The following line will anger your players if you uncomment it. :)
                //DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 3.0));
                // The following line will add unnecessary pizazz if you uncomment it. :)
                //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST), oPC, 1.5);
            }

            // Decrement the timer.
            --nTimer;

            // Did the timer run out?
            if ( nTimer == 0 )
                // End the restriction.
                nMode = HIPS_OK;
            break;
    }//switch(nMode)

    // Recursion call in one second.
    DelayCommand(1.0, TK_HiPS_PseudoHeartbeat(oPC, nMode, nTimer));
}
-- end comment */
//void main() {}

