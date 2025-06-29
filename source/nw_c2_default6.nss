//::///////////////////////////////////////////////
//:: Default On Damaged
//:: NW_C2_DEFAULT6
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    if(GetLocalInt(GetArea(OBJECT_SELF), "MY_PC_COUNT") == -1)
        return;

    object oAttacker = GetLastHostileActor();

    if(!GetFleeToExit())
    {
        if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                {
                    DetermineSpecialBehavior(GetLastDamager());
                }
                else if(GetIsObjectValid(GetLastDamager()))
                {
                    DetermineCombatRound();
                    if(!GetIsFighting(OBJECT_SELF))
                    {
                        object oTarget = GetLastDamager();
                        if(!GetObjectSeen(oTarget) && GetArea(OBJECT_SELF) == GetArea(oTarget))
                        {
                            ActionMoveToLocation(GetLocation(oTarget), TRUE);
                            ActionDoCommand(DetermineCombatRound());
                        }
                    }
                }
            }
            else if (!GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                object oTarget = GetAttackTarget();
                if(!GetIsObjectValid(oTarget))
                {
                    oTarget = GetAttemptedAttackTarget();
                }
                if (GetIsObjectValid(oAttacker) && oTarget != oAttacker && GetIsEnemy(oAttacker) &&
                   (GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4) ||
                    (GetHitDice(oAttacker) - 2) > GetHitDice(oTarget) ) )
                {
                    DetermineCombatRound(oAttacker);
                }
            }
            if (GetIsPC (oAttacker) ||
                GetIsPC (GetMaster (oAttacker)))
            {
                int nDam = GetLocalInt (OBJECT_SELF, "Damaged");
                SetLocalInt(OBJECT_SELF, "Damaged", nDam + 1);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1006));
    }
}
