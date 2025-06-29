//::///////////////////////////////////////////////
//:: Default:On Death
//:: NW_C2_DEFAULT7
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Shouts to allies that they have been killed
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 25, 2001
//:://////////////////////////////////////////////
//#include "hc_inc_npccorpse"
#include "NW_I0_GENERIC"
#include "hc_inc"

#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"

#include "spawn_functions"

void main()
{
    object oKiller = GetLastKiller();
    // Get a controlled undead's master
    if(GetLocalString(oKiller, "MY_MASTER_IS") != "")
    {
        // Don't reward XP or anything when a summon did the kill
        object oKillerMaster = GetMaster(oKiller);
        oKiller = oKillerMaster;

    }
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    if(!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "ParentSpawn")))
    {
        SetIsDestroyable(FALSE, FALSE, TRUE);
        DelayCommand(20.0,SetIsDestroyable(TRUE, FALSE, TRUE));
    }
    else
    {
        NESS_ProcessDeadCreature(OBJECT_SELF);
        SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF), FALSE);
        SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF), FALSE);
    }

    AnphRewardXP (OBJECT_SELF, oKiller);
}

