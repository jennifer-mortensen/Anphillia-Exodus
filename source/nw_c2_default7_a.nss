#include "hc_inc_npccorpse"
#include "NW_I0_GENERIC"
#include "hc_inc"

#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"

#include "spawn_functions"

void main()
{
    object oKiller = GetLastKiller();
    if(GetLocalString(oKiller, "MY_MASTER_IS") != "")
    {
        // Don't reward XP or anything when a summon did the kill
        object oKillerMaster = GetMaster(oKiller);
        oKiller = oKillerMaster;
    }


    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    else if(GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ANIMAL && !GetIsObjectValid(GetLocalObject(OBJECT_SELF, "ParentSpawn")))
    {
        SetIsDestroyable(FALSE, FALSE, TRUE);
        DelayCommand(30.0,SetIsDestroyable(TRUE, FALSE, TRUE));
    }
    if(!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "ParentSpawn")))
    {
        LeaveCorpse();
    }
    else
    {
        NESS_ProcessDeadCreature(OBJECT_SELF);
        SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF), FALSE);
        SetDroppableFlag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF), FALSE);
    }
    AnphRewardXP (OBJECT_SELF, oKiller);
}

